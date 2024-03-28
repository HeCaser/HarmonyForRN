这是一个鸿蒙 Demo
1. 展示鸿蒙接入 RN 的步骤
2. 鸿蒙 & RN 基础开发与测试


2024-03

- 鸿蒙相关开发是白名单机制, 有保密需求, 因此相关文档, SDK 均不上传 github
- 对 RN 的支持严格要求 RN 版本, 三方工具版本, IDE 版本
- [RNForHarmony Demo](https://github.com/HeCaser/RNForHarmony)

## 环境
- DevEco Studio Version: 4.1.3.50
- 工程配置信息

<img src='img/project_config.jpg' width=500>

## 接入步骤

### 加载 har 包
> rnoh 是鸿蒙支持 RN 所需要的工具

- 在工程根目录下新建 libs 文件夹，把 rnoh-4.1.0.300.har 和 sample_package-4.1.0.300.har 放入
  该目录。

<img src='img/libs.jpg' width=400>

- 解压鸿蒙提供的工程, 取其中 `cpp` `ets` `*.json5` 等文件替换当前项目文件

- 通过 `File > Sync and Refresh Project` 来执行 `ohpm install` 命令. 执行完成后会在 entry 目录下生成 `oh_modules` 文件夹

<img src='img/oh-modules.jpg' width=500>

备注: 由于 rnoh 包比较大，这一步耗时会比较长，务必保证 ohpm install 和 IDE 自发的 sync Data
全都完成，否则会导致编译报错。

### 加载本地 bundle 包
- 将 [RNForHarmony Demo](https://github.com/HeCaser/RNForHarmony) 中生成的 bundle 和 assets 文件放置在当前项目的 `entry/src/main/resources/rawfile` 目录下

- 