//
//  BaseViewController.m
//  sdfd
//
//  Created by 梁齐才 on 16/5/25.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
{
    UITapGestureRecognizer *_tapToRetrunKeyboard;
}

@end

@implementation BaseViewController

- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self){
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self){
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}


#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setDefaultNavigationBack:YES];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
        
    //控制navigation
    [self.navigationController
     setNavigationBarHidden:[self navigationBarHidden]
     animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //控制键盘
    [self addOrRemoveKeyBoardObserver:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //控制键盘
    if ([self needObserveKeyBorad]){
        [self addOrRemoveKeyBoardObserver:YES];
    }
}

#pragma mark - statusbar

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

#pragma mark - navigation

- (BOOL)navigationBarHidden
{
    return NO;
}

- (BOOL)supportSlideBack
{
    return YES;
}

- (void)setDefaultNavigationBack:(BOOL)useLastControllerTitle
{
    UINavigationController *navi = self.navigationController;
    if (!navi) return;
    
    NSArray *controllers = navi.viewControllers;
    if (![NSArray isArray:controllers equalOrLongerThan:2]) return;//至少要是第二个
    
    NSString *title = @"返回";
    if (useLastControllerTitle){
        UIViewController *last = controllers[controllers.count - 2];
        NSString *lastTitle = last.title;
        if (![NSString isEmptyString:lastTitle]){
            title = lastTitle;
        }
    }
    
    UIImage *backImage = [UIImage imageNamed:@"cm-navi-back-n"];
    UIFont *titleFont = [UIFont systemFontOfSize:16];
    UIButton *backBtn = [UIButton newInstanceWithTitle:title
                                                  font:titleFont
                                      normalTitleColor:[UIColor blackColor]
                                   horizontalAlignment:UIControlContentHorizontalAlignmentLeft
                                           normalImage:backImage];
    
    CGFloat titleWidth = [title sizeForFont:titleFont
                                       size:(CGSize){CGFLOAT_MAX,30}
                                       mode:backBtn.titleLabel.lineBreakMode].width;
    CGFloat backBtnWidth = titleWidth + backImage.size.width;
    
    [backBtn setFrame:(CGRect){0,0,backBtnWidth + 7,44}];
    [backBtn setTitleEdgeInsets:(UIEdgeInsets){0,5,0,0}];
    [backBtn addTarget:self
                action:@selector(backBtnClick:)
      forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *navigationSpacer = [[UIBarButtonItem alloc] init];
    navigationSpacer.width = -5;
    
    NSArray *leftItems = @[navigationSpacer,
                           [[UIBarButtonItem alloc] initWithCustomView:backBtn]
                           ];
    
    self.navigationItem.leftBarButtonItems = leftItems;
}

- (void)backBtnClick:(UIButton *)sender
{
    [self popTo:nil animation:YES];
}


- (void)popTo:(BaseViewController *)vc
    animation:(BOOL)animation
{
    [self.view endEditing:YES];
    
    UINavigationController *navi = self.navigationController;
    if (![navi isKindOfClass:[UINavigationController class]]) return;
    
    if (vc){
        [navi popToViewController:vc animated:animation];
    }else{
        [navi popViewControllerAnimated:animation];
    }
}

- (void)popToRootAnimation:(BOOL)animation
{
    [self.view endEditing:YES];
    
    UINavigationController *navi = self.navigationController;
    if (![navi isKindOfClass:[UINavigationController class]]) return;
    
    [navi popToRootViewControllerAnimated:animation];
}

- (void)popTo:(BaseViewController *)povc
     thenPush:(BaseViewController *)pushvc
pushAnimation:(BOOL)animation
{
    UINavigationController *navi = self.navigationController;
    if (![navi isKindOfClass:[UINavigationController class]]) return;
    
    if (povc){
        [navi popToViewController:povc animated:NO];
    }else{
        [navi popViewControllerAnimated:NO];
    }
    
    [navi pushViewController:pushvc animated:animation];
}


- (void)pushTo:(BaseViewController *)vc
     animation:(BOOL)animation
{
    [self.view endEditing:YES];
    
    UINavigationController *navi = self.navigationController;
    if (![navi isKindOfClass:[UINavigationController class]]) return;
    [navi pushViewController:vc animated:animation];
}

#pragma mark - keyboard

- (BOOL)needObserveKeyBorad
{
    return NO;
}

- (void)addGlobalTapToReturnKeyborad
{
    if (_tapToRetrunKeyboard) {
        UITapGestureRecognizer *tapGestureRecognizer =
        [[UITapGestureRecognizer alloc]
         initWithTarget:self
         action:@selector(keyboardHide:)];
        tapGestureRecognizer.cancelsTouchesInView = NO;
        _tapToRetrunKeyboard = tapGestureRecognizer;
    }
    
    [self.view addGestureRecognizer:_tapToRetrunKeyboard];
}

- (void)keyboardHide:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}

- (void)addOrRemoveKeyBoardObserver:(BOOL)add
{
    if (_tapToRetrunKeyboard){
        [self.view removeGestureRecognizer:_tapToRetrunKeyboard];
    }
    
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:UIKeyboardWillShowNotification
     object:nil];
    
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:UIKeyboardWillHideNotification
     object:nil];
    
    if (!add) return;
    
    [self addGlobalTapToReturnKeyborad];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(keyboardWillShow:)
     name:UIKeyboardWillShowNotification
     object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(keyboardWillHide:)
     name:UIKeyboardWillHideNotification
     object:nil];
}

- (void)keyboardWillShow:(NSNotification *)sender
{
    NSDictionary *info = [sender userInfo];
    CGSize kbSize = [info [UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSTimeInterval time = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [self handleKeyBoardWillShow:time
                  keyBoardHeight:kbSize.height];
}

- (void)keyboardWillHide:(NSNotification *)sender
{
    NSDictionary *info = [sender userInfo];
    CGSize kbSize = [info [UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    NSTimeInterval time = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [self handleKeyBoardWillHide:time
                  keyBoardHeight:kbSize.height];
}

- (void)handleKeyBoardWillShow:(NSTimeInterval)anmationTime
                keyBoardHeight:(CGFloat)height
{
    
}

- (void)handleKeyBoardWillHide:(NSTimeInterval)anmationTime
                keyBoardHeight:(CGFloat)height
{
    
}


- (void)dealloc
{
    LQCDLog(@"_____%s  ",__FUNCTION__);
}

@end
