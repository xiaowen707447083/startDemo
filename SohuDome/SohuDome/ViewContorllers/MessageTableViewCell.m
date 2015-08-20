//
//  MessageTableViewCell.m
//  SouhuDome
//
//  Created by 吴艳磊 on 15/6/11.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import "MessageTableViewCell.h"
#define kLabelFont [UIFont systemFontOfSize:10]
#define kMyViewWidth self.frame.size.width


@implementation MessageTableViewCell

- (void)dealloc
{
    [_actorLabel release];
    [_directorLabel release];
    [_yearLabel release];
    [_release_areaLabel release];
    [_genresLabel release];
    [_ratingLabel release];
    [_introLabel release];
    [self.imageView release];
    [super dealloc];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.actorLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.actorLabel];
        [self.actorLabel release];
        
        self.directorLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.directorLabel];
        [self.directorLabel release];
        
        self.yearLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.yearLabel];
        [self.yearLabel release];
        
        self.release_areaLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.release_areaLabel];
        [self.release_areaLabel release];
        
        self.genresLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.genresLabel];
        [self.genresLabel release];
        
        self.ratingLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.ratingLabel];
        [self.ratingLabel release];
        
        self.introLabel = [[UILabel alloc] init];
        [self.contentView addSubview:self.introLabel];
        [self.introLabel release];
        
        self.MyImageView = [[UIImageView alloc] init];
        [self.MyImageView setImage:[UIImage imageNamed:@"jiantou.png"]];
        [self.contentView addSubview:self.MyImageView];
        [self.MyImageView release];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.directorLabel.frame = CGRectMake(10, 10, self.frame.size.width / 2 - 10, 10);
    self.directorLabel.textAlignment = NSTextAlignmentLeft;
    self.directorLabel.font = kLabelFont;
    
    self.yearLabel.frame = CGRectMake(kMyViewWidth / 2, 10, self.frame.size.width / 2, 10);
    self.yearLabel.textAlignment = NSTextAlignmentLeft;
    self.yearLabel.font = kLabelFont;
    
    self.actorLabel.frame = CGRectMake(10, self.directorLabel.frame.size.height + self.directorLabel.frame.origin.y, kMyViewWidth - 20, 10);
    self.actorLabel.font = kLabelFont;
    self.actorLabel.textAlignment = NSTextAlignmentLeft;
    
    self.release_areaLabel.frame = CGRectMake(10, self.actorLabel.frame.size.height + self.actorLabel.frame.origin.y, kMyViewWidth / 2 - 10, 10);
    self.release_areaLabel.textAlignment = NSTextAlignmentLeft;
    self.release_areaLabel.font = kLabelFont;
    
    self.genresLabel.frame = CGRectMake(kMyViewWidth / 2, self.release_areaLabel.frame.origin.y, kMyViewWidth, 10);
    self.genresLabel.font = kLabelFont;
    self.genresLabel.textAlignment = NSTextAlignmentLeft;
    
    self.ratingLabel.frame = CGRectMake(10, self.genresLabel.frame.size.height + self.genresLabel.frame.origin.y, kMyViewWidth, 10);
    self.ratingLabel.textAlignment = NSTextAlignmentLeft;
    UIFont *font = [UIFont systemFontOfSize:12.0f];
    NSDictionary  *dic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    CGSize actualsize = [self.detailInfo.intro boundingRectWithSize:CGSizeMake(300.f, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    self.ratingLabel.font = kLabelFont;
    _introLabel.frame =  CGRectMake(10, self.ratingLabel.frame.size.height + self.ratingLabel.frame.origin.y, self.frame.size.width - 20, actualsize.height);

    
    if (self.frame.size.height != 80) {
        self.introLabel.hidden = NO;
        self.MyImageView.frame = CGRectMake(self.frame.size.width / 2 - 10, _introLabel.frame.size.height + _introLabel.frame.origin.y, 20, 20);
        self.MyImageView.transform = CGAffineTransformMakeRotation(M_PI);

    } else {
        self.introLabel.hidden = YES;

        self.MyImageView.frame = CGRectMake(self.frame.size.width / 2 - 10, _ratingLabel.frame.size.height + _ratingLabel.frame.origin.y, 20, 20);
        self.MyImageView.transform = CGAffineTransformMakeRotation(0);

    }

    self.introLabel.textAlignment = NSTextAlignmentLeft;
    self.introLabel.font = kLabelFont;
}

- (void)setDetailInfo:(MovieDetailInfo *)detailInfo
{
    _detailInfo = detailInfo;
    _actorLabel.text = [NSString stringWithFormat:@"主演:%@", detailInfo.actor];
    _directorLabel.text = [NSString stringWithFormat:@"导演:%@", detailInfo.director];
    _yearLabel.text = [NSString stringWithFormat:@"年代:%@", detailInfo.year];
    _release_areaLabel.text = [NSString stringWithFormat:@"地区:%@", detailInfo.release_area];
    _genresLabel.text = [NSString stringWithFormat:@"类型:%@", detailInfo.genres];
    _ratingLabel.text = [NSString stringWithFormat:@"评分:%@", detailInfo.rating];
    _introLabel.text = detailInfo.intro;

    _introLabel.numberOfLines = 0;
    [_introLabel sizeToFit];
}





- (void)awakeFromNib {
    // Initialization code
}



@end
