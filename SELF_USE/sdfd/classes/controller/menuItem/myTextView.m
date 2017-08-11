//
//  myTextView.m
//  sdfd
//
//  Created by 梁齐才 on 17/8/7.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "myTextView.h"

@implementation myTextView



-(void)attachMenu
{
    UIMenuItem *copy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(fuZhi:)];
    UIMenuItem *bright = [[UIMenuItem alloc] initWithTitle:@"高亮" action:@selector(bright:)];
    UIMenuItem *note = [[UIMenuItem alloc] initWithTitle:@"笔记" action:@selector(note:)];
    
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setMenuItems:[NSArray arrayWithObjects:copy, bright, note, nil]];
    [menu setTargetRect:self.frame inView:self.superview];
    [menu setMenuVisible:YES animated:YES];
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(note:)||action == @selector(fuZhi:)||action == @selector(bright:))
    {
        return YES;
    }
    return NO;
}


@end
