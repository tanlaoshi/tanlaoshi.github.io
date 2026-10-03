# ToyOS 官网（本站）PR 拆分

> **落点**：本仓库（`tanlaoshi.github.io` / tanyugang.com），主题保持 **Minimal Mistakes**（`remote_theme`），不新建 Minima 站、不建 `~/toyos-site`。  
> **不改**：ToyKernel 代码、路线图。  
> **流程暗号**：内容分刀；**发** = TG+TS。

## 柱目标

| 项 | 说明 |
| -- | ---- |
| 主题 | Minimal Mistakes（当前配置） |
| 页面 | 首页 + 架构 / 驱动 / 构建 / 课堂 / 关于 + 博客列表 |
| 博客 | 3 篇示例（刀史素材自 Documents，**不改路线图**） |
| 部署 | 已有 GitHub Pages；本柱只推内容 |

## PR 拆分

| PR | 内容 | 验收 | 状态 |
| -- | ---- | ---- | ---- |
| **PR-SITE-1** | 导航 + 6 页 + `blog` 列表 + 截图占位；介绍页不挂博文；页脚 Feed 旁哔哩哔哩 | 本地打开首页、架构页 | ✅ TG+TS `cc46a34` |
| **PR-SITE-2** | 3 篇示例博客（i219 / KernelEnter / iwl8265） | 标题 + 首段过目；字数 ≤1500 | ★ 当前（JX 已写，等 **TG**） |
| **PR-SITE-3** | 随 PR-SITE-2 的 **TG+TS** 一并推送亦可 | 线上 6 页 + 3 博客可打开 | 排队（等「发」或对博客说 **TG TS**） |

## 页面 ↔ 路径

| 页 | 路径 |
| -- | ---- |
| 首页 | `/` |
| 架构 | `/architecture/` |
| 驱动 | `/drivers/` |
| 构建 | `/build/` |
| 课堂 | `/classroom/` |
| 关于 | `/about/` |
| 博客列表 | `/blog/`（保留 `/posts/` 兼容亦可） |

## 收口必报（整柱）

- 要不要手测：**要**（打开 Pages URL 看 6 页 + 3 博客）
- 是否碰内核代码：**否**
- 是否改路线图：**否**
- 仓库 URL：`https://github.com/tanlaoshi/tanlaoshi.github.io`
- 站点 URL：以 `_config.yml` 的 `url` 为准（当前 `https://www.tanlaoshi.com`）
