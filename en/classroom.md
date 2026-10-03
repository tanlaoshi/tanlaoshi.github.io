---
layout: single
title: Classroom
permalink: /en/classroom/
author_profile: false
classes: wide
toc: true
locale: en
ref: classroom
---

This course teaches the **full stack from firmware to apps**: how UEFI hands the machine to the kernel, how the kernel manages memory and processes, how drivers attach, and how user programs reach real devices through syscalls. Not slogans alone — hands on readable, changeable source.

Five main tracks (hours compressible by term):

1. **Application development** (8–12 h) — SDK, `exec`, small GUI/network apps  
2. **Kernel implementation** (48–64 h) — memory, scheduling, processes, dual-track syscalls  
3. **Drivers and swappable modules** (32–48 h) — TOY_DRIVER, OPS swaps, real/virt devices  
4. **Real hardware and board bring-up** (32–48 h) — USB/NUC, BootInfo, board differences  
5. **Toolchain and ecosystem** (32–48 h) — build, images, store/packaging, debug notes  

By the end students should deliver: **one app**, **one swappable module (or driver)**, **one real-HW/QEMU write-up**, and a clear account of the **ABI boundary** they used. Full Linux userspace compatibility is not required; one path that runs and can be explained beats a pile of half-features.
