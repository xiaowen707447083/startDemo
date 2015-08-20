//
//  JSTableViewCell.m
//  SohuDome
//
//  Created by lanou3g on 15/6/14.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import "JSTableViewCell.h"

@interface JSTableViewCell ()

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,assign)int indext;

@end

@implementation JSTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 375, 50)];
        _scrollView.alwaysBounceHorizontal = NO;
        _scrollView.alwaysBounceVertical = NO;
        _scrollView.bouncesZoom = NO;
        _indext = 100;
        [self.contentView addSubview:_scrollView];
        
    }
    
    return self;
}

-(void)setCount:(int)count
{
    if (count > 5) {
        _scrollView.contentSize = CGSizeMake(375+(count -5)*75, 0);
    }
    for (int a = 0; a< count; a++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake(65*a + 5*a , 5, 65, 40);
        [button setTitle:[NSString stringWithFormat:@"%d",a+1] forState:UIControlStateNormal];
        button.tag = (a+1)*100;
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        button.layer.borderWidth = 1;
        button.layer.borderColor = [UIColor grayColor].CGColor;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
    }
    
}


-(void)buttonAction:(UIButton *)button
{
    UIButton *buttons = (UIButton *)[_scrollView viewWithTag:_indext];
    [buttons setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    buttons.layer.borderColor = [UIColor grayColor].CGColor;
    
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.layer.borderColor = [UIColor redColor].CGColor;
    _indext = (int)button.tag;
    self.myBlock(_indext);

}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
