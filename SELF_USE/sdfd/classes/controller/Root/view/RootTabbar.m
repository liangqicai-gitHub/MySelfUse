//
//  RootTabbar.m
//  sdfd
//
//  Created by 梁齐才 on 16/12/5.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "RootTabbar.h"
#import "RootBarItem.h"


@interface RootTabbar ()<RootBarItemDelegate>
{
    RootBarItem *_selectedItem;
}

@property (strong, nonatomic) IBOutletCollection(RootBarItem) NSArray *items;


@end


@implementation RootTabbar


- (instancetype)init
{
    self = [super init];
    if (self){
        [self drawTopLine:0 right:0];
    }
    return self;
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
