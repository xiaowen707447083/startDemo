//
//  NSString+LanguageString.m
//  NewGWPhone
//
//  Created by 钟天任 on 15/10/22.
//  Copyright (c) 2015年 梁宇辉. All rights reserved.
//

#import "NSString+LanguageString.h"

@implementation NSString (LanguageString)


- (NSString *)languageAdaption {
    
    NSString *language = [LanguageManager getCurrentLanguage];
    
    
    if ([language isEqualToString:FOLLOW_SYSTEM]) {
        return [self getSystemString];
    }
    else {
        return [self getCustomStringForLanguage:language];
    }
}

- (NSString *)getSystemString {
    NSString *fileName = [[LanguageManager systemLanguage] stringByAppendingString:@"File"];
    
    
    NSString *str = NSLocalizedStringFromTable(self, fileName, nil);
    if (str == nil) {
        //未支持的返回英文
        str = self;
    }
    
    return str;
}

- (NSString *)getCustomStringForLanguage:(NSString *)language {
    NSString *tableName = [language stringByAppendingString:@"File"];
    return NSLocalizedStringFromTable(self, tableName, nil);
}

@end
