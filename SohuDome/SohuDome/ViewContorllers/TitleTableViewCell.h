//
//  TitleTableViewCell.h
//  SouhuDome
//
//  Created by 吴艳磊 on 15/6/11.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieDetailInfo.h"

@interface TitleTableViewCell : UITableViewCell

@property (nonatomic, retain) UILabel* label;
@property (nonatomic, retain) UIButton* libiaryButton;
@property (nonatomic, retain) UILabel* introLabel;

@property (nonatomic, retain) MovieDetailInfo* movie;


@end
