//
//  UIViewController+HHCustom.h
//  HannahCategory
//
//  Created by MXTH on 2018/6/11.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HHCustom)

@property (assign, nonatomic) CGFloat hh_navBarBgAlpha;

//hhBgV 坐标原点从导航栏下方开始 底部去除安全区域高度
@property (nonatomic, strong) UIView *hh_Bg;

//导航栏上添加阴影效果
@property (nonatomic, assign) BOOL hh_navShadow;
@property (nonatomic, assign) BOOL hh_pushed;
@property (nonatomic, weak) UITabBarController *hh_tabVC;

//下面这两个属性是用来避免当前视图已经消失 弹窗依然弹出的问题
@property (nonatomic, assign) BOOL currentUsing;
@property (nonatomic, assign) BOOL loadFinished;
@property (nonatomic, assign) BOOL loading;


- (void)hh_dropShadowWithOffset:(CGSize)offset
                         radius:(CGFloat)radius
                          color:(UIColor *)color
                        opacity:(CGFloat)opacity;

- (void)hh_shadowNavRelativeSet;

@end
