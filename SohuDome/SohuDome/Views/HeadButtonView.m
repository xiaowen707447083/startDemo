//
//  HeadButtonView.m
//  SohuDome
//
//  Created by lanou3g on 15/6/12.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import "HeadButtonView.h"

@implementation HeadButtonView

-(instancetype)initWithFrame:(CGRect)frame
{    self = [super initWithFrame:frame];
    if (self) {
        self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _button.backgroundColor = [UIColor whiteColor];
        _button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:_button];
        self.TitilLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, frame.size.height)];
        self.TitilLabel.textColor = [UIColor blackColor];
        [self addSubview:_TitilLabel];
        self.TitilLabel.font = [UIFont systemFontOfSize:16.0f];
        
        self.moreLabel = [[UILabel alloc] initWithFrame:CGRectMake(frame.size.width-70 , 0, 60, frame.size.height)];
        self.moreLabel.textColor = [UIColor blueColor];
        self.moreLabel.text = @"更多>";
        self.moreLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:_moreLabel];
        self.moreLabel.font = [UIFont systemFontOfSize:14.0f];
       

        
        
        
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
