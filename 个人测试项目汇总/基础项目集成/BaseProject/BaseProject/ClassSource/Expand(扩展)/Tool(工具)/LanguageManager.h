//
//  LanguageManager.h
//  NewGWPhone
//
//  Created by 钟天任 on 15/10/28.
//  Copyright © 2015年 梁宇辉. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LanguageManager : NSObject

+ (NSString *)getCurrentLanguage;

+ (BOOL)setLanguage:(NSString *)language;

+ (NSString *)systemLanguage;

+ (NSString *)getLanguageName;

@end
