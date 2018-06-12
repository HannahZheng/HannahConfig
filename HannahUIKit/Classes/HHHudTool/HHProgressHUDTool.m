//
//  HHProgressHUDTool.m
//  GlobalTimes
//
//  Created by apple on 2016/11/4.
//  Copyright © 2016年 Hannah. All rights reserved.
//

#import "HHProgressHUDTool.h"

static HHProgressHUDTool * progressHUD = nil;

@interface HHProgressHUDTool ()

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, strong) UIView *loadView;

@end

@implementation HHProgressHUDTool

+ (HHProgressHUDTool *)sharedProgressHUD {
    if (!progressHUD) {
        progressHUD = [[HHProgressHUDTool alloc]init];
    }
    return progressHUD;
}

- (void)showProgressDialog:(UIView*)view {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;;
    if (_HUD == nil) {
        _HUD = [[MBProgressHUD alloc]initWithView:view];
        [view addSubview:_HUD];
        [view bringSubviewToFront:view];
    }
    //    _HUD.label.text = @"正在加载";
    _HUD.mode = MBProgressHUDModeIndeterminate;
    [_HUD showAnimated:YES];
}
- (void)showProgressDialog:(UIView*)view content:(NSString *)text{
     [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    if (_HUD == nil) {
        _HUD = [[MBProgressHUD alloc]initWithView:view];
        [view addSubview:_HUD];
    }
   
    _HUD.label.text = text;
    //    _HUD.label.textColor = [UIColor blackColor];
    //    _HUD.contentColor = [UIColor lightGrayColor];
    _HUD.mode = MBProgressHUDModeIndeterminate;
    _HUD.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    _HUD.contentColor = [UIColor whiteColor];
    [_HUD showAnimated:YES];
}
- (void)stop {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if (_HUD) {
        [_HUD removeFromSuperview];
        _HUD = nil;
    }
   
}


//自动消失
- (void)showAlert:(NSString *)text forView:(UIView *)view{

    if (_textHud) {
        [_textHud removeFromSuperview];
        _textHud = nil;
    }
    _textHud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:_textHud];
    _textHud.contentColor = [UIColor whiteColor];
    _textHud.bezelView.color = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    _textHud.mode = MBProgressHUDModeText;
    _textHud.removeFromSuperViewOnHide = YES;
    _textHud.label.text=  text;
    _textHud.label.numberOfLines = 0;
    [_textHud showAnimated:YES];
    [_textHud hideAnimated:YES afterDelay:1.5];
    
}
//手动消失
+(void)showConfirmAlert:(NSString *)text{
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"提示"
                                                   message:text
                                                  delegate:self
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil];
    [alert show];
}

+(MBProgressHUD *)showToAnnularDeterminateforView:(UIView *)view{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [HUD showAnimated:YES];
    HUD.bezelView.color = [UIColor blackColor];
    HUD.contentColor = [UIColor whiteColor];
    return HUD;
}


//- (HHInsetsLabel *)alertLabel{
//    if (_alertLabel == nil) {
//        HHInsetsLabel *alertLabel = [[HHInsetsLabel alloc]initWithFrame:CGRectZero andInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
//        alertLabel.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
//        alertLabel.layer.cornerRadius = 5;
//        alertLabel.layer.masksToBounds = YES;
//        alertLabel.font = [UIFont systemFontOfSize:18];
//        alertLabel.numberOfLines = 0;
//        alertLabel.textAlignment = NSTextAlignmentCenter;
//        alertLabel.textColor = [UIColor whiteColor];
//        alertLabel.hidden = YES;
//        [HHKeyWindow addSubview:alertLabel];
//        _alertLabel = alertLabel;
//    }
//    return _alertLabel;
//}

//- (void)setMyAlertViewWithMessage:(NSString *)message{
//    self.alertLabel.text = message;
//    CGSize size = [self.alertLabel sizeThatFits:CGSizeMake(HHMainScreenWidth-50, 50)];
//    self.alertLabel.bounds = CGRectMake(0, 0, size.width+20, size.height+20);
//    self.alertLabel.center = CGPointMake(HHMainScreenWidth/2, HHMainScreenHeight/2);
//    //
//    //    [UIView beginAnimations:nil context:nil];
//    //    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
//    //    [UIView setAnimationDuration:1];
//    ////    [UIView setAnimationDelegate:self];//设置委托
//    ////    [UIView setAnimationDidStopSelector:@selector(animationStop)];//当动画结束时，我们还需要再将其隐藏
//    //        self.alertLabel.hidden = NO;
//    //    [UIView commitAnimations];
//
//    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseIn animations:^{
//        self.alertLabel.hidden = NO;
//    } completion:^(BOOL finished) {
//        [self performSelector:@selector(alertViewDismiss:) withObject:self.alertLabel afterDelay:1.5];
//    }];
//
//    //    [self performSelector:@selector(alertViewDismiss:) withObject:self.alertLabel afterDelay:1.5];
//
//    //    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
//    //    [alertView show];
//    //    [self performSelector:@selector(alertViewDismiss:) withObject:alertView afterDelay:1.5];
//
//}

//- (void)alertViewDismiss:(UILabel*)alertLabel{
//    //    [alertView removeFromSuperview];
//    //    [alertView dismissWithClickedButtonIndex:0 animated:NO];
//
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//    [UIView setAnimationDuration:1];
//    self.alertLabel.hidden = YES;
//    [UIView commitAnimations];
//}

//#pragma mark UIActivityIndicatorView
//
//- (UIView *)loadView{
//    if (_loadView == nil) {
//        _loadView = [[UIView alloc]initWithFrame:CGRectZero];
//        _loadView.center = HHKeyWindow.center;
//        _loadView.bounds = CGRectMake(0, 0, 100, 100);
//        _loadView.hidden = YES;
//        _loadView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
//        _loadView.layer.cornerRadius = 10;
//        _loadView.layer.masksToBounds = YES;
//        [HHKeyWindow addSubview:_loadView];
//    }
//
//    return _loadView;
//}
//
//- (UIActivityIndicatorView *)indicatorView{
//    if (_indicatorView == nil) {
//        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//
//    }
//    return _indicatorView;
//}

@end
