---
layout: single
author_profile: false
title: ToyOS
permalink: /
---

ToyOS 是一套面向教学与实验的操作系统，包含裸机内核 **ToyKernel**、UEFI 引导 **ToyBoot**，以及镜像与启动脚本 **ToyImage**。

加电后的路径大致是：

```text
OVMF（UEFI）→ ToyBoot（BOOTX64.EFI）→ ToyKernel → 桌面 / Shell / 用户程序
```

## 能做什么

- **内核基础**：虚拟内存、Ring 3 用户态、进程（`exec` / `fork` / `wait` 等）
- **存储**：ATA / AHCI / NVMe，GPT + FAT，文件浏览器
- **图形界面**：多窗口 GUI、主题与设置（教学级）
- **网络**：virtio-net，用户态 socket / DNS
- **跨架构**：x86-64 为主，Arm64 / RISC-V virt 亦可跑通
- **真机**：可在 UEFI PC（如 NUC）上从 U 盘启动

## 适合谁

想动手理解操作系统如何启动、如何管内存与进程、如何写驱动和应用的同学；也适合当作课设或自学实验平台。

---

谭老师 · [哔哩哔哩](https://space.bilibili.com/41036636)
