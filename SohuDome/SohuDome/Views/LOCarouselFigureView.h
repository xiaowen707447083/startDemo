//
//  LOCarouselFigureView.h
//  VideoTest
//
//  Created by 吴艳磊 on 15/6/9.
//  Copyright (c) 2015年 Mike. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LOPageControll.h"

@protocol LOCarouselFigureViewDelegate <NSObject>

@optional
-(void)tapImage:(NSUInteger)index;

@end

@interface LOCarouselFigureView : UIView <UIScrollViewDelegate, LOCarouselFigureViewDelegate>

{
    LOPageControll *_loPageControll;
    UIScrollView *_scrollView;
    UILabel *_textLabel;
}

@property (nonatomic, assign) id<LOCarouselFigureViewDelegate> delegate;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSArray *imagesArray;

@property (nonatomic, assign) NSTimeInterval *timerInterval;

@property (nonatomic, assign) NSInteger currentImage;

@property (nonatomic, assign) NSTimer *random;

@end
