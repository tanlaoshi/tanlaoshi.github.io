---
layout: single
title: 驱动
permalink: /drivers/
author_profile: false
toc: true
---

真机路径已经能摸到存储、输入、有线/无线网和显示。课上用的不是“示意驱动”，而是 Probe 得着、Bind 得上的那一套。

| 设备 | 驱动名 | 状态 |
| ---- | ------ | ---- |
| 存储 | ata-pio / ahci / nvme / virtio-blk | 真机 ✅ |
| 输入 | xhci-hid / ps2-kbd / ehci / uhci / virtio-input | 真机 ✅ |
| 网络 | virtio-net / e1000 / e1000e / i219 / alx / r8169 / iwl8265 | 真机 ✅ |
| 显示 | GOP / ramfb / igpu blitter | 真机 ✅ |

框架侧统一 **TOY_DRIVER**：登记、**Probe / Match / Bind**，再挂上该类设备的 ops。匹配规则与命名以驱动开发指南为准，避免“能编进内核却挂不上树”。

加一个驱动可以记成五步：

1. 从 `_template` 拷出骨架，改名字与匹配键  
2. 实现 Probe（看得见设备）与 Match（认得出自己）  
3. Bind 时挂上类 ops（块 / 网 / HID…）  
4. 编进对应 Arch 的驱动表，QEMU 或真机冒烟  
5. 同步文档与 `lsdev` 可见性，别让下一班找不到入口  

新设备优先走框架，不要在 Shell 里开旁路。
