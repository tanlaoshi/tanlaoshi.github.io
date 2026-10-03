---
layout: single
author_profile: false
title: 首页
permalink: /
classes: wide
locale: zh-CN
ref: home
---

ToyOS：从 UEFI 到桌面的完整系统栈，全部源码可读可改。

![ToyOS 桌面截图（待补）]({{ '/assets/screenshots/desktop.png' | relative_url }})

三行最短跑通：

```bash
git clone https://github.com/tanlaoshi/ToyImage.git
cd ToyImage && ./Scripts/run-split.sh
# 进桌面后：exec HELLO.ELF
```

可替换模块，不碰内核一行，换实现：

```text
调度器？SCHEDULER=priority
分配器？MEMORY=bestfit
文件系统？FS=ram
```

- [架构]({{ '/architecture/' | relative_url }}) · [驱动]({{ '/drivers/' | relative_url }}) · [构建]({{ '/build/' | relative_url }}) · [课堂]({{ '/classroom/' | relative_url }}) · [关于]({{ '/about/' | relative_url }}) · [博客]({{ '/blog/' | relative_url }})
