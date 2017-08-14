//
//  UITableView+Sure_Placeholder.h
//  AppPlaceholder
//
//  Created by 刘硕 on 2016/11/30.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoneView.h"

@interface UITableView (Placeholder)

@property (nonatomic, strong) UIView *placeholderView;

@property (nonatomic, strong) NSNumber *needPlaceholder;

@property (nonatomic, copy) NSString *noneTitle;

@property (nonatomic, copy) NSString *noneDesc;

@property (nonatomic, copy) NSString *btnButtonTitle;

@property (nonatomic, copy) NSString *imgName;

@property (nonatomic, copy) void (^block)(void);

@property (nonatomic, strong) NSNumber *imgWidth;

@property (nonatomic, strong) NSNumber *imgHeight;

@property (nonatomic, strong) NSNumber *imgY;

@end
