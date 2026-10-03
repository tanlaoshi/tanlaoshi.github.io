---
layout: single
title: 架构
permalink: /architecture/
author_profile: false
toc: true
---

ToyOS 按层切开：用户态只经 syscall 进核；Services 搭在 Core / Library / Font / HAL 上；HAL 收拢本架构驱动；Boot 只负责填好 `BOOT_INFO` 再交棒。

```text
User  ──syscall──►  Core / Services
Services ────────►  Core / Library / Font / Hal
Core ────────────►  Library / Font / Hal / BootInfo
HAL ─────────────►  本 Arch Drivers
Boot ────────────►  BOOT_INFO → Kernel
```

同一套源码树可编 **x86_64 / arm64 / riscv**。用户可见 syscall 在段内双轨：**ToyOS ×00–×49**，**POSIX ×50–×99**——课上既能讲本色接口，也能对标熟悉的号段。

可替换模块不靠改内核正文拼装：调度 / 分配 / 文件系统分别挂 **SCHEDULER_OPS / MEMORY_OPS / FS_OPS**。换实现时改配置与模块，不把整棵 Core 撕开。细节以技术手册分层节为准；这里只给人建立地图。
