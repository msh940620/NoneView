//
// Created by Reminisce on 2016/11/9.
//

#import "CTMediator+CTMediatorModuleNoneViewActions.h"


NSString * const kCTMediatorTargetNoneView = @"NoneView";

NSString * const kCTMediatorActionNativeNoneView = @"nativeNoneView";

@implementation CTMediator (CTMediatorModuleNoneViewActions)

-(UIView *)CTMediator_noneViewWithTitle:(NSString *)noneTitle
                                noneDec:(NSString *)noneDec
                           noneBtnTitle:(NSString *)btnTitle
                                  Image:(NSString *)imageName
                              withWidth:(CGFloat)img_width
                             withHeight:(CGFloat)img_height
                                  img_y:(CGFloat)imag_y
                                 height:(CGFloat)height
                                  block:(void (^)(void))block{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if(noneTitle){
        dic[@"NoneTitle"] = noneTitle;
    }
    if(noneDec){
        dic[@"NoneDesc"] = noneDec;
    }
    if(btnTitle){
        dic[@"ButtonTitle"] = btnTitle;
    }
    if(imageName){
        dic[@"NoneIMG"] = imageName;
    }
    if(img_width){
        dic[@"IMG_WIDTH"] = @(img_width);
    }
    if(img_height){
        dic[@"IMG_HEIGHT"] = @(img_height);
    }
    if(imag_y){
        dic[@"IMG_Y"] = @(imag_y);
    }
    if(block){
        dic[@"Block"] = block;
    }
    if(height){
        dic[@"Height"] = @(height);
    }
    UIView *noneView = [self performTarget:kCTMediatorTargetNoneView
                                       action:kCTMediatorActionNativeNoneView
                                       params:dic
                            shouldCacheTarget:NO];
    if ([noneView isKindOfClass:[UIView class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return noneView;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIView alloc] init];
    }
}

@end
