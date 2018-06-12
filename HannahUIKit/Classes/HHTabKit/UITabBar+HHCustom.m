//
//  UITabBar+HHCustom.m
//  HannahUIKit
//
//  Created by MXTH on 2018/6/12.
//

#import "UITabBar+HHCustom.h"
#import <objc/runtime.h>

@implementation UITabBar (HHCustom)


- (void)hh_hideLine{
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
   //或者
//    [self setBackgroundImage:[self getImageWithHeight:CGFLOAT_MIN color:nil]];
//    [self setShadowImage:[self getImageWithHeight:CGFLOAT_MIN color:nil]];
}
- (void)hh_changeLineColor:(UIColor *)lineColor lineHeight:(CGFloat)lineHeight{
    lineHeight = lineHeight >= 1 ? lineHeight : 1;
        [self setBackgroundImage:[self getImageWithHeight:lineHeight color:lineColor]];
        [self setShadowImage:[self getImageWithHeight:lineHeight color:lineColor]];
}
- (void)hh_changeBarHeight:(CGFloat)barHeight{
    CGRect frame = self.frame;
    frame.size.height = barHeight;
    frame.origin.y = self.frame.size.height - frame.size.height;
    self.frame = frame;
}

- (UIImage *)getImageWithHeight:(CGFloat)height color:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if(color == nil){
        color = [UIColor whiteColor];
    }
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

#pragma mark设置阴影

- (void)hh_dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity {
    
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    self.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.clipsToBounds = NO;
}

@end
