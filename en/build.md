---
layout: single
title: Build
permalink: /en/build/
author_profile: false
classes: wide
toc: true
locale: en
ref: build
---

The shortest path is QEMU: one script in the image repo brings up UEFI → Boot → Kernel → desktop.

```bash
git clone https://github.com/tanlaoshi/ToyImage.git
cd ToyImage && ./Scripts/run-split.sh
# on the desktop: exec HELLO.ELF
```

Real-machine USB (short form): sync Boot/Kernel onto a FAT volume with ToyImage scripts, point UEFI at `BOOTX64.EFI`. Day-to-day NUC installs use the in-tree sync scripts — do not flash your host ESP by mistake. Details live with the ToyImage scripts.

For apps, unpack the SDK, `make` an ELF outside the tree, then `exec` it — you need not build the kernel first to change user space.

Three-arch builds (from the ToyOS root after `source`ing the env):

```bash
./Scripts/build.sh
./Scripts/build.sh arm64
./Scripts/build.sh riscv
```

Get x86 green before opening arm64/riscv, so three failure modes do not tangle. Keep full build logs — the last line alone is rarely enough.
