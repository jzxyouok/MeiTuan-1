//
//  UIImage+Extension.m
//  河科院微博
//
//  Created by 👄 on 15/6/4.
//  Copyright (c) 2015年 sczy. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
// 如果是iOS7，自动在图片名后面加上_os7
//+(UIImage *)imageWithName:(NSString *)name
//{
//    //    NSString *newName = nil;
//    //    if(iOS7)
//    //    {
//    //       newName = [name stringByAppendingString:@"_os7"];
//    //    }
//    //    else
//    //    {
//    //        newName = name;
//    //    }
//    //
//    //    UIImage *image = [UIImage imageNamed:newName];
//    //
//    //    if (!image) {
//    //        image = [UIImage imageNamed:name];
//    //    }
//    
//    
//    UIImage *image = nil;
//    if (iOS7) {
//        NSString *newName = [name stringByAppendingString:@"_os7"];
//        image = [UIImage imageNamed:newName];
//    }
//    
//    // 如果是6或者7（67同用一张）image都为空！
//    if (!image) {
//        image = [UIImage imageNamed:name];
//    }
//    return image;
//}

+ (UIImage *)resizeImageWithName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageH * 0.5, imageW * 0.5, imageH * 0.5, imageW * 0.5) resizingMode:UIImageResizingModeStretch];
    return image;
}

- (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)scaleFromImage:(UIImage *)image
{
    CGSize size = image.size;
    CGSize newSize = CGSizeMake(size.width / 2, size.height / 2);
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}

-(UIImage*)getSubImage:(CGRect)rect
{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}


@end
