//
//  NoneView.h
//  schoolConnection
//
//  Created by Reminisce on 16/4/22.
//  Copyright © 2016年 Reminisce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoneView : UIView

/** 传入图片名和需要的Y坐标和宽度*/
- (void)setImage:(NSString *)imageName withWidth:(CGFloat)img_width img_y:(CGFloat)imag_y;

/** 自定义空页面的主标题和副标题、按钮文字*/
- (void)setTitle:(NSString *)noneTitle noneDec:(NSString *)noneDec noneBtnTitle:(NSString *)btnTitle;

@property (nonatomic, copy) void(^reloadClickBlock)(void);

@end
