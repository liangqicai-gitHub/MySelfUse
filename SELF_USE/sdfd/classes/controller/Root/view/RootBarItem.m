//
//  RootBarItem.m
//  sdfd
//
//  Created by 梁齐才 on 16/12/7.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "RootBarItem.h"


@interface RootBarItem ()

@property (weak, nonatomic) IBOutlet UIImageView *limageView;
@property (weak, nonatomic) IBOutlet UILabel *llabel;


@end


@implementation RootBarItem


- (void)setTitle:(NSString *)title
{
    _llabel.text = title;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
        
    UIColor *textColor = _normalTitleColor;
    UIImage *image = _normalImage;
    if (self.selected){
        textColor = _selectedTitleColor;
        image = _selectedImage;
    }
    [_llabel setTextColor:[UIColor redColor]];
    _limageView.image = image;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
   [[NSBundle mainBundle]
                    loadNibNamed:@"RootBarItem"
                    owner:self options:nil];
    
    [self addSubview:_contentView];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

@end
