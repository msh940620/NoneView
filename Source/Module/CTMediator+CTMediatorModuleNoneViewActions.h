//
// Created by Reminisce on 2016/11/9.
//

#import <Foundation/Foundation.h>
#import "CTMediator.h"

@interface CTMediator (CTMediatorModuleNoneViewActions)

-(UIView *)CTMediator_noneViewWithTitle:(NSString *)noneTitle
                                noneDec:(NSString *)noneDec
                           noneBtnTitle:(NSString *)btnTitle
                                  Image:(NSString *)imageName
                              withWidth:(CGFloat)img_width
                             withHeight:(CGFloat)img_height
                                  img_y:(CGFloat)imag_y
                                 height:(CGFloat)height
                                  block:(void (^)(void))block;

@end
