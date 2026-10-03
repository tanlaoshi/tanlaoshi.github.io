---
layout: single
title: Drivers
permalink: /en/drivers/
author_profile: false
classes: wide
toc: true
locale: en
ref: drivers
---

On real hardware we already reach storage, input, wired/wireless NIC, and display. Class work uses drivers that Probe and Bind — not slideware stubs.

| Device | Drivers | Status |
| ------ | ------- | ------ |
| Storage | ata-pio / ahci / nvme / virtio-blk | real HW ✅ |
| Input | xhci-hid / ps2-kbd / ehci / uhci / virtio-input | real HW ✅ |
| Network | virtio-net / e1000 / e1000e / i219 / alx / r8169 / iwl8265 | real HW ✅ |
| Display | GOP / ramfb / igpu blitter | real HW ✅ |

The framework is unified **TOY_DRIVER**: register, **Probe / Match / Bind**, then attach class ops. Matching rules follow the driver guide so a driver that links is not silently unbound.

Adding a driver in five steps:

1. Copy the `_template`, rename, set match keys  
2. Implement Probe (see the device) and Match (claim it)  
3. On Bind, attach class ops (block / net / HID…)  
4. Register in the arch driver table; smoke on QEMU or real HW  
5. Keep docs and `lsdev` in sync so the next class can find the entry  

Prefer the framework for new devices — do not open side doors from the Shell.
