//
//  UITabBarController+HHCustom.h
//  HannahUIKit
//
//  Created by MXTH on 2018/6/12.
//

#import <UIKit/UIKit.h>
#import "HHTabBar.h"

typedef NS_ENUM(NSInteger,HHTabBarControllerType){
    
    HHTabBarControllerTypeNormal,
    HHTabBarControllerTypeEnlarge
};


@interface UITabBarController (HHCustom)

 @property (nonatomic, copy) void(^myEnlargeMiddleBlock)(void);
@property (nonatomic, strong) HHTabBar *hh_bar;

/*!
 @brief 初始化
 @param  controllerArray   控制器数组
 @param  titleArray        底部标题数组
 @param  imageArray        未选中状态下的图标数组
 @param  selectImageArray  选中状态下的图标数组
 @param  titleColor        未选中状态下的标题颜色
 @param  selectTitleColor  选中状态下的标题颜色
 @param  controllerType    底部导航的样式类型
 @return instancetype      UITabBarController对象
 */
- (instancetype) initWithContollerArray:(NSArray <UIViewController *>*)controllerArray
                           titleArray:(NSArray <NSString *>*)titleArray
                           imageArray:(NSArray <UIImage *>*)imageArray
                     selectImageArray:(NSArray <UIImage *>*)selectImageArray
                           titleColor:(UIColor *)titleColor
                     selectTitleColor:(UIColor *)selectTitleColor
                       controllerType:(HHTabBarControllerType)controllerType;

@end
