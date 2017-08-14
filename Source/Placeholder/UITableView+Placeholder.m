//
//  UITableView+Sure_Placeholder.m
//  AppPlaceholder
//
//  Created by 刘硕 on 2016/11/30.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "UITableView+Placeholder.h"
#import "NSObject+Swizzling.h"
#import "CTMediator+CTMediatorModuleNoneViewActions.h"
#import "MJRefresh.h"


// 由于tableview初始化的时候会调用 所以 此页面涂层一定在网络错误涂层之下
@implementation UITableView (Placeholder)

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
    BOOL isEmpty = YES;//flag标示
    
    id <UITableViewDataSource> dataSource = self.dataSource;
    NSInteger sections = 1;//默认一组
    if ([dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        sections = [dataSource numberOfSectionsInTableView:self] - 1;//获取当前TableView组数
    }
    
    for (NSInteger i = 0; i <= sections; i++) {
        NSInteger rows = [dataSource tableView:self numberOfRowsInSection:i];//获取当前TableView各组行数
        if (rows) {
            isEmpty = NO;//若行数存在，不为空
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
    
    if(!self.imgName){
        self.imgName = @"ic_no_data";
    }
    if(!self.noneTitle){
        self.noneTitle = @"";
    }
    if(!self.noneDesc){
        self.noneDesc = @"";
    }
    if(!self.btnButtonTitle){
        self.btnButtonTitle = @"";
    }
    if(!self.imgWidth){
        self.imgWidth = @(114);
    }
    if(!self.imgY){
        self.imgY = @(150);
    }
    if(!self.imgHeight){
        self.imgHeight = @(90);
    }
    UIView *placeholderView = [[CTMediator sharedInstance] CTMediator_noneViewWithTitle:[self noneTitle]
                                                                                  noneDec:[self noneDesc]
                                                                             noneBtnTitle:[self btnButtonTitle]
                                                                                    Image:[self imgName]
                                                                                withWidth:[[self imgWidth] floatValue]
                                                                               withHeight:[[self imgHeight] floatValue]
                                                                                    img_y:[[self imgY] floatValue]
                                                                                   height:self.frame.size.height
                                                                                    block:^{
                                                                                        [self reload_action];
                                                                                    }];
    self.placeholderView = placeholderView;
}

- (void)reload_action{
    
    if(self.block){
        self.block();
    }else if(self.mj_header){
        [self.mj_header beginRefreshing];
    }
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

- (NSString *)noneDesc{
    return objc_getAssociatedObject(self, @selector(noneDesc));
}

- (void)setNoneDesc:(NSString *)noneDesc{
    objc_setAssociatedObject(self, @selector(noneDesc), noneDesc, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)noneTitle{
    return objc_getAssociatedObject(self, @selector(noneTitle));
}

- (void)setNoneTitle:(NSString *)noneTitle{
    objc_setAssociatedObject(self, @selector(noneTitle), noneTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)btnButtonTitle{
    return objc_getAssociatedObject(self, @selector(btnButtonTitle));
}

- (void)setBtnButtonTitle:(NSString *)btnButtonTitle{
    objc_setAssociatedObject(self, @selector(btnButtonTitle), btnButtonTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)imgName{
    return objc_getAssociatedObject(self, @selector(imgName));
}

- (void)setImgName:(NSString *)imgName{
    objc_setAssociatedObject(self, @selector(imgName), imgName, OBJC_ASSOCIATION_COPY_NONATOMIC);
    
}

- (void (^)(void))block{
    
    return objc_getAssociatedObject(self, @selector(block));
}

- (void)setBlock:(void (^)(void))block{
    objc_setAssociatedObject(self, @selector(block), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSNumber *)imgWidth{
    return objc_getAssociatedObject(self, @selector(imgWidth));
}

- (NSNumber *)imgHeight{
    return objc_getAssociatedObject(self, @selector(imgHeight));
}

- (void)setImgWidth:(NSNumber *)imgWidth{
    objc_setAssociatedObject(self, @selector(imgWidth), imgWidth, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setImgHeight:(NSNumber *)imgHeight{
    objc_setAssociatedObject(self, @selector(imgHeight), imgHeight, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSNumber *)imgY{
    return objc_getAssociatedObject(self, @selector(imgY));
}

- (void)setImgY:(NSNumber *)imgY{
    objc_setAssociatedObject(self, @selector(imgY), imgY, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
