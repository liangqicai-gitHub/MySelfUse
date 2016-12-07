//
//  RootTabbar.m
//  sdfd
//
//  Created by 梁齐才 on 16/12/5.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "RootTabbar.h"
#import "RootBarItem.h"


@interface RootTabbar ()
{
    UIButton *_selectedBtn;
}

@property (strong, nonatomic) IBOutletCollection(RootBarItem) NSArray *btns;

@property (nonatomic,weak) id <RootTabbarDelegate> delegate;

@end


@implementation RootTabbar

+ (RootTabbar *)newInstanceWityDelegate:(id<RootTabbarDelegate>)delegate
{
    RootTabbar *instance = [[NSBundle mainBundle]
                            loadNibNamed:@"RootTabbar"
                            owner:nil options:nil][0];
    
    instance.delegate = delegate;
    
    return instance;
}


+ (CGFloat)expectedHeight
{
    return 49.0f;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    for (RootBarItem *item in _btns) {
        item.selected = NO;
    }
}


- (IBAction)btnsClick:(UIButton *)sender
{
    if (_selectedBtn == sender) return;
    
    _selectedBtn.selected = NO;
    _selectedBtn = sender;
    _selectedBtn.selected = YES;
    
    if ([_delegate respondsToSelector:@selector(rootTabbar:didClickedIndex:)]){
        [_delegate rootTabbar:self didClickedIndex:_selectedBtn.tag];
    }
}


- (void)selectItemAtIndex:(NSInteger)index
{
    id sender = nil;
    for (UIButton *btn in _btns) {
        if (btn.tag == index){
            sender = btn;
            break;
        }
    }
    
    if (sender){
        [sender btnsClick:sender];
    }
}

@end
