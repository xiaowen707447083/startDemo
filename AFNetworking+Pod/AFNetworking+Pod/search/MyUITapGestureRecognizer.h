//
//  MyUITapGestureRecognizer.h
//  FindHim
//
//  Created by 王旭 on 15/10/8.
//  Copyright © 2015年 com.xingfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyUITapGestureRecognizer : UITapGestureRecognizer

@property(nonatomic,assign)int myTag;
@property(nonatomic,strong)NSString *myTagStr;
@property(nonatomic,strong)UIView *myView;

@property(nonatomic,strong)NSString *expence;
@property(nonatomic,assign)int expenceTag;

@property(nonatomic,strong)NSObject *myTagObj;

@end
