---
layout: single
title: Architecture
permalink: /en/architecture/
author_profile: false
classes: wide
toc: true
locale: en
ref: architecture
---

ToyOS is cut into layers: user space reaches the kernel only through syscalls; Services sit on Core / Library / Font / HAL; HAL owns arch-specific drivers; Boot fills `BOOT_INFO` and hands off.

```text
User  ──syscall──►  Core / Services
Services ────────►  Core / Library / Font / Hal
Core ────────────►  Library / Font / Hal / BootInfo
HAL ─────────────►  this Arch's Drivers
Boot ────────────►  BOOT_INFO → Kernel
```

One source tree builds for **x86_64 / arm64 / riscv**. User-visible syscalls are dual-track in the same number space: **ToyOS ×00–×49**, **POSIX ×50–×99** — native interfaces for class, familiar numbers for comparison.

Swappable modules are not wired by editing Core wholesale: scheduler / allocator / filesystem hang off **SCHEDULER_OPS / MEMORY_OPS / FS_OPS**. Swap an implementation by config and module, without tearing the tree apart. Details live in the technical handbook; this page is the map.
