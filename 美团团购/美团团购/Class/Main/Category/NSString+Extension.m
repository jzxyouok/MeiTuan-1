//
//  NSString+Extension.m
//  包子微博
//
//  Created by 尚承教育 on 15/6/7.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

+ (CGSize)sizeWithString:(NSString *)string fontSize:(CGFloat)fontSize maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight
{
    
    CGSize maxSize = CGSizeMake(maxWidth, maxHeight);
    NSDictionary *stringDict = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    return [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:stringDict context:nil].size;
}

- (CGSize)sizeWithfont:(UIFont *)font maxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight
{
    CGSize maxSize = CGSizeMake(maxWidth, maxHeight);
    NSDictionary *stringDict = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:stringDict context:nil].size;
}

+(NSString*)encodeString:(NSString*)unencodedString{
    
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    return encodedString;
}

//URLDEcode
-(NSString *)decodeString:(NSString*)encodedString

{
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}



@end
