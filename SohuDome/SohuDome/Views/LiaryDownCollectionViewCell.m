//
//  LiaryDownCollectionViewCell.m
//  SohuDome
//
//  Created by lanou3g on 15/6/12.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import "LiaryDownCollectionViewCell.h"

@interface LiaryDownCollectionViewCell ()
@property(nonatomic,retain)UILabel *lable;
@end

@implementation LiaryDownCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.lable = [[UILabel alloc]initWithFrame:CGRectMake((self.frame.size.width - 50) / 7, 0, 100,30)];
        _lable.backgroundColor = [UIColor whiteColor];
        _lable.layer.borderWidth = 2;
        _lable.layer.borderColor = [UIColor redColor].CGColor;
        _lable.textColor = [UIColor grayColor];
        _lable.textAlignment = NSTextAlignmentCenter;
        _lable.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:_lable];
        }
    return self;
}

- (void)setClassInfo:(MovieClassifyInfo *)classInfo
{
    _lable.text = classInfo.title;
}

@end
