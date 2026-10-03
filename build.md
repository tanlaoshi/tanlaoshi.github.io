---
layout: single
title: 构建
permalink: /build/
author_profile: false
classes: wide
toc: true
locale: zh-CN
ref: build
---

最短路径是 QEMU：镜像仓里一条脚本拉起 UEFI → Boot → Kernel → 桌面。

```bash
git clone https://github.com/tanlaoshi/ToyImage.git
cd ToyImage && ./Scripts/run-split.sh
# 桌面里：exec HELLO.ELF
```

真机刷 U 盘（简版）：用 ToyImage 脚本把 Boot/Kernel 同步到 FAT 分区，UEFI 启动项指到 `BOOTX64.EFI`；NUC 日常路径用仓库里的 sync 脚本，不要误刷本机 ESP。细节以 ToyImage 脚本说明为准。

应用侧可解压 SDK 后在树外 `make` 出 ELF，再 `exec` 进系统——课上改用户态不必先会编内核。

三架构编译（在 ToyOS 树根、环境已 `source` 的前提下）习惯是：

```bash
./Scripts/build.sh
./Scripts/build.sh arm64
./Scripts/build.sh riscv
```

先 x86 跑通再开 arm64/riscv，避免三条链路的问题缠在一起。构建失败时保留完整日志，比只贴最后一行有用。
