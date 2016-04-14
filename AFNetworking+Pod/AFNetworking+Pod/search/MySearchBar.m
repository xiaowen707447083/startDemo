//
//  MySearchBar.m
//  AFNetworking+Pod
//
//  Created by shenba on 16/4/14.
//  Copyright © 2016年 xiaowen. All rights reserved.
//

#import "MySearchBar.h"

@interface MySearchBar()<UITextFieldDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)UIView *topTextView;

@end


@implementation MySearchBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self createMyView];
    }
    return self;
}


-(void)createMyView{
    
    float marget = 2;
    float width = self.frame.size.width;
    float height = self.frame.size.height;
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = marget*2;
    self.layer.masksToBounds = YES;
    
    CGFloat imageViewWidth = height/2;
    CGFloat indexyImageView = (height-imageViewWidth)/2;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(marget*2, indexyImageView, imageViewWidth,imageViewWidth)];
    _imageView.userInteractionEnabled = YES;
    _imageView.image = [UIImage imageNamed:@"home_search"];
    [self addSubview:_imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
    //设置点击次数
    tap.numberOfTapsRequired = 1;//主要
    //将这个手势添加到图片上
    [_imageView addGestureRecognizer:tap];
    

    
    _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(_imageView.frame.size.width+marget*4, marget, width-_imageView.frame.size.width-marget*6, height-marget*2)];
    _searchTextField.delegate = self;
    _searchTextField.textAlignment = NSTextAlignmentLeft;
    _searchTextField.returnKeyType = UIReturnKeySearch;
    [self addSubview:_searchTextField];
    
    _topTextView = [[UIView alloc] initWithFrame:_searchTextField.frame];
    _topTextView.backgroundColor = [UIColor clearColor];
    [self addSubview:_topTextView];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickMyTextFile)];
    //设置点击次数
    tap1.numberOfTapsRequired = 1;//主要
    //将这个手势添加到图片上
    [_topTextView addGestureRecognizer:tap1];
    
    
}


-(void)setIsClick:(Boolean)isClick{
    if (isClick) {
        _topTextView.hidden = YES;
    }else{
        _topTextView.hidden = NO;
    }
}

#pragma -mark 点击图片
-(void)click{
    if (_myDelegate) {
    if ( [_myDelegate respondsToSelector: @selector(onclickImageLeft)] == YES ) {
        [_myDelegate performSelector:@selector(onclickImageLeft)];
        }
    }
}


#pragma -mark 点击其他
-(void)clickMyTextFile{
    if (_myDelegate) {
        if ( [_myDelegate respondsToSelector: @selector(onclickTextFile)] == YES ) {
            [_myDelegate performSelector:@selector(onclickTextFile)];
        }
    }
}

#pragma -mark 点击搜索
-(void)searchText:(NSString *)text{
    
}


#pragma -mark --------------------- textfile delegate -----------------
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    //去空格
    NSString *resultStr =  [textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([resultStr isEqualToString:@""]) {
        //
        if (_myDelegate) {
            if ( [_myDelegate respondsToSelector: @selector(searchAnSuccess)] == YES ) {
                [_myDelegate performSelector:@selector(searchAnSuccess)];
            }
        }
        
        
        
        return YES;
    }
    
    if (_myDelegate) {  
        
        if ( [_myDelegate respondsToSelector: @selector(searchText:)] == YES ) {
            [_myDelegate performSelector:@selector(searchText:) withObject:resultStr];
        }
    }
    
    return YES;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
