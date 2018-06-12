//
//  UIViewController+HHCustom.m
//  HannahCategory
//
//  Created by MXTH on 2018/6/11.
//

#import "UIViewController+HHCustom.h"
#import <objc/runtime.h>
#import "UINavigationController+HHCustom.h"
#import "HannahMacro.h"


@implementation UIViewController (HHCustom)
static char *navBarBgAlphaKey = "navBarBgAlphaKey";
static char *hh_clearNavKey = "hh_clearNavKey";
static char *hh_notSupportLeftBackKey = "hh_notSupportLeftBackKey";
static char *hhBgKey = "hhBgVKey";
static char *navShadowKey = "navShadowKey";
static char *pushedKey = "pushedKey";
static char *tabVCKey = "tabVCKey";
static char *hh_refreshHeaderKey = "hh_refreshHeaderKey";
static char *hh_loadMoreFooterKey = "hh_loadMoreFooterKey";
static char *hh_currentUsingKey = "hh_currentUsingKey";
static char *hh_loadFinishedKey = "hh_loadFinishedKey";
static char *hh_loadingKey = "hh_loadingKey";

+ (void)load{
    Method origin_didLoad = class_getInstanceMethod(self, @selector(viewDidLoad));
    Method swizzled_didLoad = class_getInstanceMethod(self, @selector(hh_viewDidLoad));
    method_exchangeImplementations(origin_didLoad, swizzled_didLoad);
    
    Method origin_willAppear = class_getInstanceMethod(self, @selector(viewWillAppear:));
    Method swizzled_willAppear = class_getInstanceMethod(self, @selector(hh_viewWillAppear:));
    method_exchangeImplementations(origin_willAppear, swizzled_willAppear);
    
    Method origin_willDisappear = class_getInstanceMethod(self, @selector(viewWillDisappear:));
    Method swizzled_willDisAppear = class_getInstanceMethod(self, @selector(hh_viewWillDisapper:));
    method_exchangeImplementations(origin_willDisappear, swizzled_willDisAppear);
}

- (void)hh_viewDidLoad{
    self.hh_clearNav = NO;
    
    [self resetBackBarButtonItem];
    
    if (HHiOS11 == NO) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self setHaveLeftItem:self.hh_pushed];
    
}

- (void)hh_viewWillAppear:(BOOL)animated{
    self.hh_currentUsing = YES;
    self.hh_notSupportLeftBack = NO;
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.hh_navHairLine.hidden = self.hh_clearNav;
    self.hh_tabVC.tabBar.translucent = !self.hh_pushed;
    self.hh_tabVC.tabBar.hidden = !self.hh_pushed;
}

- (void)hh_viewWillDisapper:(BOOL)animated{
    self.hh_currentUsing = NO;
    self.hh_navShadow = NO;
    
}

- (void)resetBackBarButtonItem{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationItem setHidesBackButton:YES];
}

- (void)setHaveLeftItem:(BOOL)isHaveLeftItem{
    
    if (@available(iOS 11.0, *)) {
        //将BarButtonItem添加到LeftBarButtonItem上
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:HHBundleImage(@"goods-back") style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
        leftItem.title = @"";
        
        self.navigationItem.leftBarButtonItem = isHaveLeftItem?leftItem:nil;
    }else{
        //MARK: 这样是因为在iOS 10的系统中，有发现leftBarButtonItem偏移了原本的位置这种情况
        UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        //spaceItem宽度为负值，相当于左移
        spaceItem.width = -23;
        
        // 初始化一个返回按钮
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        // 为返回按钮设置图片样式
        [button setImage:[HHBundleImage(@"goods-back") imageWithRenderingMode:UIImageRenderingModeAutomatic] forState:UIControlStateNormal];
        [button setImage:[HHBundleImage(@"goods-back") imageWithRenderingMode:UIImageRenderingModeAutomatic] forState:UIControlStateHighlighted];
        // 设置返回按钮触发的事件
        [button addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        
        // 初始化一个BarButtonItem，并将其设置为返回的按钮的样式
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:button];
        //       self.navigationItem.leftBarButtonItem = self.isPushed?backButton:nil;
        self.navigationItem.leftBarButtonItems = isHaveLeftItem?@[spaceItem,backButton]:nil;
    }
    
}

#pragma mark 属性

- (void)setHh_navBarBgAlpha:(CGFloat)hh_navBarBgAlpha{
    objc_setAssociatedObject(self, navBarBgAlphaKey, @(hh_navBarBgAlpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CGFloat)hh_navBarBgAlpha{
    return [objc_getAssociatedObject(self, navBarBgAlphaKey) floatValue];
}

- (void)setHh_clearNav:(BOOL)hh_clearNav{
    objc_setAssociatedObject(self, hh_clearNavKey, @(hh_clearNav), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)hh_clearNav{
    return objc_getAssociatedObject(self, hh_clearNavKey);
}

- (void)setHh_notSupportLeftBack:(BOOL)hh_notSupportLeftBack{
    objc_setAssociatedObject(self, hh_notSupportLeftBackKey, @(hh_notSupportLeftBack), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)hh_notSupportLeftBack{
    return objc_getAssociatedObject(self, hh_notSupportLeftBackKey);
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
    if (hh_navShadow) {
        [self.navigationController hh_dropShadowWithOffset:CGSizeMake(0, 2) radius:1 color:HHAlphaColor(217, 217, 217, 0.5) opacity:1];
    }else{
        [self.navigationController hh_dropShadowWithOffset:CGSizeMake(0, 0) radius:0 color:[UIColor clearColor] opacity:0];
    }
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

#pragma mark 刷新
- (void)setHh_refreshHeader:(MJRefreshNormalHeader *)hh_refreshHeader{
    objc_setAssociatedObject(self, hh_refreshHeaderKey, hh_refreshHeader, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MJRefreshNormalHeader *)hh_refreshHeader{
    MJRefreshNormalHeader *_hh_refreshHeader = objc_getAssociatedObject(self, hh_refreshHeaderKey);
    if(!_hh_refreshHeader){
        @ axc_weakify_self;
        _hh_refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf refreshData];
        }];
        _hh_refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    }
    
    return _hh_refreshHeader;
}

- (void)setHh_loadMoreFooter:(MJRefreshAutoNormalFooter *)hh_loadMoreFooter{
    objc_setAssociatedObject(self, hh_loadMoreFooterKey, hh_loadMoreFooter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MJRefreshAutoNormalFooter *)hh_loadMoreFooter{
    MJRefreshAutoNormalFooter *_hh_loadMoreFooter = objc_getAssociatedObject(self, hh_loadMoreFooterKey);
    if(_hh_loadMoreFooter == nil){
        @ axc_weakify_self;;
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf loadMoreData];
        }];
        footer.hidden = YES;
        footer.stateLabel.textColor = HHColor(162, 162, 162);
        _hh_loadMoreFooter = footer;
    }
    
    
    return _hh_loadMoreFooter;
}

//刷新和加载更多数据
- (void)refreshData{
    
}
- (void)loadMoreData{
    
}
- (void)loadLocalData{
    
}

#pragma mark 当前视图是否正在使用中 以及加载状态
- (void)setHh_currentUsing:(BOOL)hh_currentUsing{
    objc_setAssociatedObject(self, hh_currentUsingKey, @(hh_currentUsing), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)hh_currentUsing{
    
    return objc_getAssociatedObject(self, hh_currentUsingKey);
}

- (void)setHh_loadFinished:(BOOL)hh_loadFinished{
    objc_setAssociatedObject(self, hh_loadFinishedKey, @(hh_loadFinished), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)hh_loadFinished{
    return objc_getAssociatedObject(self, hh_loadFinishedKey);
}

- (void)setHh_loading:(BOOL)hh_loading{
    objc_setAssociatedObject(self, hh_loadingKey, @(hh_loading), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)hh_loading{
    return objc_getAssociatedObject(self, hh_loadingKey);
}

#pragma mark 阴影
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

- (void)hh_setStatusBarStyle:(UIStatusBarStyle)style
{
    [UIApplication sharedApplication].statusBarStyle = style;
    [self setNeedsStatusBarAppearanceUpdate];
}

@end
