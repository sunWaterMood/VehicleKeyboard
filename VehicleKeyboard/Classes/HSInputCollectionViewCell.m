//
//  HSInputCollectionViewCell.m
//  VehicleKeyboard
//
//  Created by huashengsheng on 2021/4/23.
//

#import "HSInputCollectionViewCell.h"

@implementation HSInputCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.charLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 25)];
        self.charLab.font = [UIFont systemFontOfSize:17];
        self.charLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.charLab];
        
        
        
        
    }
    return self;
}

@end
