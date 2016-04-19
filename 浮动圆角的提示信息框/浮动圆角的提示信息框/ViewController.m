//
//  ViewController.m
//  浮动圆角的提示信息框
//
//  Created by shenba on 16/4/19.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "ViewController.h"
#import "WSCoachMarksView.h"

@interface ViewController ()
{
    WSCoachMarksView *coachMarksView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *tempLable = [[UILabel alloc] initWithFrame:CGRectMake(50, 100, 200, 100)];
    tempLable.text = @"4444444444444444444444444444444444444444444444444";
    [self.view addSubview:tempLable];
    
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *coachMarks = @[@{@"rect":[NSValue valueWithCGRect:(CGRect){{0,0},{45,45}}],
                                @"caption":@"Helpful navigation menu",
                                @"shape":@"circle"},
                            @{@"rect":[NSValue valueWithCGRect:(CGRect){{10.0f,56.0f},{300.0f,56.0f}}],
                                @"caption":@"Document your wedding by taking photos",
                                @"shape":@"square"},
                            @{
                                @"rect":[NSValue valueWithCGRect:(CGRect){{10.0f,119.0f},{300.0f,56.0f}}],
                                @"caption":@"Your wedding photo album"
                                },
                            @{
                                @"rect":[NSValue valueWithCGRect:(CGRect){{10.0f,182.0f},{300.0f,56.0f}}],
                                @"caption":@"View and manage your friends & family"
                                },
                            @{
                                @"rect":[NSValue valueWithCGRect:(CGRect){{10.0f,245.0f},{300.0f,56.0f}}],
                                @"caption":@"Invite friends to get more photos",
                                },
                            @{
                                @"rect":[NSValue valueWithCGRect:(CGRect){{0.0f,410.0f},{320.0f,50.0f}}],
                                @"caption":@"Keep your guests informed with your wedding details"
                                }
                            ];
    coachMarksView = [[WSCoachMarksView alloc] initWithFrame:self.view.bounds coachMarks:coachMarks];
    [self.view addSubview:coachMarksView];
    
    coachMarksView.animationDuration = 0.5f;//动画切换时间
    coachMarksView.enableContinueLabel = NO;
    coachMarksView.maskColor = [UIColor colorWithHue:34.0f saturation:202.0f brightness:186.0f alpha:0.8f];//遮罩层颜色
//    coachMarksView.cutoutRadius = 50;//是否圆角,圆角的幅度
    
 
     [coachMarksView start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    // Show coach marks
    BOOL coachMarksShown = [[NSUserDefaults standardUserDefaults] boolForKey:@"WSCoachMarksShown"];
    if (coachMarksShown == NO) {
        // Don't show again
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"WSCoachMarksShown"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        // Show coach marks
//        [coachMarksView start];
        
        // Or show coach marks after a second delay
        // [coachMarksView performSelector:@selector(start) withObject:nil afterDelay:1.0f];
    }
}

@end
