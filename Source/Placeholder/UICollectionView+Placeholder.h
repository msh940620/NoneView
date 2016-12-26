//
//  UICollectionView+Sure_Placeholder.h
//  AppPlaceholder
//
//  Created by 刘硕 on 2016/11/30.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (Placeholder)

@property (nonatomic, strong) UIView *placeholderView;

@property (nonatomic, strong) NSNumber *needPlaceholder;

- (NSString *)noneDesc;
- (NSString *)btnButton;

- (NSString *)imgName;

- (void)reload_action;

- (CGFloat)imgWidth;
- (CGFloat)imgY;


@end
