//
//  ScreenShot.m
//  MyShowCase
//
//  Created by kufufu on 15/7/28.
//  Copyright (c) 2015年 Wikky. All rights reserved.
//

#import "ScreenShot.h"


@implementation ScreenShot
-(UIImage*)screenShot:(UITableView *)tableView
{
    
    UIImage* viewImage = nil;
    UITableView *scrollView = tableView;
    UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, scrollView.opaque, 0.0);
    {
        CGPoint savedContentOffset = scrollView.contentOffset;
        CGRect savedFrame = scrollView.frame;
        
        scrollView.contentOffset = CGPointZero;
        scrollView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height);
        
        [scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
        viewImage = UIGraphicsGetImageFromCurrentImageContext();
        
        scrollView.contentOffset = savedContentOffset;
        scrollView.frame = savedFrame;
    }
    UIGraphicsEndImageContext();
    // 把截图后的图片存在了本地相册里面
//    UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);
    
    return viewImage;
}

@end
