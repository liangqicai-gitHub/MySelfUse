//
//  PeiChartView
//  sdfd
//
//  Created by 梁齐才 on 17/1/10.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "PeiChartView.h"


@implementation PieChartItem


@end


@interface PeiChartView ()
{
    CGFloat _radiusLengthen;
    CGFloat _titlePrefixLenght;
    CGFloat _textLength;
}


@end


@implementation PeiChartView

- (instancetype)init{
    self = [super init];
    if (self){
        [self initVars];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self){
        [self initVars];
    }
    return self;
}

- (void)initVars
{
    _radiusLengthen = 10.0f;
    _titlePrefixLenght = 10.0f;
    _textLength = [@"100.00%" sizeForFont:[UIFont systemFontOfSize:10]
                                     size:CGSizeMake(CGFLOAT_MAX, 12)
                                     mode:NSLineBreakByTruncatingTail].width;
}

- (CGSize)circleSize
{
    CGFloat maxWidth = MIN(self.frame.size.height,
                           self.frame.size.width);
    CGFloat extraWidth = _radiusLengthen + _titlePrefixLenght + _textLength;
    CGFloat diameter = maxWidth - extraWidth * 2;
    
    return CGSizeMake(diameter,
                      diameter);
}

- (void)setItems:(NSArray<PieChartItem *> *)items
{
    _smallestItemValue = MAX(_smallestItemValue, 0.0f);
    for (PieChartItem *oneItem in items) {
        oneItem.number = MAX(oneItem.number, _smallestItemValue);
    }
    
    _items = items;
}

- (CGFloat)totalValues
{
    CGFloat rs = 0.0f;
    for (PieChartItem *oneItem in _items) {
        rs += oneItem.number;
    }
    return rs;
}


- (NSArray <CAShapeLayer *>*)allSectors
{
    NSMutableArray *arr = [NSMutableArray array];
    
    CGFloat lastBegin = - M_PI / 2;
    CGFloat totalValues = [self totalValues];
    CGPoint center = CGPointMake(self.frame.size.width / 2.0f,
                                 self.frame.size.height / 2.0f);
    
    CGFloat maxRadius = [self circleSize].width / 2.0f;
    CGFloat realRingWidth = MIN(maxRadius, _ringWidth);
    CGFloat realRadius = (maxRadius - realRingWidth) + realRingWidth / 2.0f;
    
    for (NSInteger i = 0; i < _items.count; i++) {
        
        PieChartItem *oneItem = _items[i];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = oneItem.color.CGColor;
        double radian = ((double)oneItem.number / (double)totalValues) * M_PI * 2;
       
        UIBezierPath *path = [UIBezierPath
                              bezierPathWithArcCenter:center
                              radius:realRadius
                              startAngle:lastBegin
                              endAngle:lastBegin + radian - _itemsSpace
                              clockwise:YES];
        layer.path = path.CGPath;
        lastBegin += radian;
        layer.lineWidth = realRingWidth;
        [arr addObject:layer];
    }
    return arr;
}

- (NSArray <CAShapeLayer *>*)allRadiusLengthens
{
    NSMutableArray *arr = [NSMutableArray array];
    
    CGFloat lastBegin = - M_PI / 2;
    CGFloat totalValues = [self totalValues];
    CGPoint center = CGPointMake(self.frame.size.width / 2.0f,
                                 self.frame.size.height / 2.0f);
    CGFloat outerL = [self circleSize].width / 2.0f;
    CGFloat innerL = outerL - _ringWidth;
    innerL = MAX(0, innerL);
    
    for (NSInteger i = 0; i < _items.count; i++) {
        
        PieChartItem *oneItem = _items[i];
        CAShapeLayer *layer = [CAShapeLayer layer];
        UIBezierPath *path = [UIBezierPath bezierPath];
        layer.lineWidth = 1.0f;
        layer.strokeColor = oneItem.color.CGColor;
        layer.fillColor = [UIColor clearColor].CGColor;
        double radian = (oneItem.number / totalValues) * M_PI * 2;
        
        double startPointAngle = lastBegin + radian / 2.0f;
        
        CGPoint begin = CGPointMake(
                                   cos(startPointAngle) * outerL + center.x,
                                   sin(startPointAngle) * outerL + center.y
                                   );
        
        CGPoint end1 =  CGPointMake(
                                    cos(startPointAngle) * (outerL + _radiusLengthen) + center.x,
                                    sin(startPointAngle) * (outerL + _radiusLengthen) + center.y
                                    );
        
        CGPoint end2 = CGPointMake(end1.x + _titlePrefixLenght, end1.y);
        if (startPointAngle >= M_PI / 2.0f){
            end2 = CGPointMake(end1.x - _titlePrefixLenght, end1.y);
        }
        
        [path moveToPoint:begin];
        [path addLineToPoint:end1];
        [path addLineToPoint:end2];
        layer.path = path.CGPath;
        
        lastBegin += radian;
        [arr addObject:layer];
    }
    
    return arr;
}


- (NSArray <CATextLayer *>*)alltextLayer
{
    NSMutableArray *arr = [NSMutableArray array];
    
    CGFloat lastBegin = - M_PI / 2;
    CGFloat totalValues = [self totalValues];
    CGPoint center = CGPointMake(self.frame.size.width / 2.0f,
                                 self.frame.size.height / 2.0f);
    CGFloat outerL = [self circleSize].width / 2.0f;
    CGFloat innerL = outerL - _ringWidth;
    innerL = MAX(0, innerL);
    
    for (NSInteger i = 0; i < _items.count; i++) {
        
        PieChartItem *oneItem = _items[i];
        CATextLayer *layer = [CATextLayer layer];
        layer.backgroundColor = [UIColor clearColor].CGColor;
        CGFloat radian = oneItem.number / totalValues * M_PI * 2;
        CGFloat startPointAngle = lastBegin + (radian - _itemsSpace) / 2.0f;
        CGPoint end1 =  CGPointMake(
                                    cos(startPointAngle) * (outerL + _radiusLengthen) + center.x,
                                    sin(startPointAngle) * (outerL + _radiusLengthen) + center.y
                                    );
        
       
        CGPoint end2 = CGPointMake(end1.x + _titlePrefixLenght, end1.y);
        CGFloat layerX = end2.x;
        
        layer.alignmentMode = kCAAlignmentLeft;
        if (startPointAngle >= M_PI / 2.0f){
            end2 = CGPointMake(end1.x - _titlePrefixLenght, end1.y);
            layerX = end2.x - _textLength;
            layer.alignmentMode = kCAAlignmentRight;
        }
        NSString *text = [NSString stringWithFormat:@"%0.2f%%",oneItem.number / totalValues * 100];
        NSMutableAttributedString *textm = [[NSMutableAttributedString alloc]
                                            initWithString:text
                                            attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:10.0f],
                                                         NSForegroundColorAttributeName: oneItem.color
                                                         }
                                            ];
        CGFloat layerHeight = [text sizeForFont:[UIFont systemFontOfSize:10.0f]
                                           size:(CGSize){_textLength,CGFLOAT_MAX}
                                           mode:NSLineBreakByTruncatingTail].height;
        
        layer.string = textm;
        layer.frame = CGRectMake(layerX, end2.y - layerHeight / 2.0f, _textLength, layerHeight);
        layer.contentsScale = [UIScreen mainScreen].scale;
        
        lastBegin += radian;
        [arr addObject:layer];
    }
    
    return arr;
}


#pragma mark - animations

- (void)showWithAnimations:(BOOL)animations
{
    [self setNeedsDisplay];
    [self layoutIfNeeded];
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    
    if (animations){
        [self performAnimation];
    }else{
        [self addLayers];
    }
}

- (void)addLayers
{
    NSArray <CAShapeLayer *>* allSectors = [self allSectors];
    [allSectors enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull obj,
                                             NSUInteger idx,
                                             BOOL * _Nonnull stop)
     {
         [self.layer addSublayer:obj];
     }];
    
    
    NSArray <CAShapeLayer *>* allRadiusLengthens = [self allRadiusLengthens];
    [allRadiusLengthens enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull obj,
                                                     NSUInteger idx,
                                                     BOOL * _Nonnull stop)
     {
         [self.layer addSublayer:obj];
     }];
    
    
    NSArray <CATextLayer *>* alltextLayer = [self alltextLayer];
    [alltextLayer enumerateObjectsUsingBlock:^(CATextLayer * _Nonnull obj,
                                               NSUInteger idx,
                                               BOOL * _Nonnull stop)
     {
         [self.layer addSublayer:obj];
     }];
}

- (void)performAnimation
{
    [self performSectorsAnimation];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self performRadiusLengthensAnimation];
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self performTextAnimation];
    });
}


- (void)performSectorsAnimation
{
    NSArray <CAShapeLayer *>* allSectors = [self allSectors];
    [allSectors enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull obj,
                                             NSUInteger idx,
                                             BOOL * _Nonnull stop)
     {
         [self.layer addSublayer:obj];
         CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
         ani.fromValue = @(0.0f);
         ani.toValue = @(1.0f);
         ani.duration = 0.5f;
         [obj addAnimation:ani forKey:@"allSectors"];
     }];
}


- (void)performRadiusLengthensAnimation
{
    NSArray <CAShapeLayer *>* allRadiusLengthens = [self allRadiusLengthens];
    [allRadiusLengthens enumerateObjectsUsingBlock:^(CAShapeLayer * _Nonnull obj,
                                                     NSUInteger idx,
                                                     BOOL * _Nonnull stop)
     {
         [self.layer addSublayer:obj];
         CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
         ani.fromValue = @(0.0f);
         ani.toValue = @(1.0f);
         ani.duration = 0.5f;
         [obj addAnimation:ani forKey:@"allRadiusLengthens"];
     }];
}

- (void)performTextAnimation
{
    NSArray <CATextLayer *>* alltextLayer = [self alltextLayer];
    [alltextLayer enumerateObjectsUsingBlock:^(CATextLayer * _Nonnull obj,
                                               NSUInteger idx,
                                               BOOL * _Nonnull stop)
     {
         [self.layer addSublayer:obj];
         CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"position.x"];
         ani.fromValue = @(obj.position.x - _textLength);
         ani.toValue = @(obj.position.x);
         ani.duration = 0.5f;
         [obj addAnimation:ani forKey:@"alltextLayer"];
     }];
}


@end
