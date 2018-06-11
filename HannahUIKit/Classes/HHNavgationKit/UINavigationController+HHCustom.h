//
//  UINavigationController+HHCustom.h
//  HannahCategory
//
//  Created by MXTH on 2018/6/8.
//

#import <UIKit/UIKit.h>
#import "UIViewController+HHCustom.h"

@interface UINavigationController (HHCustom)<UINavigationBarDelegate,UINavigationControllerDelegate>

@property (nonatomic, assign) BOOL hh_supportLeftBack;
@property (nonatomic, strong) UIImageView *hh_navHairLine;

/**
 下面这两个属性都是 使用设置导航背景图片的方式来更改导航背景色与导航透明实现
 */
@property (nonatomic, assign) BOOL hh_navBarClear;
@property (nonatomic, strong) UIColor *hh_navBgColor;



/**
 使用设置导航背景图片的方式

 @param alpha 透明度
 */
- (void)hh_setNavBgAlpha:(CGFloat)alpha;
- (UIImage *)imageWithColor:(UIColor *)color;

- (void)hh_dropShadowWithOffset:(CGSize)offset
                         radius:(CGFloat)radius
                          color:(UIColor *)color
                        opacity:(CGFloat)opacity;


//MARK: 背景色通过更改barTintColor的方式 及 透明度直接更改系统导航背景透明度
- (void)hh_setBarTintColor:(UIColor *)barTintColor;
- (void)hh_setTitleWithColor:(UIColor *)titleColor font:(UIFont *)font;
- (void)hh_setBarItemColor:(UIColor *)itemTintColor;
- (void)hh_setBarItemWithColor:(UIColor *)color font:(UIFont *)font;
- (void)hh_setNavBarAlpha:(CGFloat)alpha;

@end



