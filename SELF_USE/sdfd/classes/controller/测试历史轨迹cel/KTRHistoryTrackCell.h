//
//  KTRHistoryTrackCell.h
//  HistoryTrack
//
//  Created by dongsh on 16/6/25.
//  Copyright © 2016年 dongsh. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "KTRHistoryTrackModel.h"
//#import "KTRSuggestAddressModel.h"

typedef NS_ENUM(NSInteger, KTRHistoryTrackCellMode) {
    KTRHistoryTrackCellDefault,
    KTRHistoryTrackCellComposit,
    KTRHistoryTrackCellDelete
};

@interface KTRHistoryTrackCell : UITableViewCell

//@property(assign, nonatomic) KTRHistoryTrackCellMode cellMode;
//@property(strong, nonatomic) KTRHistoryTrackModel *model;
//
//@property(strong, nonatomic) NSString *keyword;
//
//- (void)updateTitle:(NSString *)title;
//- (void)updateSelectState:(BOOL)selected;
//- (void)addTopRightButtonAction:(SEL)selector target:(id)target;
//- (void)addDeleteButtonAction:(SEL)selector target:(id)target;



+ (CGFloat)expectedCellHeight;



@end
