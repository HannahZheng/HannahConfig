//
//  UIViewController+HHCustom.m
//  HannahCategory
//
//  Created by MXTH on 2018/6/11.
//

#import "UIViewController+HHCustom.h"
#import <objc/runtime.h>
#import "UINavigationController+HHCustom.h"

#define HHSafeAreaBottomHeight ({CGFloat i; if(@available(iOS 11.0, *)) {i = [UIApplication sharedApplication].keyWindow.safeAreaInsets.bottom;} else {i = 0;} i;})

@implementation UIViewController (HHCustom)
static char *navBarBgAlphaKey = "navBarBgAlphaKey";
static char *hhBgKey = "hhBgVKey";
static char *navShadowKey = "navShadowKey";
static char *pushedKey = "pushedKey";
static char *tabVCKey = "tabVCKey";


+ (void)load{
    
}

- (void)hh_viewWillAppear:(BOOL)animate{
    
}

- (void)hh_viewWillDisapper:(BOOL)animate{
    
}

#pragma mark 属性

- (void)setHh_navBarBgAlpha:(CGFloat)hh_navBarBgAlpha{
    objc_setAssociatedObject(self, navBarBgAlphaKey, @(hh_navBarBgAlpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)hh_navBarBgAlpha{
    return [objc_getAssociatedObject(self, navBarBgAlphaKey) floatValue];
}

- (void)setHh_Bg:(UIView *)hh_Bg{
    objc_setAssociatedObject(self, hhBgKey, hh_Bg, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)hh_Bg{
    UIView *_hh_Bg = objc_getAssociatedObject(self, hhBgKey);
    if(_hh_Bg == nil){
        _hh_Bg = [[UIView alloc] init];
        _hh_Bg.backgroundColor = [UIColor clearColor];
        _hh_Bg.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:_hh_Bg];
        
        NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:_hh_Bg attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
        
        NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:_hh_Bg attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:-HHSafeAreaBottomHeight];
        
        NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:_hh_Bg attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0];
        
        NSLayoutConstraint *rightConstraint =  [NSLayoutConstraint constraintWithItem:_hh_Bg attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
        
        [_hh_Bg addConstraints:@[topConstraint, bottomConstraint, leftConstraint, rightConstraint]];
        
        objc_setAssociatedObject(self, hhBgKey, _hh_Bg, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    
    return _hh_Bg;
}

- (void)setHh_navShadow:(BOOL)hh_navShadow{
    objc_setAssociatedObject(self, navShadowKey, @(hh_navShadow), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)hh_navShadow{
    return objc_getAssociatedObject(self, navShadowKey);
}

- (void)setHh_pushed:(BOOL)hh_pushed{
    objc_setAssociatedObject(self, pushedKey, @(hh_pushed), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)hh_pushed{
    return objc_getAssociatedObject(self, pushedKey);
}

- (void)setHh_tabVC:(UITabBarController *)hh_tabVC{
    objc_setAssociatedObject(self, tabVCKey, hh_tabVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UITabBarController *)hh_tabVC{
    UITabBarController *_tabVC = objc_getAssociatedObject(self, tabVCKey);
    if(_tabVC == nil){
        UIWindow * window = [[UIApplication sharedApplication] keyWindow];
        _tabVC = (UITabBarController *)window.rootViewController;
        objc_setAssociatedObject(self, tabVCKey, _tabVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return _tabVC;
}

- (void)hh_dropShadowWithOffset:(CGSize)offset
                         radius:(CGFloat)radius
                          color:(UIColor *)color
                        opacity:(CGFloat)opacity{
    [self.navigationController hh_dropShadowWithOffset:offset radius:radius color:color opacity:opacity];
}

- (void)hh_shadowNavRelativeSet{
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    self.navigationController.hh_navHairLine.hidden = YES;
    self.hh_navShadow = YES;
    self.hh_Bg.hidden = YES;
}

@end
