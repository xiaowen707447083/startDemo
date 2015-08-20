//
//  JSTableViewCell.h
//  SohuDome
//
//  Created by lanou3g on 15/6/14.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^buttonBlock)(int);

@interface JSTableViewCell : UITableViewCell
@property(nonatomic,assign)int count;
@property(nonatomic,copy)buttonBlock myBlock;
@end
