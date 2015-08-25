//
//  BZGroupBuyCellListPriceLabel.m
//  美团团购
//
//  Created by 尚承教育 on 15/7/21.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import "BZGroupBuyCellListPriceLabel.h"

@implementation BZGroupBuyCellListPriceLabel


- (void)drawRect:(CGRect)rect
{
     [super drawRect:rect];
//    UIRectFill(CGRectMake(0, rect.size.height * 0.5, rect.size.width, 1));
    // 画线
    // 拿到上下文
   
    CGContextRef ctf = UIGraphicsGetCurrentContext();
    
    // 起点
    CGContextMoveToPoint(ctf, 0, rect.size.height * 0.5);
    
    // 另一个点
    CGContextAddLineToPoint(ctf, rect.size.width, rect.size.height * 0.5);
    
    
    // 渲染
    CGContextDrawPath(ctf, kCGPathEOFillStroke);

}

@end
