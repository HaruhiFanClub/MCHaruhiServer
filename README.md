# 凉宫春日的世界服务器 测试版本

#### 版本 4.0.0-alpha.15

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

#### Touhou Little Maid

-   [ ] 凉宫系列人物的模型

### Waterfall

#### 插件

-   [x] Motd
-   [ ] 限制同 IP 多连接

### Yggdrasil

#### Yggdrasil API

-   [ ] 限制临时邮箱注册
-   [ ] 使用 Google 账户登录
-   [ ] 使用 Github 账户登录

### 外部工具

#### CF Utils

-   [x] 从 manifest.json 中读取信息
-   [x] 终端打印出信息表格
-   [x] 自定义键值表明 Mod 的类型(仅服务端/仅客户端/双端)
-   [x] 自定义键值 Mod 文件名
-   [x] 自定义键值 Mod 文件 Hash
-   [x] 自动下载 Mod
-   [x] 根据 Mod 类型下载 Mod
-   [x] Mod 下载完成后根据信息校验文件
-   [ ] 多线程下载
-   [ ] 断点续传

#### 备份工具

-   [x] 本地冷备份(7z)
-   [ ] 本地热备
-   [ ] 异地冷备
