//
//  CarouselFigureReusableView.m
//  MoviePlayer
//
//  Created by 吴艳磊 on 15/6/10.
//  Copyright (c) 2015年 吴艳磊. All rights reserved.
//

#import "CarouselFigureReusableView.h"
#import "LOCarouselFigureView.h"
#import "HeadButtonView.h"
@implementation CarouselFigureReusableView
{

   LOCarouselFigureView *_carouselFigure;
    HeadButtonView *_buttonView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _carouselFigure = [[LOCarouselFigureView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 40)];
        _carouselFigure.delegate = self;
      
        [self addSubview:_carouselFigure];
        _buttonView = [[HeadButtonView alloc] initWithFrame:CGRectMake(0, frame.size.height-40, frame.size.width, 40)];
        [_buttonView.button addTarget:self action:@selector(buttionAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_buttonView];
    }
    return self;
}

-(void)buttionAction:(UIButton *)sender
{
    self.block(@"dghdfjg");
}

-(void)tapImage:(NSUInteger)index
{
     self.myBlock((int)index);
}

- (void)settilte:(NSString *)string
{
    _buttonView.TitilLabel.text = string;
    
}


- (void)setImagee:(NSArray *)imgArr{
    _carouselFigure.imagesArray = imgArr;
    
}

- (void)carouseFigureView:(LOCarouselFigureView *)carouseFigureView didSelectedItemAtIndex:(NSUInteger)index{
  
    self.selectedIndex(index);

}

@end
