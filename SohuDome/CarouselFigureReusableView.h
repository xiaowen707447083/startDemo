//
//  CarouselFigureReusableView.h
//  MoviePlayer
//
//  Created by 吴艳磊 on 15/6/10.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LOCarouselFigureView.h"
typedef void (^CarouselFigureReusableViewBlock)(NSUInteger index);
typedef void(^headBlock)(int);
typedef void(^buttonBlock)(NSString *sting);

@interface CarouselFigureReusableView : UICollectionReusableView<LOCarouselFigureViewDelegate>



@property (nonatomic,copy)CarouselFigureReusableViewBlock selectedIndex;
@property (nonatomic,copy)buttonBlock block;
@property (nonatomic,copy)headBlock myBlock;



- (instancetype)initWithFrame:(CGRect)frame;

- (void)setImagee:(NSArray *)imgArr;

- (void)settilte:(NSString *)string;

@end
