//
//  Thinking.h
//  iDraw
//
//  Created by 翁志方 on 15/6/29.
//  Copyright (c) 2015年 WZF. All rights reserved.
//

#ifndef iDraw_Thinking_h
#define iDraw_Thinking_h


1. 绘图封装成一个全局单例

    对应的绘图命令封装成 宏定义 对外开放

2.


1. 定义一个全局单例 海龟
2. 使用 DRAWINVIEW(view) 初始化绘图参数
3. 然后所有的 FD BK 等命令的封装全部使用海龟单例来做
4. 


Q：
1. 怎么解决在多处绘制的问题，即初始化多只海龟的问题？
        即 FD(X) 这个宏怎么解决绘制在哪个view上的问题？

    通过新建一个路径么？  出栈进栈操作来实现，即所有的操作,画出实现的流程图
    路径生成与绘制分离，调用 DRAWINVIEW(view) 初始化绘图参数,

2.




提供一个现实动画曲线函数示意图



#endif
