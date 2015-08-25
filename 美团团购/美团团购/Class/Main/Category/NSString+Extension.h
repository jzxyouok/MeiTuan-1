//
//  NSString+Extension.h
//  包子微博
//
//  Created by 尚承教育 on 15/6/7.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
+ (CGSize)sizeWithString:(NSString *)string fontSize:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight;

- (CGSize)sizeWithfont:(UIFont *)font maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight;

+(NSString*)encodeString:(NSString*)unencodedString;
-(NSString *)decodeString:(NSString*)encodedString;
@end
