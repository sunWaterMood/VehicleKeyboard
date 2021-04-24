//
//  HSKeyBoardCollectionViewCell.h
//  VehicleKeyboard
//
//  Created by huashengsheng on 2021/4/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HSKeyBoardCollectionViewCell : UICollectionViewCell


@property (nonatomic, strong) UIImageView  *iconImageView;


@property (nonatomic, strong) UIImageView  *shadowImageVIew;

@property (nonatomic, strong) UILabel  *centerLabel;

@property (nonatomic, strong) UIView  *submitBackgroundView;

@property (nonatomic, assign) BOOL  isEnabledStatus;

@property (nonatomic, strong) UIColor  *mainColor;

- (void)resetUI:(CGSize)size;

- (void)setDeleteButton:(CGFloat)left size:(CGSize)size;

- (void)setMoreButton:(CGFloat)left size:(CGSize)size;

- (void)setSubmitBUtton:(BOOL)isEnabled size:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
