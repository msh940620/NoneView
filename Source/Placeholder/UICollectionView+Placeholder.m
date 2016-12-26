//
//  UICollectionView+Sure_Placeholder.m
//  AppPlaceholder
//
//  Created by 刘硕 on 2016/11/30.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "UICollectionView+Placeholder.h"
#import "NSObject+Swizzling.h"
#import "CTMediator+CTMediatorModuleNoneViewActions.h"
#import "MJRefresh.h"

@implementation UICollectionView (Placeholder)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self methodSwizzlingWithOriginalSelector:@selector(reloadData)
                               bySwizzledSelector:@selector(sure_reloadData)];
    });
}

- (void)sure_reloadData {
    [self checkEmpty];
    [self sure_reloadData];
}

- (void)checkEmpty {
    BOOL isEmpty = YES;
    
    id <UICollectionViewDataSource> dataSource = self.dataSource;
    NSInteger sections = 1;
    if ([dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
        sections = [dataSource numberOfSectionsInCollectionView:self] - 1;
    }
    
    for (NSInteger i = 0; i <= sections; i++) {
        NSInteger rows = [dataSource collectionView:self numberOfItemsInSection:sections];
        if (rows) {
            isEmpty = NO;
        }
    }
    
    if (isEmpty && [self.needPlaceholder integerValue] > 0) {//若为空，加载占位图
        //默认占位图
        if (!self.placeholderView) {
            [self makeDefaultPlaceholderView];
        }
        self.placeholderView.hidden = NO;
        [self addSubview:self.placeholderView];
    } else {//不为空，移除占位图
        self.placeholderView.hidden = YES;
    }
}

- (void)makeDefaultPlaceholderView {
    UIView *placeholderView = [[CTMediator sharedInstance] CTMediator_noneViewWithTitle:[self noneTitle]
                                                                                noneDec:[self noneDesc]
                                                                           noneBtnTitle:[self btnButton]
                                                                                  Image:[self imgName]
                                                                              withWidth:[self imgWidth]
                                                                                  img_y:[self imgY]
                                                                                 height:self.frame.size.height
                                                                             block:^{
                                                                                 [self reload_action];
                                                                             }];
    self.placeholderView = placeholderView;
}

- (NSString *)noneTitle{

    return @"";

}

- (NSString *)noneDesc{

    return @"";
}

- (NSString *)btnButton{

    return @"";
}

- (NSString *)imgName{

    return @"ic_no_data";
}

- (void)reload_action{

    if(self.mj_header){
        [self.mj_header beginRefreshing];
    }

}

- (CGFloat)imgWidth{

    return 80;
}

- (CGFloat)imgY{

    return 120;

}



- (UIView *)placeholderView {
    return objc_getAssociatedObject(self, @selector(placeholderView));
}

- (void)setPlaceholderView:(UIView *)placeholderView {
    objc_setAssociatedObject(self, @selector(placeholderView), placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)needPlaceholder {
    return objc_getAssociatedObject(self, @selector(needPlaceholder));
}

- (void)setNeedPlaceholder:(NSNumber *)needPlaceholder{
    objc_setAssociatedObject(self, @selector(needPlaceholder), needPlaceholder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
