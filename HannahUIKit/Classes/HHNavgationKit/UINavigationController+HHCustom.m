//
//  UINavigationController+HHCustom.m
//  HannahCategory
//
//  Created by MXTH on 2018/6/8.
//

#import "UINavigationController+HHCustom.h"
#import <objc/runtime.h>


@implementation UINavigationController (HHCustom)

static char *supportLeftBackKey = "supportLeftBackKey";
static char *navBgColorKey = "navBgColorKey";
static char *navBarClearKey = "navBarClearKey";
static char *navHairLineKey = "navHairLineKey";


- (void)setHh_supportLeftBack:(BOOL)hh_supportLeftBack{
    objc_setAssociatedObject(self, supportLeftBackKey, @(hh_supportLeftBack), OBJC_ASSOCIATION_ASSIGN);
    self.interactivePopGestureRecognizer.enabled = hh_supportLeftBack;
}

- (BOOL)hh_supportLeftBack{
    return [objc_getAssociatedObject(self, supportLeftBackKey) boolValue];
}

#pragma mark 背景颜色
- (void)setHh_navBgColor:(UIColor *)hh_navBgColor{
        UIColor *color = self.hh_navBgColor?hh_navBgColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        //    color = [UIColor colorWithWhite:1 alpha:alpha];
        color = [UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:components[3]];
        [self.navigationBar setBackgroundImage:[self imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
    objc_setAssociatedObject(self, navBgColorKey, hh_navBgColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)hh_navBgColor{
    return objc_getAssociatedObject(self, navBgColorKey);
}

- (UIImage *)imageWithColor:(UIColor *)color{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage *imgae = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return imgae;
}
#pragma mark 透明度
- (void)setHh_navBarClear:(BOOL)hh_navBarClear{
    [self willChangeValueForKey:@"hh_navBarClear"];
    objc_setAssociatedObject(self, navBarClearKey, @(hh_navBarClear), OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"hh_navBarClear"];
    
    [self hh_setNavBgAlpha:hh_navBarClear?0:1];
    UIImageView *hairLine = [self findHairlineImageViewUnder:self.navigationBar];
    hairLine.hidden = hh_navBarClear;
}

- (void)hh_setNavBgAlpha:(CGFloat)alpha{
    UIColor *color = self.hh_navBgColor?self.hh_navBgColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    //    color = [UIColor colorWithWhite:1 alpha:alpha];
    color = [UIColor colorWithRed:components[0] green:components[1] blue:components[2] alpha:alpha];
    [self.navigationBar setBackgroundImage:[self imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
}

- (BOOL)hh_navBarClear{
    return [objc_getAssociatedObject(self, navBarClearKey) boolValue];
}

//TODO: 导航的线条
- (UIImageView *)hh_navHairLine{
    UIImageView *hairLine = objc_getAssociatedObject(self, navHairLineKey);
    hairLine = [self findHairlineImageViewUnder:self.navigationBar];
    return hairLine;
}

- (void)setHh_navHairLine:(UIImageView *)hh_navHairLine{
    UIImageView *hairLine = [self findHairlineImageViewUnder:self.navigationBar];
    objc_setAssociatedObject(self, navHairLineKey, hairLine, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)hh_dropShadowWithOffset:(CGSize)offset
                         radius:(CGFloat)radius
                          color:(UIColor *)color
                        opacity:(CGFloat)opacity{
    
    self.navigationBar.layer.shadowColor = color.CGColor;
    self.navigationBar.layer.shadowOffset = offset;
    self.navigationBar.layer.shadowRadius = radius;
    self.navigationBar.layer.shadowOpacity = opacity;
    
    //    self.navigationController.navigationBar.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.navigationController.navigationBar.bounds].CGPath;
    //
    //    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    //    self.navigationBar.clipsToBounds = NO;
}

#pragma mark **********************************************
//MARK: 背景色通过更改barTintColor的方式 及 透明度直接更改系统导航背景透明度
- (void)hh_setBarTintColor:(UIColor *)barTintColor{
    self.navigationBar.barTintColor = barTintColor;
    
}

- (void)hh_setTitleWithColor:(UIColor *)titleColor font:(UIFont *)font{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (titleColor) {
        [params setObject:titleColor forKey:NSForegroundColorAttributeName];
    }
    if (font) {
        [params setObject:font forKey:NSFontAttributeName];
    }
    
    if (params.allKeys.count > 0) {
        [self.navigationBar setTitleTextAttributes:params];
    }
}

- (void)hh_setBarItemColor:(UIColor *)itemTintColor{
    self.navigationItem.leftBarButtonItem.tintColor = itemTintColor;
    self.navigationItem.rightBarButtonItem.tintColor = itemTintColor;
}
- (void)hh_setBarItemWithColor:(UIColor *)color font:(UIFont *)font{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (color) {
        [params setObject:color forKey:NSForegroundColorAttributeName];
    }
    if (font) {
        [params setObject:font forKey:NSFontAttributeName];
    }
    
    if (params.allKeys.count > 0) {
        [self.navigationItem.leftBarButtonItem  setTitleTextAttributes:params forState:UIControlStateNormal];
        [self.navigationItem.rightBarButtonItem  setTitleTextAttributes:params forState:UIControlStateNormal];
    }
}
- (void)hh_setNavBarAlpha:(CGFloat)alpha{
    if([UIDevice currentDevice].systemVersion.doubleValue <=10){
        NSArray *subviews =self.navigationBar.subviews;
        for (id viewObj in subviews) {
            NSString *classStr = [NSString stringWithUTF8String:object_getClassName(viewObj)];
            if ([classStr isEqualToString:@"_UINavigationBarBackground"]) {
                UIImageView *imageView=(UIImageView *)viewObj;
                imageView.alpha=alpha;
                break;
            }
        }
    }else{
        //                NSArray *subviews =self.navigationBar.subviews;
        //                for (id viewObj in subviews) {
        //                    NSString *classStr = [NSString stringWithUTF8String:object_getClassName(viewObj)];
        //                    if ([classStr isEqualToString:@"_UIBarBackground"]) {
        //                        UIImageView *imageView=(UIImageView *)viewObj;
        //                        imageView.alpha=alpha;
        //                        return;
        //                    }
        //                }
        //            }
        
        UIView* barBackgroundView = [[self.navigationBar subviews] objectAtIndex:0];
        UIImageView* backgroundImageView = [[barBackgroundView subviews] objectAtIndex:0];
        
        if(self.navigationBar.isTranslucent){
            if(backgroundImageView !=nil && backgroundImageView.image !=nil){
                barBackgroundView.alpha = alpha;
            }else{
                UIView* backgroundEffectView = [[barBackgroundView subviews] objectAtIndex:1];
                if(backgroundEffectView !=nil){
                    backgroundEffectView.alpha = alpha;
                }
            }
        }else{
            barBackgroundView.alpha = alpha;
        }
        self.navigationBar.clipsToBounds = alpha == 0.0;
    }
}

#pragma mark ****** 透明度处理  ******

+ (void)initialize{
    if (self == [UINavigationController class]) {
        SEL originalSelector = NSSelectorFromString(@"_updateInteractiveTransition:");
        SEL swizzledSelector = NSSelectorFromString(@"hh_updateInteractiveTransition:");
        Method originalMethod = class_getInstanceMethod([self class], originalSelector);
        Method swizzledMethod = class_getInstanceMethod([self class], swizzledSelector);
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

//交换的方法，监控滑动手势
- (void)hh_updateInteractiveTransition:(CGFloat)percentComplete{
    [self hh_updateInteractiveTransition:percentComplete];
    UIViewController *topVC = self.topViewController;
    if (topVC != nil) {
        id<UIViewControllerTransitionCoordinator> coor = topVC.transitionCoordinator;
        if (coor != nil) {
            //随着滑动的过程设置导航栏透明度渐变
            CGFloat fromAlpha = [coor viewControllerForKey:UITransitionContextFromViewControllerKey].hh_navBarBgAlpha;
            CGFloat toAlpha = [coor viewControllerForKey:UITransitionContextFromViewControllerKey].hh_navBarBgAlpha;
            CGFloat nowAlpha = fromAlpha + (double)(toAlpha-fromAlpha)*percentComplete;
            
            if (self.hh_navBgColor) {
                [self hh_setNavBgAlpha:nowAlpha];
            }else{
                [self hh_setNavBarAlpha:nowAlpha];
            }
            
        }
    }
}

- (void)dealInteractionChanges:(id<UIViewControllerTransitionCoordinatorContext>)context{
    if ([context isCancelled]) {//自动取消了返回手势
        NSTimeInterval cancleDuration = context.transitionDuration * context.percentComplete;
        [UIView animateWithDuration:cancleDuration animations:^{
            CGFloat nowAlpha = [context viewControllerForKey:UITransitionContextFromViewControllerKey].hh_navBarBgAlpha;
            
            if (self.hh_navBgColor) {
                [self hh_setNavBgAlpha:nowAlpha];
            }else{
                [self hh_setNavBarAlpha:nowAlpha];
            }
            
        }];
        
    }else{
        NSTimeInterval finishDuration = context.transitionDuration *(double)(1-context.percentComplete);
        [UIView animateWithDuration:finishDuration animations:^{
            CGFloat nowAlpha = [context viewControllerForKey:UITransitionContextToViewControllerKey].hh_navBarBgAlpha;
            
            if (self.hh_navBgColor) {
                [self hh_setNavBgAlpha:nowAlpha];
            }else{
                [self hh_setNavBarAlpha:nowAlpha];
            }
        }];
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    UIViewController *topVC = self.topViewController;
    if (topVC != nil) {
        id<UIViewControllerTransitionCoordinator> coor = topVC.transitionCoordinator;
        if (coor != nil) {
            
            if (@available(iOS 10.0, *)) {
                [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                    [self dealInteractionChanges:context];
                }];
            } else {
                
                [coor notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                    [self dealInteractionChanges:context];
                }];
            }
          
        }
    }
}

#pragma mark UINavigationBarDelegate
- (void)navigationBar:(UINavigationBar *)navigationBar didPopItem:(UINavigationItem *)item{
    if (self.viewControllers.count >= navigationBar.items.count) {
        UIViewController *popToVC = self.viewControllers[self.viewControllers.count -1];
        [self hh_setNavBgAlpha:popToVC.hh_navBarBgAlpha];
    }
}

- (void)navigationBar:(UINavigationBar *)navigationBar didPushItem:(UINavigationItem *)item{
    [self hh_setNavBgAlpha:self.topViewController.hh_navBarBgAlpha];
}

#pragma mark ****** 透明度处理 end ******


@end



