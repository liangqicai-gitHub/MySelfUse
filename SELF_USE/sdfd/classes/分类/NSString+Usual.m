//
//  NSString+Usual.m
//  sdfd
//
//  Created by 梁齐才 on 16/5/26.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "NSString+usual.h"

@implementation NSString (Usual)

+ (BOOL)isEmptyString:(NSString *)string
{
    if (![string isKindOfClass:[NSString class]]){
        return YES;
    };
    
    return [string trimString].length == 0;
}

+ (NSString *)documentsDirectory
{
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}


- (NSString *)trimString
{
    NSCharacterSet *spaceSet = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:spaceSet];
}



- (CGFloat)expectHeight:(CGFloat)labelWidth font:(UIFont *)font lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    NSLineBreakMode correntMode = NSLineBreakByWordWrapping;
    if (lineBreakMode == NSLineBreakByCharWrapping){
        correntMode = NSLineBreakByCharWrapping;
    }
    [style setLineBreakMode:correntMode];
    
    
    NSStringDrawingOptions op = (NSStringDrawingUsesLineFragmentOrigin |
                                 NSStringDrawingUsesFontLeading|
                                 NSStringDrawingTruncatesLastVisibleLine
                                 );
    
    
    CGRect textRect = [self
                       boundingRectWithSize:CGSizeMake(labelWidth, 8000)
                       options:op
                       attributes:@{NSFontAttributeName:font,
                                    NSParagraphStyleAttributeName:style
                                    }
                       context:nil];
    
    return CGRectGetHeight(textRect);

}


- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}


@end
