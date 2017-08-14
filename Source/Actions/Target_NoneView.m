//
// Created by Reminisce on 2016/11/9.
//

#import "Target_NoneView.h"
#import "NoneView.h"


@implementation Target_NoneView

- (UIView *)Action_nativeNoneView:(NSDictionary *)params{
    NoneView *view = [[NoneView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, [params[@"Height"] doubleValue])];
    [view setImage:params[@"NoneIMG"] withSize:CGSizeMake([params[@"IMG_WIDTH"] floatValue], [params[@"IMG_HEIGHT"] floatValue]) img_y:[params[@"IMG_Y"] floatValue]];
    [view setTitle:params[@"NoneTitle"] noneDec:params[@"NoneDesc"] noneBtnTitle:params[@"ButtonTitle"]];
    view.reloadClickBlock = params[@"Block"];
    return view;
}

@end
