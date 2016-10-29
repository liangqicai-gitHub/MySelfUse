//
//  KTRHistoryTrackCell.m
//  HistoryTrack
//
//  Created by dongsh on 16/6/25.
//  Copyright © 2016年 dongsh. All rights reserved.
//

#import "KTRHistoryTrackCell.h"
#import <CoreImage/CoreImage.h>

@interface KTRHistoryTrackCell()

@property(weak, nonatomic) IBOutlet UIButton *topRightButton;
@property(weak, nonatomic) IBOutlet UIButton *deleteButton;

@property(weak, nonatomic) IBOutlet UIImageView *trackImageView;
@property(weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
@property(weak, nonatomic) IBOutlet UILabel *titleLabel;

@property(weak, nonatomic) IBOutlet UILabel *startPointLabel;
@property(weak, nonatomic) IBOutlet UILabel *startTimeLabel;

@property(weak, nonatomic) IBOutlet UILabel *endPointLabel;
@property(weak, nonatomic) IBOutlet UILabel *endTimeLabel;

@property(weak, nonatomic) IBOutlet UILabel *mileLabel;
@property(weak, nonatomic) IBOutlet UILabel *timeLabel;

- (void)formatAddressString:(UILabel *)label address:(NSString *)address time:(time_t)time;
- (void)_kvo_modelStartAddress:(NSDictionary *)dic;
- (void)_kvo_modelEndAddress:(NSDictionary *)dic;
- (void)_kvo_modelTrackImageUrl:(NSDictionary *)dic;

- (void)downLoadTraceImage;
- (void)highLightAddress:(NSString *)keyword label:(UILabel *)label address:(NSString *)address;


@end

@implementation KTRHistoryTrackCell

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//    
//    _trackImageView.superview.layer.cornerRadius = 5.0;
//    _trackImageView.superview.layer.borderColor = RGB(230, 230, 230).CGColor;
//    _trackImageView.superview.layer.borderWidth = 0.5;
//    _trackImageView.superview.layer.masksToBounds = YES;
//    
//    [_indicatorView stopAnimating];
//    _indicatorView.hidden = YES;
//}
//
//- (void)dealloc {
//#if DEBUG
//    NSLog(@"KTRHistoryTrackCell dealloc");
//#endif
//}
//
//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}
//
//// 为cell的右上角按钮添加事件
//- (void)addTopRightButtonAction:(SEL)selector target:(id)target {
//    if (selector && target) {
//        [_topRightButton addTarget: target action: selector forControlEvents: UIControlEventTouchUpInside];
//    }
//}
//
//// 为删除按钮添加事件
//- (void)addDeleteButtonAction:(SEL)selector target:(id)target {
//    if (selector && target) {
//        [_deleteButton addTarget: target action: selector forControlEvents: UIControlEventTouchUpInside];
//    }
//}
//
//// 设置cell的类型
//- (void)setCellMode:(KTRHistoryTrackCellMode)cellMode {
//    _cellMode = cellMode;
//    switch (_cellMode) {
//        case KTRHistoryTrackCellComposit: {
//            _topRightButton.hidden = NO;
//            _deleteButton.hidden = YES;
//            [_topRightButton setImage: [UIImage imageNamed: @"ht_noselected.png"] forState: UIControlStateNormal];
//            [_topRightButton setImage: [UIImage imageNamed: @"ht_selected.png"] forState: UIControlStateSelected];
//            break;
//        }
//        case KTRHistoryTrackCellDelete: {
//            _topRightButton.hidden = YES;
//            _deleteButton.hidden = NO;
//            break;
//        }
//        default: {
//            _topRightButton.hidden = NO;
//            _deleteButton.hidden = YES;
//            [_topRightButton setImage: [UIImage imageNamed: @"ht_edit_name.png"] forState: UIControlStateNormal];
//            [_topRightButton setImage: [UIImage imageNamed: @"ht_edit_name_p.png"] forState: UIControlStateHighlighted];
//            break;
//        }
//    }
//}
//
//// 设置cell的数据
//- (void)setModel:(KTRHistoryTrackModel *)model {
//    
//    [self.KVOController unobserveAll];
//    _model = model;
//    [self.KVOController observe: _model keyPath: @"startAddress" options: NSKeyValueObservingOptionNew action: @selector(_kvo_modelStartAddress:)];
//    [self.KVOController observe: _model keyPath: @"endAddress" options: NSKeyValueObservingOptionNew action: @selector(_kvo_modelEndAddress:)];
//    [self.KVOController observe: _model keyPath: @"trackImageUrl" options: NSKeyValueObservingOptionNew action: @selector(_kvo_modelTrackImageUrl:)];
//
//    if (model.trackName && model.trackName.length > 0) {
//        _titleLabel.text = _F(@"%@", model.trackName);
//        _titleLabel.superview.hidden = NO;
//    } else {
//        _titleLabel.superview.hidden = YES;
//    }
//    
//    if (_model.startAddress)  {
//        [self formatAddressString: _startPointLabel address: _model.startAddress time: _model.startTime];
//    }
//    
//    if (_model.endAddress) {
//        [self formatAddressString: _endPointLabel address: _model.endAddress time: _model.endTime];
//    }
//    
//    _mileLabel.text = _F(@"%@km", model.mileInfo);
//    _timeLabel.text = model.durationWithList;
//    
//    [self downLoadTraceImage];
//}
//
//// model轨迹缩略图变更回调
//- (void)_kvo_modelTrackImageUrl:(NSDictionary *)dic {
//    NSString *imageUrl = dic[@"new"];
//    if ([imageUrl isKindOfClass: [NSString class]]) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if ([imageUrl isEqualToString: _model.trackImageUrl]) {
//                NSURL *trackImageUrl = [NSURL URLWithString: _model.trackImageUrl];
//                __weak typeof(self) weakSelf = self;
//                UIImage *placeHolder = [UIImage imageNamed: @"defaultTrackImage.png"];
//                [_trackImageView setImageWithURL: trackImageUrl placeholder: nil options:YYWebImageOptionProgressiveBlur progress: ^(NSInteger receivedSize, NSInteger expectedSize) {
//                     typeof(weakSelf) strongSelf = weakSelf;
//                     if (strongSelf) {
//                         strongSelf.indicatorView.hidden = NO;
//                         [strongSelf.indicatorView startAnimating];
//                     }
//                 } transform: nil completion: ^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
//                     typeof(weakSelf) strongSelf = weakSelf;
//                     if (strongSelf ) {
//                         strongSelf.indicatorView.hidden = YES;
//                         [strongSelf.indicatorView stopAnimating];
//                         if (error) {
//                             strongSelf.trackImageView.image = placeHolder;
//                         }
//                     }
//                 }];
//            }
//        });
//    }
//}
//
//
//- (void)downLoadTraceImage {
//    NSString *imageUrl = _model.trackImageUrl;
//    NSURL *trackImageUrl = [NSURL URLWithString: imageUrl];
//    if (trackImageUrl) {
//        UIImage *placeHolder = [UIImage imageNamed: @"defaultTrackImage.png"];
//        _indicatorView.hidden = YES;
//        [_trackImageView setImageWithURL: trackImageUrl placeholder: placeHolder];
//    } else {
//        _indicatorView.hidden = NO;
//        [_indicatorView startAnimating];
//        [_model loadTraceModels];
//    }
//}
//
//// model地址变更回调
//- (void)_kvo_modelStartAddress:(NSDictionary *)dic {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if (_model.startAddress) {
//            [self formatAddressString: _startPointLabel address: _model.startAddress time: _model.startTime];
//        }
//    });
//}
//
//// model地址变更回调
//- (void)_kvo_modelEndAddress:(NSDictionary *)dic {
//    dispatch_async(dispatch_get_main_queue(), ^{
//        if (_model.endAddress) {
//            [self formatAddressString: _endPointLabel address: _model.endAddress time: _model.endTime];
//        }
//    });
//}
//
//- (void)formatAddressString:(UILabel *)label address:(NSString *)address time:(time_t)time {
//    if (_keyword) {
//        [self highLightAddress: _keyword label: label address: address];
//    } else {
//        label.text = address;
//    }
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970: time];
//    if ([label isEqual: _startPointLabel]) {
//        _startTimeLabel.text = _F(@"(%@)",  [date stringWithFormat: @"HH:mm"]);
//    } else {
//        _endTimeLabel.text = _F(@"(%@)",  [date stringWithFormat: @"HH:mm"]);
//    }
//}
//
//// 更新cell的标题
//- (void)updateTitle:(NSString *)title {
//    if (_model) {
//        _model.trackName = title;
//        if (title.length > 0) {
//            _titleLabel.text = _F(@"%@", _model.trackName);
//            _titleLabel.superview.hidden = NO;
//        } else {
//            _titleLabel.superview.hidden = YES;
//        }
//    }
//}
//
//// 更新右上角按钮的选择状态
//- (void)updateSelectState:(BOOL)selected {
//    _topRightButton.selected = selected;
//}
//
//// 通过关键字高亮显示地址文本
//- (void)highLightAddress:(NSString *)keyword label:(UILabel *)label address:(NSString *)address {
//    if ([keyword isKindOfClass: [NSString class]] && [keyword stringByTrim].length > 0 && address) {
//        NSMutableAttributedString* attrstring = [[NSMutableAttributedString alloc] initWithString:  address attributes: nil];
//        [KTRSuggestAddressModel highLightKeywork: attrstring withKeyword: keyword ? keyword : @""];
//        label.attributedText = attrstring;
//    }
//}


+ (CGFloat)expectedCellHeight
{
    id stroedHeight = [self fixedCellHeight];
    if ([stroedHeight isKindOfClass:[NSNumber class]]){
//        NSLog(@"get a stored cell heght %@",stroedHeight);
        return [stroedHeight floatValue];
    }
    
    CGFloat orightTop = 15.0f;
    CGFloat imageWidth = [UIScreen mainScreen].bounds.size.width - 26 - 10;
    CGFloat imageHeight = imageWidth * 240 / 690;
    CGFloat buttom = 89.5f;
    NSInteger rs = (NSInteger)(orightTop + imageHeight + buttom);
    [self setFixedCellHeight:@(rs)];
    return rs;
}

static char cellFixedHeightKey;
+ (NSNumber *)fixedCellHeight
{
    return objc_getAssociatedObject(self, &cellFixedHeightKey);
}

+ (void)setFixedCellHeight:(NSNumber *)fixedCellHeifht
{
    if (![fixedCellHeifht isKindOfClass:[NSNumber class]]) return;
    objc_setAssociatedObject(self, &cellFixedHeightKey, fixedCellHeifht, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end


