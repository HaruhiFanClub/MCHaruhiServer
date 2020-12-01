# 凉宫春日的世界服务器 测试版本

#### 版本 4.0.0-alpha.18

此分支用于正在测试中的服务器四周目版本. 四周目预计在 2021 年 1 月 1 日或 2021 年 2 月 1 日正式开始.

## Task Lists

### 游戏服务端&客户端

#### 基本

-   [x] 无 Mod/插件测试
-   [ ] 挑选 Mod

#### CrT & CoT

-   [x] 新增方块下界之星块
-   [x] 死亡点传送装置
-   [x] 登入次数记录功能
-   [x] 实体信息工具与实体清除工具 ~~(物理学圣剑)~~
-   [ ] 凉宫系列物品
-   [ ] 自定义传送门方块

#### Touhou Little Maid

-   [ ] 凉宫系列人物的模型

### Waterfall

#### 插件

-   [x] Motd
-   [x] 限制同 IP 多连接

### Yggdrasil

#### Yggdrasil API

-   [ ] 限制临时邮箱注册
-   [x] 使用 Google 账户登录
-   [x] 使用 Github 账户登录

### 外部工具

#### CF Utils

-   [x] 从 manifest.json 中读取信息
-   [x] 终端打印出信息表格
-   [x] 自定义键值表明 Mod 的类型(仅服务端/仅客户端/双端)
-   [ ] 信息: 自动生成 Markdown、HTML 格式的 Mod 列表
-   [ ] 信息: 命令行参数选择是否同步从 CurseForgeAPI 获取更多信息
-   [ ] ~~自定义键值 Mod 文件名~~
-   [ ] ~~自定义键值 Mod 文件 Hash~~
-   [x] 下载: 自动下载 Mod
-   [x] 下载: 根据 Mod 类型下载 Mod
-   [x] 下载: Mod 下载完成后根据 ETag 中的 MD5 校验文件
-   [x] 下载: 命令行参数选择是否覆盖同名文件
-   [x] 下载: 多线程下载
-   [ ] 下载: 异步下载
-   [ ] 下载: 断点续传
-   [x] 格式化: 根据 Project ID 排序 files 列表

#### 备份工具

-   [x] 本地冷备份(7z)
-   [ ] 本地热备
-   [x] 异地冷备

### Wiki 站

-   [ ] 双向同步工具
