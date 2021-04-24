//
//  KeyboardEngine.h
//  VehicleKeyboard
//
//  Created by huashengsheng on 2021/4/22.
//

#import <Foundation/Foundation.h>
#import "Marco.h"
#import "KeyboardLayout.h"
NS_ASSUME_NONNULL_BEGIN



@interface KeyboardEngine : NSObject

+ (KeyboardLayout *)generateLayout:(HSKeyboardType)keyboardType inputIndex:(NSInteger)inputIndex presetNumber:(NSString *)presetNumber numberType:(HSKeyboardNumType)numberType isMoreType:(BOOL)isMoreType;

+ (NSString *)subString:(NSString *)str start:(NSInteger)start length:(NSInteger)length;

+ (HSKeyboardNumType)detectNumberTypeOf:(NSString *)presetNumber;
@end

NS_ASSUME_NONNULL_END
