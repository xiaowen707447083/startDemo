//
//  LanguageManager.m
//  NewGWPhone
//
//  Created by 钟天任 on 15/10/28.
//  Copyright © 2015年 梁宇辉. All rights reserved.
//

#import "LanguageManager.h"

@implementation LanguageManager

+ (NSString *)getCurrentLanguage {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    return [user objectForKey:USER_LANGUAGE];
}

+ (NSString *)systemLanguage {
    
    NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    
    NSString *str = [languages firstObject] ;//后三个字符为地区
    
    if (notIOS9 == NO) {
        str = [str substringToIndex:str.length - 3];
    }
    
    return str;
}

+ (NSString *)getLanguageName {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *language = [user objectForKey:USER_LANGUAGE];
    
    if ([language isEqualToString:FOLLOW_SYSTEM]) {
        language = [@"System Default" languageAdaption];
    }
    else if ([language isEqualToString:ENGLISH]) {
        language = @"English";
    }
    else if ([language isEqualToString:CHINESE]) {
        language = @"中文";
    }
    else {
        language = @"unsupported";
    }
    return language;
}


+ (BOOL)setLanguage:(NSString *)language {
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:language forKey:USER_LANGUAGE];
    return [user synchronize];
}

@end
