//
//  LOMovieView.h
//  VideoPlayer
//
//  Created by 吴艳磊 on 15/6/9.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LOMovieViewDelegate <NSObject>

@optional

- (void)movieViewWillFullScreen;
- (void)movieViewWillCancelFullScreen;

- (void)comeBackView;

@end

@interface LOMovieView : UIView

@property (nonatomic, assign) id<LOMovieViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame movieURL:(NSString *)urlString;

@end
