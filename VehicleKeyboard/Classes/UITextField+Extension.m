//
//  UITextField+Extension.m
//  VehicleKeyboard
//
//  Created by huashengsheng on 2021/4/23.
//

#import "UITextField+Extension.h"


const void * vehicleKeyboardText = "VehicleKeyboardText";
const void * vehicleKeyboardShow = "vehicleKeyboardShow";
const void * vehicleKeyboardHidden = "vehicleKeyboardHidden";


@implementation UITextField (Extension)


- (void)changeToPlatePWKeyBoardInpurView{
    HSKeyBoardView *keyboardView = [[HSKeyBoardView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.inputView = keyboardView;
    keyboardView.delegate = self;
    
    
}

- (void)changePlateInputType:(BOOL)isNewEnergy{
    HSKeyBoardView *keyboardView = (HSKeyBoardView *)self.inputView;
    keyboardView.numType = isNewEnergy ? newEnergy : autos;
    [self refreshKeyboard:NO];
}

- (void)setPlate:(NSString *)plate type:(HSKeyboardNumType)type{
    HSKeyBoardView *keyboardView = (HSKeyBoardView *)self.inputView;
    self.text = plate;
    keyboardView.numType = type;
    BOOL isNewEnergy = type == newEnergy;
    [self changePlateInputType:isNewEnergy];
}

- (void)selectComplete:(NSString *)chars inputIndex:(NSInteger)inputIndex{
    if (!self.hasText) {
        self.text = @"";
    }
    if (![chars isEqualToString:@"删除"] && ![chars isEqualToString:@"确定"] && inputIndex == self.text.length - 1) {
        self.text = [KeyboardEngine subString:self.text start:0 length:self.text.length - 1];
    }
    BOOL isMoreType = NO;
    if ([chars isEqualToString:@"删除"] && self.text.length >= 1) {
        self.text = [KeyboardEngine subString:self.text start:0 length:self.text.length - 1];
    }else  if ([chars isEqualToString:@"确定"]){
        [self endEditing:YES];
    }else if ([chars isEqualToString:@"更多"]) {
        isMoreType = YES;
    } else if ([chars isEqualToString:@"返回"]) {
        isMoreType = NO;
    } else {
        self.text = [NSString stringWithFormat:@"%@%@",self.text,chars];
    }
    [self refreshKeyboard:isMoreType];
}


- (void)refreshKeyboard:(BOOL)isMoreType{
    //当输入框处于填满状态时，输入的下标往前移动一位数
    HSKeyBoardView *keyboardView = (HSKeyBoardView *)self.inputView;
    HSKeyboardNumType numType = keyboardView.numType == newEnergy ? newEnergy : [KeyboardEngine detectNumberTypeOf:self.text];
    NSInteger maxCount = (numType == newEnergy || numType == wuJing) ? 8 : 7;
    NSInteger inpuntIndex = maxCount <= self.text.length  ? (self.text.length - 1) : self.text.length;
    [keyboardView updateText:self.text isMoreType:isMoreType inputIndex:inpuntIndex];
}

- (BOOL)checkPlateComplete{
    if (self.text == nil) {
        return NO;
    }
    HSKeyBoardView *keyboardView = (HSKeyBoardView *)self.inputView;
    BOOL complete = NO;
    if (keyboardView.numType == newEnergy || keyboardView.numType == wuJing) {
        complete = self.text.length == 8;
    }else {
        complete = self.text.length == 7;
    }
    return complete;
}
@end
