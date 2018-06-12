//
//  HHTabBar.m
//  HannahUIKit
//
//  Created by MXTH on 2018/6/12.
//

#import "HHTabBar.h"

@interface HHTabBar()

@property (nonatomic, strong) UIButton *middleBtn;

@end

@implementation HHTabBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (UIButton *)middleBtn{
    if(_middleBtn == nil){
        _middleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _middleBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        _middleBtn.adjustsImageWhenHighlighted = NO;
        [_middleBtn addTarget:self action:@selector(didMiddleBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_middleBtn];
        
    }
    
    return _middleBtn;
}

- (void)didMiddleBtnClicked{
    if(self.myMiddleClickedBlock) self.myMiddleClickedBlock();
}

- (void)setMiddleSize:(CGSize)middleSize{
    _middleSize = middleSize;
    self.middleBtn.frame = CGRectMake(0, 0, middleSize.width, middleSize.height);
}

- (void)setMiddleImg:(UIImage *)middleImg{
    _middleImg = middleImg;
    [self.middleBtn setImage:middleImg forState:UIControlStateNormal];
}

#pragma mark

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat width = self.bounds.size.width/5.0;
    CGFloat height = self.bounds.size.height;
    
    self.middleBtn.center = CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0-self.middleTopInset);
    
    int index = 0;
    for (UIView *itemButton in self.subviews) {
         Class class = NSClassFromString(@"UITabBarButton");
         if ([itemButton isKindOfClass:class]){
             CGFloat x = width*index;
             
             if(index >= 2) x += width;
             itemButton.frame = CGRectMake(x, 0, width, height);
         }
        
    }
    
    [self bringSubviewToFront:self.middleBtn];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if(self.isHidden == NO){
        
        CGPoint middlePoint = [self convertPoint:point toView:self.middleBtn];
        if([self.middleBtn pointInside:middlePoint withEvent:event]) return self.middleBtn;
        
        return [super hitTest:point withEvent:event];
    }
    
    return [super hitTest:point withEvent:event];
}


@end
