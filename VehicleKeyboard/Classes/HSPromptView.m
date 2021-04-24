//
//  HSPromptView.m
//  VehicleKeyboard
//
//  Created by huashengsheng on 2021/4/22.
//

#import "HSPromptView.h"
#import "Marco.h"
@implementation HSPromptView


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 55 74
        self.backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.backgroundImageView.image = [[UIImage alloc] initWithContentsOfFile:[kHSBundle pathForResource:@"pressed@2x" ofType:@"png" inDirectory:@"Image"]];
        [self addSubview:self.backgroundImageView];
        
        self.centerTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 50)];
        self.centerTextLabel.textColor = [UIColor blueColor];
        self.centerTextLabel.text = @"B";
        self.centerTextLabel.font = [UIFont systemFontOfSize:29];
        self.centerTextLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.centerTextLabel];
    }
    return self;
}

@end
