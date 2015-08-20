//
//  HomePageCollectionCell.m
//  VideoText
//
//  Created by 吴艳磊 on 15/6/9.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import "HomePageCollectionCell.h"
#import "UIImageView+WebCache.h"

@interface HomePageCollectionCell  ()
{
    UIImageView *_imageView;
    UILabel * _textLabel;
}
@end



@implementation HomePageCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 20)];
        _imageView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_imageView];

        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height - 20, frame.size.width, 20)];
        
        _textLabel.text = @"123";
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:_textLabel];
    }
    return self;
}


-(void)setBaseInfo:(MovieBaseInfo *)baseInfo{
    if (![_baseInfo.img isEqualToString:@""]) {
          [_imageView sd_setImageWithURL:[NSURL URLWithString:baseInfo.img] placeholderImage:[UIImage imageNamed:@"1.jpg"]];
    }
    
    _textLabel.text = baseInfo.title;
    
}


@end
