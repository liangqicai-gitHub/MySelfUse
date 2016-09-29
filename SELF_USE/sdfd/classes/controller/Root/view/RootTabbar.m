//
//  RootTabbar.m
//  sdfd
//
//  Created by 梁齐才 on 16/5/30.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "RootTabbar.h"
#import "RootTabbarItem.h"


@interface RootTabbar ()<RootTabbarItemDelegate>
{
    NSMutableArray *_items;
    RootTabbarItem *_selectedItem;
    
    UIView *_contentView;
}

@end


@implementation RootTabbar


+ (RootTabbar *)rootTabbarWithFrame:(CGRect)frame
{
    RootTabbar *bar = [[RootTabbar alloc] initWithFrame:frame];
    bar.translatesAutoresizingMaskIntoConstraints = YES;
 
    return bar;
}


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]){
        _items = [NSMutableArray array];
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
        _contentView = view;
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = HexRGB(0x666666);
        [_contentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.right.mas_equalTo(_contentView);
            make.height.mas_equalTo(0.5f);
        }];
    }
    
    
    return self;
}



- (void)addItem:(RootTabbarItem *)item;
{
    [_contentView addSubview:item];

    [_items addObject:item];
    
    UIView *lastView = _contentView;
    for (int i = 0; i < _items.count; i++) {
        UIView *item = [_items objectAtIndex:i];
        [item mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            if (i == 0){
                make.left.mas_equalTo(lastView.mas_left);
            }else{
                make.left.mas_equalTo(lastView.mas_right);
                make.width.mas_equalTo(lastView.mas_width);
            }
            
            make.top.and.bottom.mas_equalTo(_contentView);
            
            if (i == _items.count - 1){
                make.right.mas_equalTo(_contentView.mas_right);
            }
        }];
        
        lastView = item;
    }
    
    item.delegate = self;
    
    //设置默认的
    [self setSelectedIndex:0];
}


- (void)setSelectedIndex:(NSInteger)index
{
    if ([NSArray isEmpty:_items]) return;
    if (index < 0 || index >= _items.count) return;
    RootTabbarItem *select = _items[index];
    
    if (_selectedItem == select) return;
    
    select.selected = YES;
    _selectedItem.selected = NO;
    _selectedItem = select;
    
}



#pragma mark - RootTabbarItemDelegate

- (void)didSelected:(RootTabbarItem *)item
{
    if (_selectedItem == item) return;
    
    item.selected = YES;
    _selectedItem.selected = NO;
    _selectedItem = item;
    
    
    if (!_delegate) return;
    if (![_delegate respondsToSelector:@selector(rootTabbarView:didSelectIndex:)]) return;
    
    int index = -1;
    for (int i = 0; i < _items.count; i++) {
        id small = _items[i];
        if (small == _selectedItem){
            index = i;
            break;
        }
    }
    if (index == -1) return;
    
    [_delegate rootTabbarView:self didSelectIndex:index];
}

@end
