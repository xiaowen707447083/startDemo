//
//  UIImageView+MMWebImage.h
//  GWOrderingSystem
//
//  Created by John on 14-7-21.
//  Copyright (c) 2014年 GateWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (MMWebImage)
-(void)setWebImage:(NSURL *)aUrl;
-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size;
@end
