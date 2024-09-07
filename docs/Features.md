# 目标分析

## 总览'

### 首页

![image.png](https://s2.loli.net/2024/09/07/ZGM2UyiLf4oT9Im.png)

共三层结构

- `AppBar` - `Now Solving` 是一个按钮， 返回最近一次存档继续游戏。
- `Container` 选择不同类型的颜色填选，`B&W` 就是纯纯黑白， 其他颜色各异
- `RouteBar` 底部导航栏， 只需设计 `Library`, `Ranking`, `Profile`, 对应: 关卡, 积分榜, 用户个人。

`RouteBar`, 忽略图标细节

![image.png](https://s2.loli.net/2024/09/07/MJe9LyTSNWQbaDY.png)

### 游戏中

主要做游戏界面和上下两个状态栏
主要是画盘功能， 其他功能后面加。

Features

- 画盘
- 游戏界面
- 其他后面加

![image.png](https://s2.loli.net/2024/09/07/4QLwqP69go3ufbt.png)

分别是具有上状态栏， 下状态栏

上状态栏可取消和撤回操作，标记，锁定帮助， 悬浮效果， 显示和隐藏笔盘，暂停

标记效果 **不做**
![image.png](https://s2.loli.net/2024/09/07/5rL7ecVmEFRtsYG.png)

锁定帮助 就是将上面和左边的帮助显示到屏幕中， 会遮挡棋盘- 先不做

![image.png](https://s2.loli.net/2024/09/07/Qul6otqexgkDvKs.png)

悬浮效果

![[https://raw.githubusercontent.com/luckycyang/pix-a-pix/dev/docs/Pasted image 20240907211931.png]]

显示和不显示画盘

![image.png](https://s2.loli.net/2024/09/07/P3z7kjGsid89aJK.png)

不显示画盘时显示当前画笔颜色
![[https://raw.githubusercontent.com/luckycyang/pix-a-pix/dev/docs/Pasted image 20240907212116.png]]

暂停按钮

![image.png](https://s2.loli.net/2024/09/07/oRSqari7U2VYb94.png)

直接答案 (左和上就是关卡答案， 直接遍历出结果)
检查错误 (根据答案看对应格子是否颜色错误， 统计错误格子数量)
重新开始 (关卡数据清零)
关卡信息(随手的事)
设置(先不做)
帮助（这玩意就是官网的游戏帮助）

### 解密成功

![[https://raw.githubusercontent.com/luckycyang/pix-a-pix/dev/docs/Pasted image 20240907213436.png]]

关卡信息

还需要根据添加一个关卡分数
![image.png](https://s2.loli.net/2024/09/07/JBWpTXiZybYwuVn.png)

## 榜单 Ranking

统计当前用户积分， ListView 显示

## 用户 Profile

没登陆就是单机， 登陆了就直接拉数据库的数据到本地。

登陆后的用户过关直接发请求，到数据库更新数据。
