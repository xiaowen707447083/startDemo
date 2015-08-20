//
//  LibiaryCollectionViewCell.m
//  SohuDome
//
//  Created by lanou3g on 15/6/11.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import "LibiaryCollectionViewCell.h"
#import "UIImageView+WebCache.h"


@interface LibiaryCollectionViewCell ()

@property(nonatomic,retain)UIImageView *imageView;
@property(nonatomic,retain)UILabel *label;


@end
@implementation LibiaryCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - 50) / 2, 0, 80
                                                                      , 80)];
        _imageView.layer.cornerRadius = _imageView.frame.size.height / 2;
        _imageView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
   
        _imageView.layer.masksToBounds = YES;
        
        [self addSubview:_imageView];
        
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height - 25, frame.size.width, 25)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:10];
        [self addSubview:_label];
    }
    return self;
}


- (void)setClassInfo:(MovieClassifyInfo *)classInfo
{
    [_imageView sd_setImageWithURL:[NSURL URLWithString:classInfo.icon_url]];
    
    [_label setText:classInfo.title];
}


@end
