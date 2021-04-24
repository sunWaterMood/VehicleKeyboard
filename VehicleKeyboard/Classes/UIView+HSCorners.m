//
//  UIView+HSCorners.m
//  VehicleKeyboard
//
//  Created by huashengsheng on 2021/4/22.
//

#import "UIView+HSCorners.h"

@implementation UIView (HSCorners)
- (void)addRounded:(UIRectCorner)cornevrs radii:(CGSize)radii{

    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:cornevrs cornerRadii:radii];
    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.path = rounded.CGPath;
    self.layer.mask = shape;
}
@end
