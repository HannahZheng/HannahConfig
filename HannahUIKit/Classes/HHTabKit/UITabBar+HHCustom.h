//
//  UITabBar+HHCustom.h
//  HannahUIKit
//
//  Created by MXTH on 2018/6/12.
//

#import <UIKit/UIKit.h>

@interface UITabBar (HHCustom)


- (void)hh_hideLine;
- (void)hh_changeLineColor:(UIColor *)lineColor lineHeight:(CGFloat)lineHeight;
//11.0以下在 - (void)viewDidLayoutSubviews 中，11.0中可写在viewDidLoad中
- (void)hh_changeBarHeight:(CGFloat)barHeight;

- (UIImage *)getImageWithHeight:(CGFloat)height color:(UIColor *)color;


- (void)hh_dropShadowWithOffset:(CGSize)offset
                         radius:(CGFloat)radius
                          color:(UIColor *)color
                        opacity:(CGFloat)opacity;


@end
