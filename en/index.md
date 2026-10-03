---
layout: single
author_profile: false
title: Home
permalink: /en/
classes: wide
locale: en
ref: home
description: "ToyOS: a full system stack from UEFI to the desktop — all source readable and changeable"
---

ToyOS: a full system stack from UEFI to the desktop — all source readable and changeable.

![ToyOS desktop screenshot (to be added)]({{ '/assets/screenshots/desktop.png' | relative_url }})

Shortest path to a running desktop:

```bash
git clone https://github.com/tanlaoshi/ToyImage.git
cd ToyImage && ./Scripts/run-split.sh
# on the desktop: exec HELLO.ELF
```

Swappable modules — change the implementation without touching core kernel lines:

```text
Scheduler? SCHEDULER=priority
Allocator? MEMORY=bestfit
Filesystem? FS=ram
```

- [Architecture]({{ '/en/architecture/' | relative_url }}) · [Drivers]({{ '/en/drivers/' | relative_url }}) · [Build]({{ '/en/build/' | relative_url }}) · [Classroom]({{ '/en/classroom/' | relative_url }}) · [About]({{ '/en/about/' | relative_url }}) · [Blog]({{ '/en/blog/' | relative_url }})
