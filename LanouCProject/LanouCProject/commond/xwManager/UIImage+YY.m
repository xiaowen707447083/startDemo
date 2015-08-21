//
//  NSObject+YY.m
//  音频学习
//
//  Created by xiaowen on 15/8/6.
//  Copyright (c) 2015年 www.xiaowen. All rights reserved.
//

#import "UIImage+YY.h"
#import "UIView+MyView.h"

@implementation UIImage (YY)

//这里的截取如果图片大于width,跟height会截取宽高的一部分
//把图片进行适配之后,重新根据坐标比例截取 x_1,x_2,y_1,y_2都是比例系数,小于1. 其中x_1,y_1为开始截取位置,x_2,y_2是宽高
+(UIImage *)imageWithRect_type:(UIImage *)image width:(CGFloat)width height:(CGFloat)height x_1:(CGFloat)x_1 x_2:(CGFloat)x_2 y_1:(CGFloat)y_1 y_2:(CGFloat)y_2
{
    
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    //如果请求的比例比较小的话,截取图片
    if(image.size.width > width && image.size.height > height){
        
        newSize.height = width;
        newSize.width = height;
        
        //比例截取所需
        //比例截取所需
        CGFloat x = fabs(image.size.width - newSize.width) / 2 + newSize.width * x_1;
        CGFloat y = fabs(image.size.height - newSize.height) / 2 + newSize.height * y_1;
        CGFloat w = newSize.width * x_2;
        CGFloat h = newSize.height * y_2;
        printf("%.2f,%.2f,%.2f,%.2f\n",x,y,w,h);
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(x, y, w, h));
        
    }else if ((image.size.width / image.size.height) < width / height) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * width / height;
        
        //比例截取所需
        CGFloat x = newSize.width * x_1;
        CGFloat y = fabs(image.size.height - newSize.height) / 2 + newSize.height * y_1;
        CGFloat w = newSize.width * x_2;
        CGFloat h = newSize.height * y_2;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(x, y, w, h));
        
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * width / height;
        
        //比例截取所需
        //比例截取所需
        CGFloat x = fabs(image.size.width - newSize.width) / 2 + newSize.width * x_1;
        CGFloat y = newSize.height * y_1;
        CGFloat w = newSize.width * x_2;
        CGFloat h = newSize.height * y_2;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(x, y, w, h));
        
    }
    
    return [UIImage imageWithCGImage:imageRef];
    
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

+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    // 1.加载原图
        UIImage *oldImage = [UIImage imageNamed:name];
    
       // 2.开启上下文
        CGFloat imageW = oldImage.size.width + 2 * borderWidth;
       CGFloat imageH = oldImage.size.height + 2 * borderWidth;
        CGSize imageSize = CGSizeMake(imageW, imageH);
       UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
        // 3.取得当前的上下文
        CGContextRef ctx = UIGraphicsGetCurrentContext();

        // 4.画边框(大圆)
        [borderColor set];
        CGFloat bigRadius = imageW * 0.5; // 大圆半径
        CGFloat centerX = bigRadius; // 圆心
        CGFloat centerY = bigRadius;
        CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
        CGContextFillPath(ctx); // 画圆

        // 5.小圆
        CGFloat smallRadius = bigRadius - borderWidth;
        CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
        // 裁剪(后面画的东西才会受裁剪的影响)
       CGContextClip(ctx);
    
        // 6.画图
        [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];

// 7.取图
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
        // 8.结束上下文
        UIGraphicsEndImageContext();
    
    return newImage;
    
}



//保存到相册
UIView *view_my_xiangce;
+(void)saveToXiangCe:(UIImage *)img uiview:(UIView *)view {
    view_my_xiangce = view;
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
+(void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo{
    if (error != nil) {
        [view_my_xiangce toast:@"保存失败,请稍候再试" yOffset:0];
    }else{
       [view_my_xiangce toast:@"保存到相册成功" yOffset:0];
    }
}



@end
