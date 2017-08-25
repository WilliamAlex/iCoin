//
//  macro.h
//  icoins
//
//  Created by Alex Williams on 2017/8/15.
//  Copyright © 2017年 srgbank. All rights reserved.
//

#ifndef macro_h
#define macro_h


/************屏幕宽高**************/
#define ABScreenWidth  ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.width : [[UIScreen mainScreen] bounds].size.height)

#define ABScreenHeight  ((([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)) ? [[UIScreen mainScreen] bounds].size.height : [[UIScreen mainScreen] bounds].size.width)

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width
#define ABScreenSize [UIScreen mainScreen].bounds.size
#define SCREEN_BOUNDS  [UIScreen mainScreen].bounds


/************字体相关**************/
//中文字体
#define CHINESE_FONT_NAME  @"PingFang-SC-Regular"
#define CHINESE_SYSTEM(x) [UIFont fontWithName:CHINESE_FONT_NAME size:x]

// 不同屏幕尺寸字体适配（320,568是因为效果图为IPHONE5 如果不是则根据实际情况修改）iphone6 375x667
#define kScreenWidthRatio  (Main_Screen_Width / 375.0)
#define kScreenHeightRatio (Main_Screen_Height / 667.0)
#define AdaptedWidth(x)  ceilf((x) * kScreenWidthRatio)
#define AdaptedHeight(x) ceilf((x) * kScreenHeightRatio)
#define AdaptedFontSize(R)     CHINESE_SYSTEM(AdaptedWidth(R))


/************RGB颜色相关**************/
#define WGRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define WGRGBAColor(r, g, b, a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define WGSameColor(r) WGRGBColor(r, r, r)


/************调试相关**************/
#ifdef DEBUG
# define ABLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define ABLog(...);
#endif

/**声明这个宏定义,主要是用于Masonry中的block中(防止循环引用)*/
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

// 获取bundle中文件的路径
#define QJPathResoce(name) [[[NSBundle mainBundle] pathForResource:@"QJSettingTableView.bundle" ofType:nil] stringByAppendingPathComponent:name]

#define keyWindow [UIApplication sharedApplication].keyWindow




#endif /* macro_h */











