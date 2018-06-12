//
//  HHProgressHUDTool.h
//  GlobalTimes
//
//  Created by apple on 2016/11/4.
//  Copyright © 2016年 Hannah. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HHProgressHUDTool : NSObject
@property (nonatomic, strong)MBProgressHUD* HUD;
@property (nonatomic, strong)MBProgressHUD *textHud;

+ (HHProgressHUDTool *)sharedProgressHUD;
- (void)showProgressDialog:(UIView*)view content:(NSString *)text;

- (void)showProgressDialog:(UIView*)view;

- (void)stop;


//自动消失
-(void)showAlert:(NSString *)text forView:(UIView *)view;
//手动消失
+(void)showConfirmAlert:(NSString *)text;
//环形进度条
+(MBProgressHUD *)showToAnnularDeterminateforView:(UIView *)view;

- (void)setMyAlertViewWithMessage:(NSString *)message;
@end
