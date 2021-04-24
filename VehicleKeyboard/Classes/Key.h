//
//  Key.h
//  VehicleKeyboard
//
//  Created by huashengsheng on 2021/4/22.
//

#import <Foundation/Foundation.h>



NS_ASSUME_NONNULL_BEGIN

@interface Key : NSObject

@property (nonatomic, strong) NSString  *text;

@property (nonatomic, assign) NSInteger  keyCode;

@property (nonatomic, assign) BOOL  enabled;

@property (nonatomic, assign) BOOL  isFunKey;

@end

NS_ASSUME_NONNULL_END
