//
//  JWCycleLabel.h
//  JWLoopLabel
//
//  Created by djw on 2017/5/1.
//  Copyright © 2017年 ubiquitous. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWCycleLabel : UIView

/**
 label 文字方向
 */
@property (nonatomic,assign) NSTextAlignment textAlignment;
/**
 font
 */
@property (nonatomic,strong) UIFont *font;
/**
 label 背景色
 */
@property (nonatomic,strong) UIColor *labelBackgroundColor;
/**
 label 文字颜色
 */
@property (nonatomic,strong) UIColor *textColor;
/**
 动画时间
 */
@property (nonatomic,assign) NSTimeInterval timeInterVal;
/**
 是否点击手势
 */
@property (nonatomic,assign) BOOL canTap;

/**
 开始动画
 
 @param textArray 数据源
 */
- (void)startWithTextArray:(NSArray<NSString *> *)textArray;
/**
 点击 label回调
 */
@property (nonatomic, copy) void(^clickedLabel)(NSUInteger index);

@end
