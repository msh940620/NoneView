//
//  NoneView.m
//  schoolConnection
//
//  Created by Reminisce on 16/4/22.
//  Copyright © 2016年 Reminisce. All rights reserved.
//

#import "NoneView.h"
#import "Tools.h"
#import "BaseViewController.h"

@interface NoneView ()
/** 数据为空时的图片*/
@property (nonatomic,strong)UIImageView *nonePicture;
/** 数据为空时显示的标题*/
@property (nonatomic,strong)UILabel *noneTitleL;
/** 数据为空时显示的描述信息*/
@property (nonatomic,strong)UIButton *noneDec;
/** 数据为空时想执行的操作按钮*/
@property (nonatomic,strong)UIButton *noneBtn;

@end


@implementation NoneView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        [self addSubview:self.nonePicture];
        [self addSubview:self.noneTitleL];
        [self addSubview:self.noneDec];
        [self addSubview:self.noneBtn];
        self.backgroundColor = COLOR_BACKGROUND;
    }
    return self;
}

-(UIImageView *)nonePicture{
    if (!_nonePicture) {
        _nonePicture = [[UIImageView alloc] init];
        _nonePicture.frame = CGRectMake(60, 60, ScreenW - 120, 10);
    }
    return _nonePicture;
}

-(UILabel *)noneTitleL{
    if (!_noneTitleL) {
        _noneTitleL = [[UILabel alloc] initWithFrame:CGRectMake(0, _nonePicture.frame.size.height + _nonePicture.frame.origin.y + 5, ScreenW, 20)];
        _noneTitleL.font = FONT(15);
        _noneTitleL.textAlignment = NSTextAlignmentCenter;
        _noneTitleL.textColor = RGB(64, 64, 64);
    }
    return _noneTitleL;
}

-(UIButton *)noneDec{
    if (!_noneDec) {
        _noneDec = [UIButton buttonWithType:UIButtonTypeSystem];
        _noneDec.frame = CGRectMake(0, _noneTitleL.frame.size.height + _noneTitleL.frame.origin.y +5, ScreenW, 20);
        [_noneDec setTintColor:RGB(128, 128, 128)];
//        _noneDec.textColor = RGB(128, 128, 128);
        _noneDec.titleLabel.font = FONT(12);
    }
    return _noneDec;
}

-(UIButton *)noneBtn{
    if (!_noneBtn) {
        _noneBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _noneBtn.frame = CGRectMake(20, _noneDec.frame.origin.y + _noneDec.frame.size.height + 20, ScreenW - 40, 44);
        _noneBtn.layer.borderWidth = 1.0f;
        _noneBtn.layer.borderColor = [UIColor colorWithRed:188/255.0 green:166/255.0 blue:129/255.0 alpha:1.0].CGColor;
        _noneBtn.layer.cornerRadius = 22;
        _noneBtn.layer.masksToBounds = YES;
        _noneBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_noneBtn setTintColor:[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0]];
        _noneBtn.enabled = YES;
    }
    return _noneBtn;
}


- (void)setImage:(NSString *)imageName withWidth:(CGFloat)img_width img_y:(CGFloat)imag_y{
    _nonePicture.image = [UIImage imageNamed:imageName];
    _nonePicture.frame = CGRectMake((ScreenW - img_width)/2, imag_y, img_width,img_width);
    _noneTitleL.frame = CGRectMake(0, _nonePicture.frame.size.height + _nonePicture.frame.origin.y + 10, ScreenW, 20);
    _noneDec.frame = CGRectMake(0, _noneTitleL.frame.size.height + _noneTitleL.frame.origin.y +5, ScreenW, 20);
    _noneBtn.frame = CGRectMake(20, _noneDec.frame.origin.y + _noneDec.frame.size.height + 20, ScreenW - 40, 44);
}

-(void)setTitle:(NSString *)noneTitle noneDec:(NSString *)noneDec noneBtnTitle:(NSString *)btnTitle{
    _noneTitleL.text = noneTitle;
    [_noneDec setTitle:noneDec forState:UIControlStateNormal];
    _noneBtn.titleLabel.text = btnTitle;
    [_noneBtn setTitle:btnTitle forState:UIControlStateNormal];

        self.noneBtn.hidden = [Tools isEmpty:btnTitle];
    self.noneTitleL.hidden = [Tools isEmpty:noneTitle];
    self.noneDec.hidden = [Tools isEmpty:noneDec];
}

- (void)setReloadClickBlock:(void (^)(void))reloadClickBlock{
    
    _reloadClickBlock = reloadClickBlock;
    [self.noneBtn removeTarget:nil action:nil forControlEvents:UIControlEventAllEvents];
    [self.noneBtn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonAction{

    if(self.reloadClickBlock){
        _reloadClickBlock();
    }
}

@end
