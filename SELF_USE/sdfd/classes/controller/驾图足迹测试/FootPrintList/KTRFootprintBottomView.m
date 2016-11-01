//
//  KTRFootprintBottomView.m
//  kartor3
//
//  Created by 梁齐才 on 16/11/1.
//  Copyright © 2016年 CST. All rights reserved.
//

#import "KTRFootprintBottomView.h"
#import "UILabel+Convenient.h"


@interface KTRFootprintBottomView ()<CAAnimationDelegate>
{
    UILabel *_scanLabel;//浏览数的label
    UILabel *_zanLabel; //点赞数的label
    UILabel *_commentLabel;//评论数的label
    UIButton *_zanButton;//赞的按钮
    NSMutableArray *_animationArray;//动画的数组
    
    CGFloat _smallSpacingBetweenSubViews;//连个相邻空间之间的小距离
    CGFloat _spacingBetweenCommentAndZan;//点赞和评论之间的间距
}


@end


@implementation KTRFootprintBottomView


#pragma mark - 初始化方法
+ (KTRFootprintBottomView *)newInstance
{
    return [self newInstanceWithDelegate:nil];
}

+ (KTRFootprintBottomView *)newInstanceWithDelegate:(id<KTRFootprintBottomViewDelegate>)delegate
{
    KTRFootprintBottomView *instance = [[KTRFootprintBottomView alloc] init];
    instance.delegate = delegate;
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self){
        [self initVars];
        [self initViews];
    }
    return self;
}


- (void)initVars
{
    _animationArray = [NSMutableArray array];
    _smallSpacingBetweenSubViews = 5.0f;
    _spacingBetweenCommentAndZan = 25.0f;
}


- (void)initViews
{
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *scanImage = [[UIImageView alloc] init];
    scanImage.image = [UIImage imageNamed:@"chakan"];
    [self addSubview:scanImage];
    [scanImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
    }];
    
    UILabel *scanPerfixLabel = [UILabel labelWithTextColor:RGB(153, 153, 153)
                                                      font:11];
    scanPerfixLabel.text = @"浏览";
    [self addSubview:scanPerfixLabel];
    [scanPerfixLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scanImage.mas_right).offset(_smallSpacingBetweenSubViews);
        make.centerY.mas_equalTo(0);
    }];
    
    //浏览标签
    _scanLabel = [UILabel labelWithTextColor:RGB(153, 153, 153)
                                        font:11];
    [self addSubview:_scanLabel];
    [_scanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(scanPerfixLabel.mas_right).offset(_smallSpacingBetweenSubViews);
        make.centerY.mas_equalTo(0);
    }];
    
    //评论标签
    _commentLabel = [UILabel labelWithTextColor:RGB(153, 153, 153)
                                           font:11];
    [self addSubview:_commentLabel];
    [_commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
    }];
    
    //评论按钮，这个按钮的图片的大小是 20 * 20 个点
    UIButton *commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commentButton setImage:[UIImage imageNamed:@"pinglun.png"]
                forState:UIControlStateNormal];
    [commentButton setImage:[UIImage imageNamed:@"pinglunp.png"]
                forState:UIControlStateHighlighted];
    [commentButton addTarget:self
                      action:@selector(commentButtonClicked:)
            forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:commentButton];
    [commentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(_commentLabel.mas_left);
    }];
    
    //点赞数的label
    _zanLabel = [UILabel labelWithTextColor:RGB(153, 153, 153)
                                       font:11];
    [self addSubview:_zanLabel];
    [_zanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(commentButton.mas_left).offset(_spacingBetweenCommentAndZan * -1);
        make.centerY.mas_equalTo(0);
    }];
    
    //点赞的按钮，这个按钮是需要动画的,图片是20 * 20 个点，我放大了一些
    _zanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_zanButton];
    [_zanButton addTarget:self
                      action:@selector(zanButtomClicked:)
            forControlEvents:UIControlEventTouchUpInside];
    [_zanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(_zanLabel.mas_left);
    }];
    
}

//点击评论按钮
- (void)commentButtonClicked:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(didClickedCommentButtonInFootprintBottomView:)]){
        [_delegate didClickedCommentButtonInFootprintBottomView:self];
    }
}

- (void)zanButtomClicked:(UIButton *)sender
{
    if ([_delegate respondsToSelector:@selector(didClickedZanButtonInFootprintBottomView:)]){
        [_delegate didClickedZanButtonInFootprintBottomView:self];
    }
}


#pragma mark - setter

- (void)setZanStatus:(FootprintBottomViewZanStatus)zanStatus
{
    _zanStatus = zanStatus;
    //这儿有点怪，之前的图片名称起得不好，总之下面的逻辑是对的
    NSString *imageName = @"quxiaoZan";
    if (zanStatus == FootprintBottomViewZanStatus_NotYet){
        imageName = @"dianZan";
    }
    UIImage *zanButtonImage = [UIImage imageNamed:imageName];
    [_zanButton setImage:zanButtonImage forState:UIControlStateNormal];
    
}

- (void)setScanNumber:(NSInteger)scanNumber
{
    _scanNumber = scanNumber;
    if (_scanNumber < 0) _scanNumber = 0;
    NSString *scanNumberStr = Str_F(@"%zd",_scanNumber);
    _scanLabel.text = scanNumberStr;
}

- (void)setZanNumber:(NSInteger)zanNumber
{
    _zanNumber = zanNumber;
    if (_zanNumber < 0) _zanNumber = 0;
    NSString *zanNumberStr = Str_F(@"%zd",_zanNumber);
    _zanLabel.text = zanNumberStr;
}

- (void)setCommentNumber:(NSInteger)commentNumber
{
    _commentNumber = commentNumber;
    if (_commentNumber < 0) _commentNumber = 0;
    NSString *commentNumberStr = Str_F(@"%zd",_commentNumber);
    _commentLabel.text = commentNumberStr;
}

- (void)setZanStatus:(FootprintBottomViewZanStatus)zanStatus
           animation:(BOOL)Animation
{
    if (_zanStatus == zanStatus) return;
    
    [self setZanStatus:zanStatus];
    
    switch (zanStatus) {
        case FootprintBottomViewZanStatus_Already://变成已经点赞
            [self dianZanAnimation];
            break;
        case FootprintBottomViewZanStatus_NotYet:
            [self cancelZanAnimation];
            break;
        default:
            break;
    }
}

#pragma mark - 动画

- (void)dianZanAnimation
{
    [_animationArray addObject:[self moveleft]];
    // 放大
    [_animationArray addObject:[self scale]];
    [_animationArray addObject:[self moveUp]];
    // 倾斜角度
    [_animationArray addObject:[self qingxie]];
    [_zanButton.layer addAnimation:[self move] forKey:nil];
}

- (void)cancelZanAnimation
{
    CABasicAnimation *posAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    posAnim.duration = 0.35;
    posAnim.fromValue = @(2.0);
    posAnim.toValue = @(1);
    posAnim.removedOnCompletion = YES;
    [_zanButton.layer addAnimation:posAnim forKey:nil];
}

// 移动
-(CAAnimation *) move {
    CABasicAnimation *anim=[CABasicAnimation animation];
    //1.1告诉系统要执行什么样的动画
    anim.keyPath=@"position";
    //设置通过动画，将layer从哪儿移动到哪儿
    anim.fromValue=[NSValue valueWithCGPoint:CGPointMake(_zanButton.center.x, _zanButton.center.y)];
    anim.toValue=[NSValue valueWithCGPoint:CGPointMake(_zanButton.center.x, _zanButton.center.y - 30)];
    //1.2设置动画执行完毕之后不删除动画
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.autoreverses = NO;
    anim.duration = 0.2;
    anim.delegate = self;
    return  anim;
}

// 左移动
-(CAAnimation *) moveleft {
    CABasicAnimation *anim=[CABasicAnimation animation];
    //1.1告诉系统要执行什么样的动画
    anim.keyPath=@"position";
    //设置通过动画，将layer从哪儿移动到哪儿
    anim.fromValue=[NSValue valueWithCGPoint:CGPointMake(_zanButton.center.x, _zanButton.center.y - 30)];
    anim.toValue=[NSValue valueWithCGPoint:CGPointMake(_zanButton.center.x - 3, _zanButton.center.y - 30)];
    //1.2设置动画执行完毕之后不删除动画
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.autoreverses = NO;
    anim.duration = 0.01;
    anim.delegate = self;
    return  anim;
}

// 上移动
-(CAAnimation *) moveUp {
    CABasicAnimation *anim=[CABasicAnimation animation];
    //1.1告诉系统要执行什么样的动画
    anim.keyPath=@"position";
    //设置通过动画，将layer从哪儿移动到哪儿
    anim.fromValue=[NSValue valueWithCGPoint:CGPointMake(_zanButton.center.x - 2, _zanButton.center.y - 30)];
    anim.toValue=[NSValue valueWithCGPoint:CGPointMake(_zanButton.center.x + 5, _zanButton.center.y - 35)];
    //1.2设置动画执行完毕之后不删除动画
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.autoreverses = NO;
    anim.duration = 0.05;
    anim.delegate = self;
    return  anim;
}

// 放大
-(CAAnimation *) scale {
    //关键帧动画（位置）
    CABasicAnimation *posAnim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    posAnim.duration = 0.1;
    posAnim.fromValue = @(1.0);
    posAnim.toValue = @(2);
    posAnim.removedOnCompletion = NO;
    posAnim.fillMode = kCAFillModeForwards;
    posAnim.delegate = self;
    posAnim.autoreverses = NO;
    //动画组
    return  posAnim;
}

// 倾斜
-(CAAnimation *) qingxie {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    anim.toValue = @(M_PI/6);
    anim.repeatCount = 1;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.delegate = self;
    anim.autoreverses = NO;
    anim.duration = 0.1;
    return anim;
}


- (void) animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (_animationArray.count == 0) {
        [NSThread sleepForTimeInterval:0.2];
        [_zanButton.layer removeAllAnimations];
        return;
    }
    if(_animationArray.count == 3) {
        [NSThread sleepForTimeInterval:0.1];
    }
    [_zanButton.layer addAnimation:_animationArray[0] forKey:nil];
    [_animationArray removeObjectAtIndex:0];
}


#pragma mark - 类属性
+ (CGFloat)exceptedHeight
{
    return 50.0f;
}

@end
