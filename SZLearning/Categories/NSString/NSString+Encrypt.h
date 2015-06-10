//
//  NSString+Encrypt.h
//  SZWIOSLearning
//
//  Created by Apple on 15/5/8.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  字符串的加密
 */

@interface NSString (Encrypt)

/* 32位MD5加密 */
@property (nonatomic,copy,readonly) NSString *md5;

/* SHA1加密 */
@property (nonatomic,copy,readonly) NSString *sha1;

@property (readonly) NSString *md5String;
@property (readonly) NSString *sha1String;
@property (readonly) NSString *sha256String;
@property (readonly) NSString *sha512String;
- (NSString *)hmacSHA1StringWithKey:(NSString *)key;
- (NSString *)hmacSHA256StringWithKey:(NSString *)key;
- (NSString *)hmacSHA512StringWithKey:(NSString *)key;

@end
