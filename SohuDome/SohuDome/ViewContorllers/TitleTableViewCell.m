//
//  TitleTableViewCell.m
//  SouhuDome
//
//  Created by 吴艳磊 on 15/6/11.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import "TitleTableViewCell.h"

@implementation TitleTableViewCell


- (void)dealloc
{
    [_label release];
    [_libiaryButton release];
    [_introLabel release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.label = [[UILabel alloc] init];
        [self.contentView addSubview:self.label];
        
        self.libiaryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:self.libiaryButton];
        [self.label release];
        [self.libiaryButton release];
        self.introLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.introLabel];
        [self.introLabel release];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.label.frame = CGRectMake(10, 10, self.frame.size.width - 100, 20);
    self.label.font = [UIFont systemFontOfSize:20];
    self.label.textAlignment = NSTextAlignmentLeft;
    
    self.libiaryButton.frame = CGRectMake(self.frame.size.width - 40, (self.frame.size.height - 32) / 2, 32, 32);
    [self.libiaryButton setImage:[UIImage imageNamed:@"3.png"] forState:UIControlStateNormal];
    self.libiaryButton.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);

}

- (void)setMovie:(MovieDetailInfo *)movie
{
    self.label.text = movie.title;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
