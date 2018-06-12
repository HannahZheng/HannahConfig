//
//  HHTabBar.h
//  HannahUIKit
//
//  Created by MXTH on 2018/6/12.
//

#import <UIKit/UIKit.h>



@interface HHTabBar : UITabBar

@property (nonatomic, assign) CGSize middleSize;
@property (nonatomic, assign) CGFloat middleTopInset;
@property (nonatomic, strong) UIImage *middleImg;
@property (nonatomic, copy) void(^myMiddleClickedBlock)(void);





@end
