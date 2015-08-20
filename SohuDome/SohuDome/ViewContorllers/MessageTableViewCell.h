//
//  MessageTableViewCell.h
//  SouhuDome
//
//  Created by 吴艳磊 on 15/6/11.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieDetailInfo.h"

@interface MessageTableViewCell : UITableViewCell

@property (nonatomic, retain) UILabel* actorLabel;
@property (nonatomic, retain) UILabel* directorLabel;
@property (nonatomic, retain) UILabel* yearLabel;
@property (nonatomic, retain) UILabel* release_areaLabel;
@property (nonatomic, retain) UILabel* genresLabel;
@property (nonatomic, retain) UILabel* ratingLabel;
@property (nonatomic, retain) UILabel* introLabel;

@property (nonatomic, retain) UIImageView* MyImageView;

@property (nonatomic, retain) MovieDetailInfo* detailInfo;



@end
