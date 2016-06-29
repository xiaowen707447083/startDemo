//
//  UIImageView+MMWebImage.m
//  GWOrderingSystem
//
//  Created by John on 14-7-21.
//  Copyright (c) 2014年 GateWang. All rights reserved.
//

#import "UIImageView+MMWebImage.h"

@implementation UIImageView (MMWebImage)

-(void)setWebImage:(NSURL *)aUrl{
    UIActivityIndicatorView *ai=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    ai.tag=20000;
    [self addSubview:ai];
    [ai setCenter:self.center];
    [ai startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        //没有下载过这张图片的情况下
        
        //配置下载路径
        NSString *path=[NSHomeDirectory() stringByAppendingFormat:@"/Library/Caches/%u",aUrl.description.hash];
        
        NSData *data=[NSData dataWithContentsOfFile:path];
        if (!data) {
            NSLog(@"准备下载到沙盒路径:%@",path);
            data=[NSData dataWithContentsOfURL:aUrl];
            
            [data writeToFile:path atomically:YES];
        }
        UIImage *image=[UIImage imageWithData:data];

        dispatch_async(dispatch_get_main_queue(), ^{
            [ai stopAnimating];
            [ai removeFromSuperview];
            [self setImage:image];

        });
    });
}

-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

@end
