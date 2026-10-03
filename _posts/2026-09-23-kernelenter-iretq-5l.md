---
layout: single
title: "KernelEnter 改成 iretq 之后，为什么会 #UD"
date: 2026-09-23 20:00:00 +0800
categories:
author_profile: true
share: true
locale: zh-CN
ref: kernelenter-iretq
excerpt: "我想让内核任务也能在 IF=1 下跑：把 KernelEnter 从「跳进去」改成 iretq 恢复上下文。NUC 上却反复出现拖窗不跟手、store remove 卡死，甚至 #UD / #PF，严重时整机 Reset。目标很清楚，路却走得很难看。"
---

## 现象

我想让内核任务也能在 `IF=1` 下跑：把 `KernelEnter` 从「跳进去」改成 `iretq` 恢复上下文，好和用户态抢占模型对齐。NUC 上却反复出现拖窗不跟手、`store remove` 卡死，甚至 `#UD` / `#PF`，严重时整机 Reset。目标很清楚，路却走得很难看。

## 初始假说

最初假说很直接：只要 `KernelEnter` 走 `iretq`，RFLAGS 带上 IF，中断就能进得来，输入和块设备就不会在长临界区里饿死。此前用 `jmp` 进核等于把内核任务钉在关中断世界里——这能解释 InputTask 被饿、装卸包时鼠标假死。

## 尝试与失败

裸切 `iretq` 第一次上 NUC，就在 `PickNext` 读 idle 状态时 `#PF`，然后 combo Reset。我否定的是「改一个入口指令就完事」。

后面按一刀一假说拆：加固 idle 指针、加校验、去掉 PickNext 外层 cli、对内核只置 `NeedResched` 再在 Breath 点 CondResched、给 StoreRemove 整段禁抢占、块 IO 包 `IrqSave`、Breath 里不再 yield……每一刀都能否定掉一条当时很像的故事：

- 去掉全程 cli：拖窗好一点，remove 仍可能卡——不是「单纯 cli 太凶」就能概括。  
- 内核软切 + CondResched：出现约一秒一次的整机顿挫，像在 `hlt` 上等整拍——这条路径否了。  
- 「remove 卡是因为硬切打断 Fat/Store」：禁切后 remove 仍卡——假说否证。  
- 块层大面积 cli：还是卡，还疑超时。  
- 串口埋点才把现场钉住：`rm:in` 之后风暴式 `PickNext bad idle`，再撞上 MSC bulk 失败。  
- 用 `gIdleSlot` 收住 idle 指针后，bad idle 风暴没了，却冒出 `#UD`——说明腐坏指针是真问题之一，但不是最后那块骨头。

这些失败我都留着：它们证明「IF=1 + iretq」不是插上开关，而是一串恢复语义必须同时正确。

## 转折

转折出现在把 `#UD` 和栈布局放到同一张纸上。`iretq` 从内核栈弹回时，硬件期望的帧布局和「我以为的 StackTop」不是一回事。若入核时缺了伪返回槽，RSP 对不齐，弹出的 CS/SS/RIP 会变成垃圾，表现可以是 `#UD`，也可以是更晚的诡异 `#GP`。

## 根因

根因是：**`iretq` 入核缺少伪返回，RSP 必须对齐到 `StackTop-8`**。没有这 8 字节槽位，返回帧从一开始就歪了；前面那些卡顿、坏 idle、甚至部分 `#PF`，有的是并发暴露，有的是栈语义错误的下游症状。补上伪返回并固定 `gIdleSlot` 后，NUC 上 `store remove demopack` 能正常结束，装卸期间鼠标也不再整段假死。

## 教训

- 全局抢占 / `KernelEnter`→`iretq` 这类刀，禁止和网卡大改同刀；中断模型一变，所有 IO 症状会缠在一起。  
- 一刀一假说，失败也要写清否定了什么；「再开一次 iretq」本身不是假说。  
- 入口指令、栈帧、idle 寿命、禁切范围是四条线，不要假设改对其中一条就能绿。  
- 真机手测不可省：QEMU 过了仍可能在 NUC 上 `#UD`。串口最后一行往往比猜更值钱。
