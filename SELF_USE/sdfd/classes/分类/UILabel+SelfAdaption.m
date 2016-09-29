//
//  UILabel+SelfAdaption.m
//  sdfd
//
//  Created by 梁齐才 on 16/6/8.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "UILabel+SelfAdaption.h"

@implementation UILabel (SelfAdaption)


//@property(NS_NONATOMIC_IOSONLY) CGFloat lineSpacing;
//@property(NS_NONATOMIC_IOSONLY) CGFloat paragraphSpacing;
//@property(NS_NONATOMIC_IOSONLY) NSTextAlignment alignment;
//@property(NS_NONATOMIC_IOSONLY) CGFloat firstLineHeadIndent;
//@property(NS_NONATOMIC_IOSONLY) CGFloat headIndent;
//@property(NS_NONATOMIC_IOSONLY) CGFloat tailIndent;
//@property(NS_NONATOMIC_IOSONLY) NSLineBreakMode lineBreakMode;
//@property(NS_NONATOMIC_IOSONLY) CGFloat minimumLineHeight;
//@property(NS_NONATOMIC_IOSONLY) CGFloat maximumLineHeight;
//@property(NS_NONATOMIC_IOSONLY) NSWritingDirection baseWritingDirection;
//@property(NS_NONATOMIC_IOSONLY) CGFloat lineHeightMultiple;
//@property(NS_NONATOMIC_IOSONLY) CGFloat paragraphSpacingBefore;
//@property(NS_NONATOMIC_IOSONLY) float hyphenationFactor;
//@property(null_resettable, copy, NS_NONATOMIC_IOSONLY) NSArray<NSTextTab *> *tabStops NS_AVAILABLE(10_0, 7_0);
//@property(NS_NONATOMIC_IOSONLY) CGFloat defaultTabInterval NS_AVAILABLE(10_0, 7_0);
//@property(NS_NONATOMIC_IOSONLY) BOOL allowsDefaultTighteningForTruncation NS_AVAILABLE(10_11, 9_0);

- (CGFloat)heightInWidth:(CGFloat)width string:(NSString *)string
{
    NSParagraphStyle *defaulStyle = [NSParagraphStyle defaultParagraphStyle];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.lineSpacing = defaulStyle.lineSpacing;
    paragraphStyle.paragraphSpacing = defaulStyle.paragraphSpacing;
    paragraphStyle.alignment = self.textAlignment;
    paragraphStyle.firstLineHeadIndent = defaulStyle.firstLineHeadIndent;
    paragraphStyle.headIndent = defaulStyle.headIndent;
    paragraphStyle.tailIndent = defaulStyle.tailIndent;
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    paragraphStyle.minimumLineHeight = defaulStyle.minimumLineHeight;
    paragraphStyle.maximumLineHeight = defaulStyle.maximumLineHeight;
    paragraphStyle.baseWritingDirection = defaulStyle.baseWritingDirection;
    paragraphStyle.lineHeightMultiple = defaulStyle.lineHeightMultiple;
    paragraphStyle.paragraphSpacingBefore = defaulStyle.paragraphSpacingBefore;
    paragraphStyle.hyphenationFactor = defaulStyle.hyphenationFactor;
    paragraphStyle.tabStops = defaulStyle.tabStops;
    paragraphStyle.defaultTabInterval = defaulStyle.defaultTabInterval;
    
    UIDevice *device = [UIDevice currentDevice];
    float sysVersion = [device.systemVersion floatValue];
    if (sysVersion >= 9.0){
    
        [paragraphStyle setParagraphStyle:defaulStyle];
        [paragraphStyle setAlignment:self.textAlignment];
        
        NSLog(@"self %zd ",paragraphStyle.lineBreakMode);
        [paragraphStyle setLineBreakMode:NSLineBreakByClipping];
    }

    NSDictionary *attribute = @{NSFontAttributeName:self.font,
                                NSParagraphStyleAttributeName:defaulStyle
                                };
    
    NSStringDrawingOptions op = (NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading);
    

    CGRect rect = [string boundingRectWithSize:(CGSize){width,80000} options:op attributes:attribute context:nil];
    
    
    
    return CGRectGetHeight(rect);
}



@end
