//
//  ViewController.m
//  JWCycleLabel
//
//  Created by djw on 2017/5/5.
//  Copyright © 2017年 ubiquitous. All rights reserved.
//

#import "ViewController.h"
#import "JWCycleLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray *texts = [NSMutableArray array];
    for (int i = 0; i < 5; i++) {
        [texts addObject:[NSString stringWithFormat:@"这是第%d%d%d条数据", i, i, i]];
    }
    
    JWCycleLabel *cycleLabel = [[JWCycleLabel alloc] initWithFrame:CGRectMake(10, 100, 300, 40)];
    cycleLabel.backgroundColor = [UIColor blackColor];
    cycleLabel.textColor = [UIColor redColor];
    cycleLabel.textAlignment = NSTextAlignmentCenter;
    cycleLabel.font = [UIFont systemFontOfSize:15.0];
    cycleLabel.timeInterVal = 2.0;
    cycleLabel.canTap = YES;
    [self.view addSubview:cycleLabel];
    
    cycleLabel.clickedLabel = ^(NSUInteger index) {
        NSLog(@"%@", texts[index]);
    };
    
    [cycleLabel startWithTextArray:texts];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
