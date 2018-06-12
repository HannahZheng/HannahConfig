//
//  UITabBarController+HHCustom.m
//  HannahUIKit
//
//  Created by MXTH on 2018/6/12.
//

#import "UITabBarController+HHCustom.h"
#import <objc/runtime.h>

static char *myEnlargeMiddleBlockKey = "myEnlargeMiddleBlockKey";
static char *hh_barKey = "hh_barKey";

@implementation UITabBarController (HHCustom)

- (void)setMyEnlargeMiddleBlock:(void (^)(void))myEnlargeMiddleBlock{
    objc_setAssociatedObject(self, myEnlargeMiddleBlockKey, myEnlargeMiddleBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

//- ()


- (instancetype) initWithContollerArray:(NSArray <UIViewController *>*)controllerArray
                           titleArray:(NSArray <NSString *>*)titleArray
                           imageArray:(NSArray <UIImage *>*)imageArray
                     selectImageArray:(NSArray <UIImage *>*)selectImageArray
                           titleColor:(UIColor *)titleColor
                     selectTitleColor:(UIColor *)selectTitleColor
                       controllerType:(HHTabBarControllerType)controllerType{
    self = [super init];
    
    if(self){
        
        
    }
    
    return self;
}

@end
