//
//  HSKeyBoardCollectionViewCell.m
//  VehicleKeyboard
//
//  Created by huashengsheng on 2021/4/23.
//

#import "HSKeyBoardCollectionViewCell.h"
#import "Marco.h"

@implementation HSKeyBoardCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
                
        self.isEnabledStatus = YES;
        
        self.mainColor = [UIColor colorWithRed:65/256.0 green:138/256.0 blue:249/256.0 alpha:1];
        
        self.shadowImageVIew = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.contentView addSubview:self.shadowImageVIew];
        
        self.submitBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(2, 0,  frame.size.width - 4, frame.size.height - 4)];
        self.submitBackgroundView.backgroundColor = [UIColor blueColor];
        self.submitBackgroundView.layer.masksToBounds = YES;
        self.submitBackgroundView.layer.cornerRadius = 3;
        [self.contentView addSubview:self.submitBackgroundView];
        
        self.centerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 12, frame.size.width, 21)];
        self.centerLabel.text = @"B";
        self.centerLabel.textAlignment = NSTextAlignmentCenter;
        self.centerLabel.font = [UIFont systemFontOfSize:21];
        [self.contentView addSubview:self.centerLabel];
        
        self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 24, 17)];
        self.iconImageView.center = CGPointMake(self.shadowImageVIew.center.x, self.shadowImageVIew.center.y);
        [self.contentView addSubview:self.iconImageView];
        UIImage *normalImage = [[[UIImage alloc]initWithContentsOfFile:[kHSBundle pathForResource:@"btn_normal@2x" ofType:@"png" inDirectory:@"Image"]] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        UIImage *pressedImage = [[[UIImage alloc]initWithContentsOfFile:[kHSBundle pathForResource:@"btn_pressed@2x" ofType:@"png" inDirectory:@"Image"]] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
        self.shadowImageVIew.image = normalImage;
        self.shadowImageVIew.highlightedImage = pressedImage;
        self.contentView.backgroundColor = [UIColor clearColor];

    }
    return self;
}


- (void)setIsEnabledStatus:(BOOL)isEnabledStatus{
    _isEnabledStatus = isEnabledStatus;
    if (isEnabledStatus) {
        self.centerLabel.textColor = [UIColor blackColor];
    }else{
        self.centerLabel.textColor =  [UIColor colorWithRed:204/256.0 green:204/256.0 blue:204/256.0 alpha:1];
    }
}

- (void)resetUI:(CGSize)size{
    self.centerLabel.frame = CGRectMake(0, 12, size.width, 21);
    self.shadowImageVIew.frame = CGRectMake(0, 0, size.width, size.height);
    self.iconImageView.hidden = YES;
    self.centerLabel.textColor = [UIColor blackColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.submitBackgroundView.hidden = YES;
    self.iconImageView.center = CGPointMake(self.shadowImageVIew.center.x, self.shadowImageVIew.center.y);
}

- (void)setDeleteButton:(CGFloat)left size:(CGSize)size{
    self.shadowImageVIew.frame = CGRectMake(left, 0, size.width - left, size.height);
    self.centerLabel.text = @"";
    self.iconImageView.hidden = NO;
    self.centerLabel.frame = CGRectMake(left, 12, size.width - left, 21);
    UIImage *normalImage = [[[UIImage alloc]initWithContentsOfFile:[kHSBundle pathForResource:@"delete@2x" ofType:@"png" inDirectory:@"Image"]] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    self.iconImageView.image = normalImage;
    self.iconImageView.center = CGPointMake(self.shadowImageVIew.center.x, self.shadowImageVIew.center.y);
}

- (void)setMoreButton:(CGFloat)left size:(CGSize)size{
    self.centerLabel.frame = CGRectMake(left, 12, size.width - left, 21);
    self.shadowImageVIew.frame = CGRectMake(left, 0, size.width - left, size.height);
    self.iconImageView.center = CGPointMake(self.shadowImageVIew.center.x, self.shadowImageVIew.center.y);
}
- (void)setSubmitBUtton:(BOOL)isEnabled size:(CGSize)size{
    self.submitBackgroundView.hidden = NO;
    self.submitBackgroundView.backgroundColor = isEnabled ? self.mainColor : [UIColor colorWithRed:153/256.0 green:153/256.0 blue:153/256.0 alpha:1];
    self.centerLabel.textColor = [UIColor whiteColor];
    self.submitBackgroundView.frame = CGRectMake(2, 0,  size.width - 4, size.height - 4);
}
@end
