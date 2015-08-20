//
//  ButtonLabelView.h
//  SohuDome
//
//  Created by lanou3g on 15/6/12.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadButtonView.h"


typedef void(^buttonBlocks)(int);

@interface ButtonLabelViewReusableView : UICollectionReusableView
@property(nonatomic,retain)HeadButtonView *buttonView;
@property(nonatomic,copy)buttonBlocks tblock;

-(void)setTiltle:(NSString *)string;

@end
