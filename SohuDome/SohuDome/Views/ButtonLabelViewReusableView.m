//
//  ButtonLabelView.m
//  SohuDome
//
//  Created by lanou3g on 15/6/12.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import "ButtonLabelViewReusableView.h"

@implementation ButtonLabelViewReusableView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self ) {
        
        self.buttonView = [[HeadButtonView alloc] initWithFrame:
                           CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:self.buttonView];
        [self.buttonView.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}
-(void)buttonAction:(UIButton *)button
{
    self.tblock((int)(button.tag-1)/100);
}

-(void)setTiltle:(NSString *)string
{
    self.buttonView.TitilLabel.text = string;
}
@end
