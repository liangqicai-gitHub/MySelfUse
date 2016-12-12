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
    RootBarItem *_selectedItem;
    NSArray <RootBarItem *>* _items;
}

@property (strong, nonatomic) IBOutletCollection(RootBarItem) NSArray *items;


@end


@implementation RootTabbar


+ (RootTabbar *)instanceWithDelegate:(id <RootTabbarDelegate>)delegate
{
    return [[RootTabbar alloc] initWithDelegate:delegate];
}

- (instancetype)initWithDelegate:(id <RootTabbarDelegate>)delegate
{
    self = [self init];
    if (self){
        _delegate = delegate;
    }
    return self;
}


- (instancetype)init
{
    self = [super init];
    if (self){
        [self initVars];
        [self initViews];
        [self drawTopLine:0 right:0];
    }
    return self;
}

- (void)initVars
{
    _items = @[
               [RootBarItem instanceWithSelectedImage:[UIImage imageNamed:@"root_tabar_01_ss"]
                normalImage:[UIImage imageNamed:@"root_tabar_01_nn"]
                                                title:@"首页"
                                     normalTitleColor:HexRGB(0x808080)
                                   selectedTitleColor:HexRGB(0xf99200)],
               
               [RootBarItem instanceWithSelectedImage:[UIImage imageNamed:@"root_tabar_02_ss"]
                                          normalImage:[UIImage imageNamed:@"root_tabar_02_nn"]
                                                title:@"发现"
                                     normalTitleColor:HexRGB(0x808080)
                                   selectedTitleColor:HexRGB(0xf99200)],
               
               [RootBarItem instanceWithSelectedImage:[UIImage imageNamed:@"root_tabar_03_ss"]
                                          normalImage:[UIImage imageNamed:@"root_tabar_03_nn"]
                                                title:@"我"
                                     normalTitleColor:HexRGB(0x808080)
                                   selectedTitleColor:HexRGB(0xf99200)],
               ];
    
    
    [_items enumerateObjectsUsingBlock:^(RootBarItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.tag = idx;
        [obj addTarget:self action:@selector(didClickedInrootBarItem:) forControlEvents:UIControlEventTouchUpInside];
    }];
    
}


- (void)initViews
{
    __block UIView *lastView = nil;
    
    [_items enumerateObjectsUsingBlock:^(RootBarItem * _Nonnull obj,
                                        NSUInteger idx,
                                        BOOL * _Nonnull stop) {
        
        UIView *container = [[UIView alloc] init];
        container.backgroundColor = [UIColor clearColor];
        [self addSubview:container];
        [container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lastView ? lastView.mas_right : self.mas_left);
            make.top.bottom.mas_equalTo(0);
            if (idx == _items.count - 1) make.right.mas_equalTo(0);
            if (lastView) make.width.mas_equalTo(lastView.mas_width);
        }];
        lastView = container;
        
        [container addSubview:obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(CGPointZero);
            make.size.mas_equalTo(CGSizeMake(60, 49));
        }];
    }];
}

+ (CGFloat)expectedHeight
{
    return 49.0f;
}


- (void)selectItemAtIndex:(NSInteger)index
{
    RootBarItem *sender = nil;
    for (RootBarItem *item in _items) {
        if (item.tag == index){
            sender = item;
            break;
        }
    }
    
    if (sender){
        [self didClickedInrootBarItem:sender];
    }
}

#pragma mark - RootBarItemDelegate

- (void)didClickedInrootBarItem:(RootBarItem *)item
{
    if (_selectedItem == item) return;
    
    _selectedItem.selected = NO;
    _selectedItem = item;
    _selectedItem.selected = YES;
    
    if ([_delegate respondsToSelector:@selector(rootTabbar:didClickedIndex:)]){
        [_delegate rootTabbar:self didClickedIndex:_selectedItem.tag];
    }
}



@end
