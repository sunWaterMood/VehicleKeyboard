//
//  KeyboardLayout.h
//  VehicleKeyboard
//
//  Created by huashengsheng on 2021/4/22.
//

#import <Foundation/Foundation.h>

#import "Marco.h"

#import "Key.h"

NS_ASSUME_NONNULL_BEGIN

@interface KeyboardLayout : NSObject

@property (nonatomic, strong, nullable) NSArray<Key *>  *row0;

@property (nonatomic, strong, nullable) NSArray<Key *>  *row1;

@property (nonatomic, strong, nullable) NSArray<Key *>  *row2;

@property (nonatomic, strong, nullable) NSArray<Key *>  *row3;

@property (nonatomic, strong, nullable) NSArray<Key *>  *keys;


//index 当前键盘所处的键盘位置；
@property (nonatomic, assign) NSInteger  index;

//presetNumber 当前预设的车牌号码；
@property (nonatomic, strong, nullable) NSString *  presetNumber;

//keyboardType 当前键盘所处的键盘类型；
@property (nonatomic, assign) HSKeyboardType  keyboardType;
//numberType 当前预设的车牌号码类型（废弃参数）；
@property (nonatomic, assign) HSKeyboardNumType  numberType;
//presetNumberType 同numberType；
@property (nonatomic, assign) HSKeyboardNumType  presetNumberType;
//detectedNumberType 检测当前输入车牌号码的号码类型；
@property (nonatomic, assign) HSKeyboardNumType  detectedNumberType;
//numberLength 当前预设的车牌号码长度；
@property (nonatomic, assign) NSInteger  numberLength;
//numberLimitLength 当前车牌号码的最大长度；
@property (nonatomic, assign) NSInteger  numberLimitLength;

- (NSArray<NSArray<Key *>  *> *)rowArray;
@end

NS_ASSUME_NONNULL_END
