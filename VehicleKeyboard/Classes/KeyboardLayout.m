//
//  KeyboardLayout.m
//  VehicleKeyboard
//
//  Created by huashengsheng on 2021/4/22.
//

#import "KeyboardLayout.h"

@implementation KeyboardLayout


- (NSArray<NSArray<Key *>  *> *)rowArray{
    return @[self.row0 ?: @[],self.row1 ?: @[],self.row2 ?: @[],self.row3 ?: @[]];
}

@end
