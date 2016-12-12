//
//  Macro.h
//  iDraw
//
//  Created by 翁志方 on 15/4/3.
//  Copyright (c) 2015年 WZF. All rights reserved.
//

#ifndef iDraw_Macro_h
#define iDraw_Macro_h


#define ScreenBounds [UIScreen mainScreen].bounds
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width

#define RGB(r,g,b)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define RGBA(r,g,b,a)     [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

#define SKY_BLUE RGB(96,201,248)

#define FOR_I(x) for(int i=0; i<(x); ++i)

#define FOR_J(x) for(int j=0; j<(x); ++j)


#endif
