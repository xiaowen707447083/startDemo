//
//  UIImageView+MyImageView.m
//  LanouBProject
//
//  Created by lanou on 15/8/6.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "UIImageView+MyImageView.h"

@implementation UIImageView (MyImageView)

//根据尺寸剪切图片
-(void)setImageSizeToFit:(UIImage *)image
{
    CGFloat width = self.frame.size.width;//view的宽读
    CGFloat height = self.frame.size.height;//view的高度
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((image.size.width / image.size.height) < width / height) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * width / height;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * width / height;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    
    [self setImage:[UIImage imageWithCGImage:imageRef]];
}

//根据比例获取新的图片
+(UIImage *)imageWithRect:(UIImage *)image width:(CGFloat)width height:(CGFloat)height
{
    
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((image.size.width / image.size.height) < width / height) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * width / height;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * width / height;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    
    return [UIImage imageWithCGImage:imageRef];
    
}

//显示loading动画
-(void)loading{
    
    UIImage *img1 = [UIImage imageNamed:@"loading__1.png"];
    UIImage *img2 = [UIImage imageNamed:@"loading__2"];
    UIImage *img3 = [UIImage imageNamed:@"loading__3"];
    UIImage *img4 = [UIImage imageNamed:@"loading__4"];
    UIImage *img5 = [UIImage imageNamed:@"loading__5"];
    UIImage *img6 = [UIImage imageNamed:@"loading__6"];
    UIImage *img7 = [UIImage imageNamed:@"loading__7"];
    UIImage *img8 = [UIImage imageNamed:@"loading__8"];
    UIImage *img9 = [UIImage imageNamed:@"loading__9"];
    UIImage *img10 = [UIImage imageNamed:@"loading__10"];
    UIImage *img11 = [UIImage imageNamed:@"loading__11"];
    UIImage *img12 = [UIImage imageNamed:@"loading__12"];
    
    self.animationImages = [NSArray arrayWithObjects:img1,img2,img3,img4,img5,img6,img7,img8,img9,img10,img11,img12, nil];
    self.animationDuration = 1;
    
    [self startAnimating];
    
}

//隐藏loading动画
-(void)cancelLoading{
    [self stopAnimating];
}

@end
