//
//  JWCycleLabel.m
//  JWLoopLabel
//
//  Created by djw on 2017/5/1.
//  Copyright © 2017年 ubiquitous. All rights reserved.
//

#import "JWCycleLabel.h"

@interface JWCycleLabel ()
/**
 数据源
 */
@property (nonatomic,strong) NSArray<NSString *> *textArray;

@property (nonatomic,strong) UILabel *label_0;

@property (nonatomic,strong) UILabel *label_1;

@property (nonatomic,assign) NSUInteger showCount;

@property (nonatomic,assign) BOOL wichOne;

@property (nonatomic,assign) BOOL stopAnimate;

@end

@implementation JWCycleLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _showCount = 0;
        self.clipsToBounds = YES;
        _timeInterVal = 3.0;
        _stopAnimate = NO;
    }
    return self;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
}

- (void)setFont:(UIFont *)font {
    _font = font;
}

- (void)setCanTap:(BOOL)canTap {
    _canTap = canTap;
    if (canTap) {
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedself:)];
        [self addGestureRecognizer:tap];
    }
}

- (void)setLabelBackgroundColor:(UIColor *)labelBackgroundColor {
    _labelBackgroundColor = labelBackgroundColor;
    self.backgroundColor = labelBackgroundColor;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
}

- (void)startWithTextArray:(NSArray<NSString *> *)textArray {
    [self reloadLabel];
    if (_textArray.count > 0) {
        _stopAnimate = YES;
    }
    self.textArray = textArray;
    if (textArray.count == 0) return;
    if (textArray.count == 1) {
        self.label_0.text = textArray[0];
    }
    else {
        self.label_0.text = textArray[0];
        self.label_0.tag = 0;
        self.label_1.text = textArray[1];
        self.label_1.tag = 1;
        _showCount = 1;
        // 防止上一次动画没有完成，会一直加载两次动画，所以延迟一下执行
        [self performSelector:@selector(startAnimation) withObject:nil afterDelay:0.1];
    }
}

- (void)reloadLabel {
    [_label_0.layer removeAllAnimations];
    [_label_1.layer removeAllAnimations];
    [_label_0 removeFromSuperview];
    _label_0 = nil;
    [_label_1 removeFromSuperview];
    _label_1 = nil;
    _wichOne = NO;
    _showCount = 0;
}

- (UILabel *)label_0 {
    if (!_label_0) {
        _label_0 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _label_0.backgroundColor = [UIColor clearColor];
        _label_0.textColor = _textColor;
        _label_0.textAlignment = _textAlignment;
        _label_0.font = _font;
        [self addSubview:_label_0];
    }
    return _label_0;
}

- (UILabel *)label_1 {
    if (!_label_1) {
        _label_1 = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.bounds.size.width, self.bounds.size.height)];
        _label_1.backgroundColor = [UIColor clearColor];
        _label_1.textColor = _textColor;
        _label_1.textAlignment = _textAlignment;
        _label_1.font = _font;
        [self addSubview:_label_1];
    }
    return _label_1;
}

- (void)tapOnLabel:(UILabel *)label {
    if (_clickedLabel) {
        self.clickedLabel(label.tag);
    }
}

- (void)startAnimation {
    _stopAnimate = NO;
    if (![self isCurrentViewControllerVisible:[self viewController]]) { // 处于非当前页面
        // 防止上一次动画没有完成，会一直加载两次动画，所以延迟一下执行
        [self performSelector:@selector(startAnimation) withObject:nil afterDelay:0.1];
        
    }else{
        
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:1.0 delay:_timeInterVal options:0 animations:^{
            if (!_wichOne) {
                _label_0.frame = CGRectMake(0, -self.frame.size.height, _label_0.frame.size.width, _label_0.frame.size.height);
                _label_1.frame = CGRectMake(0, 0, _label_1.frame.size.width, _label_1.frame.size.height);
            }
            else {
                _label_0.frame = CGRectMake(0, 0, _label_0.frame.size.width, _label_0.frame.size.height);
                _label_1.frame = CGRectMake(0, -self.frame.size.height, _label_1.frame.size.width, _label_1.frame.size.height);
            }
        } completion:^(BOOL finished) {
            if (!_stopAnimate) {
                _wichOne = !_wichOne;
                _showCount++;
                if (_showCount > _textArray.count - 1) {
                    _showCount = 0;
                }
                
                if (_label_0.frame.origin.y == -self.frame.size.height) {
                    _label_0.frame = CGRectMake(0, self.frame.size.height, _label_0.frame.size.width, _label_0.frame.size.height);
                    _label_0.text = _textArray[_showCount];
                    _label_0.tag = _showCount;
                }
                if (_label_1.frame.origin.y == -self.frame.size.height) {
                    _label_1.frame = CGRectMake(0, self.frame.size.height, _label_1.frame.size.width, _label_1.frame.size.height);
                    _label_1.text = _textArray[_showCount];
                    _label_1.tag = _showCount;
                }
                [weakSelf startAnimation];
            }
        }];
    }
}

- (void)clickedself:(UITapGestureRecognizer *)gesture {
    CGPoint touchPoint = [gesture locationInView:self];
    if (_wichOne) {
        if ([self.label_1.layer.presentationLayer hitTest:touchPoint]) {
            [self tapOnLabel:self.label_1];
        }
    }
    else {
        if ([self.label_0.layer.presentationLayer hitTest:touchPoint]) {
            [self tapOnLabel:self.label_0];
        }
    }
}

-(BOOL)isCurrentViewControllerVisible:(UIViewController *)viewController{
    return (viewController.isViewLoaded && viewController.view.window);
}

- (UIViewController *)viewController {
    for (UIView * next = [self superview]; next; next = next.superview) {
        UIResponder * nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
