//
//  KeyboardEngine.m
//  VehicleKeyboard
//
//  Created by huashengsheng on 2021/4/22.
//

#import "KeyboardEngine.h"

@implementation KeyboardEngine
+ (KeyboardLayout *)generateLayout:(HSKeyboardType)keyboardType inputIndex:(NSInteger)inputIndex presetNumber:(NSString *)presetNumber numberType:(HSKeyboardNumType)numberType isMoreType:(BOOL)isMoreType{
    NSInteger detectedNumberType = numberType;
    if (numberType == autos) {
        detectedNumberType = [KeyboardEngine detectNumberTypeOf:presetNumber];
    }
    
    //获取键位布局
    KeyboardLayout *layoutLout = [KeyboardEngine getKeyProvider:inputIndex presetNumber:presetNumber isMoreType:isMoreType];
    
    //注册键位
    layoutLout = [KeyboardEngine keyRegist:presetNumber inputIndex:inputIndex listModel:layoutLout numberType:detectedNumberType];
    layoutLout.presetNumber = presetNumber;
    layoutLout.numberType = numberType;
    layoutLout.index = inputIndex;
    layoutLout.keyboardType = keyboardType;

    NSMutableArray *keysArray = [NSMutableArray array];
    [keysArray addObjectsFromArray:layoutLout.row1];
    [keysArray addObjectsFromArray:layoutLout.row0];
    [keysArray addObjectsFromArray:layoutLout.row2];
    [keysArray addObjectsFromArray:layoutLout.row3];
    layoutLout.keys = keysArray;
    return layoutLout;
}
//键位布局
+ (KeyboardLayout *)getKeyProvider:(NSInteger)inputIndex presetNumber:(NSString *)presetNumber isMoreType:(BOOL)isMoreType{
    KeyboardLayout *layout = [[KeyboardLayout alloc]init];
    switch (inputIndex) {
    case 0:
        {
            if (!isMoreType) {
                layout = [KeyboardEngine defaultProvinces];
            } else {
                layout.row0 = [KeyboardEngine getModelArrayWithString:_STR_NUM];
                layout.row1 = [KeyboardEngine getModelArrayWithString:_STR_Q_N];
                layout.row2 = [KeyboardEngine getModelArrayWithString:_STR_A_L];
                layout.row3 = [KeyboardEngine getModelArrayWithString: [NSString stringWithFormat:@"%@%@%@%@%@",_STR_ZX, _CHAR_MIN , _CHAR_SHI , _STR_BACK ,_STR_DEL_OK]];
            }
        }
        break;
    case 1:
        {
            if ([[KeyboardEngine subString:presetNumber start:0 length:1] isEqualToString:_CHAR_MIN]) {
                layout = [KeyboardEngine defaultSpecial];
            }else{
                layout = [KeyboardEngine defaultNumbersAndLetters];
            }
        }
        break;
    case 2:
    case 3:
    case 4:
    case 5:
        {
            if (inputIndex == 2 && [[KeyboardEngine subString:presetNumber start:0 length:2] isEqualToString:[NSString stringWithFormat:@"%@%@",_CHAR_W,_CHAR_J]]) {
                layout = [KeyboardEngine defaultProvinces];
            }else{
                layout = [KeyboardEngine defaultNumbersAndLetters];
            }
        }
        break;
    case 6:
        {
            if (!isMoreType) {
                layout = [KeyboardEngine defaultLast];
            } else {
                layout = [KeyboardEngine defaultSpecial];
            }
        }
        break;
    case 7:
        {
            layout = [KeyboardEngine defaultLast];
        }
        break;
    default:
        break;
    }
    return layout;
}

+ (KeyboardLayout *)keyRegist:(NSString *)keyString inputIndex:(NSInteger)inputIndex listModel:(KeyboardLayout *)listModel numberType:(HSKeyboardNumType)numberType{
    KeyboardLayout *list = listModel;
    NSString *okString = @"";
    if (numberType == newEnergy || numberType == wuJing) {
        okString = keyString.length == 8 ? _STR_OK : @"";
    }else {
        okString = keyString.length == 7 ? _STR_OK : @"";
    }
    NSString *disOkString = [okString isEqualToString:@""] ? _STR_OK : @"";
    switch (inputIndex) {
    case 0:
        {
            if (numberType == newEnergy) {
                list = [KeyboardEngine disEnabledKey:@[_STR_MORE,disOkString,_CHAR_TAI] listModel:list reverseModel:NO];
            } else {
                list = [KeyboardEngine disEnabledKey:@[disOkString,_CHAR_TAI] listModel:list reverseModel:NO];
            }
        }
        break;
    case 1:
        {
            if (numberType == wuJing) {
                list = [KeyboardEngine disEnabledKey:@[_CHAR_J,_CHAR_DEL,okString] listModel:list reverseModel:YES];
            } else if (numberType == embassy) {
                NSMutableArray *keyString = [NSMutableArray arrayWithObjects:_CHAR_DEL,okString, nil];
                NSArray *stringArray = [KeyboardEngine chStringArray:_STR_NUM1_3];
                [keyString addObjectsFromArray:stringArray];
                list = [KeyboardEngine disEnabledKey:keyString listModel:list reverseModel:YES];
            } else if (numberType == airport) {
                list = [KeyboardEngine disEnabledKey:@[_CHAR_HANG,_CHAR_DEL,okString] listModel:list reverseModel:YES];
            } else {
                NSArray *stringArray = [KeyboardEngine chStringArray:[NSString stringWithFormat:@"%@%@%@",_STR_NUM4_0,_CHAR_I,disOkString]];
                list = [KeyboardEngine disEnabledKey:stringArray listModel:list reverseModel:NO];
            }
        }
        break;
    case 2:
        {
    //            if numberType == PWKeyboardNumType.newEnergy {
    //                list = KeyboardEngine.disEnabledKey(keyString:KeyboardEngine.chStringArray(string: _STR_NUM + _CHAR_DEL + _STR_DF + okString), listModel: list, reverseModel:true)
    //            } else
                if (numberType == wuJing) {
                    list = [KeyboardEngine disEnabledKey:@[disOkString,_STR_MORE,_CHAR_TAI] listModel:list reverseModel:NO];
            } else if (numberType == embassy){
                NSArray *stringArray = [KeyboardEngine chStringArray:[NSString stringWithFormat:@"%@%@%@",_STR_NUM,_CHAR_DEL,okString]];
                list = [KeyboardEngine disEnabledKey:stringArray listModel:list reverseModel:YES];
            } else {
                NSArray *stringArray = [KeyboardEngine chStringArray:[NSString stringWithFormat:@"%@%@%@",_CHAR_I,_CHAR_O,disOkString]];
                list = [KeyboardEngine disEnabledKey:stringArray listModel:list reverseModel:NO];
            }
        }
        break;
    case 3:
        {
            if (numberType == embassy){
                NSArray *stringArray = [KeyboardEngine chStringArray:[NSString stringWithFormat:@"%@%@%@",_STR_NUM,_CHAR_DEL,okString]];
                list = [KeyboardEngine disEnabledKey:stringArray listModel:list reverseModel:YES];
            } else {
                NSArray *stringArray = [KeyboardEngine chStringArray:[NSString stringWithFormat:@"%@%@%@",_CHAR_I,_CHAR_O,disOkString]];
                list = [KeyboardEngine disEnabledKey:stringArray listModel:list reverseModel:NO];
            }
        }
        break;
    case 4:
    case 5:
        {
            NSArray *stringArray = [KeyboardEngine chStringArray:[NSString stringWithFormat:@"%@%@%@",_CHAR_I,_CHAR_O,disOkString]];
            list = [KeyboardEngine disEnabledKey:stringArray listModel:list reverseModel:NO];
        }
        break;
    case 6:
        {
            if ([[KeyboardEngine subString:keyString start:0 length:2] isEqualToString:@"粤Z"]) {
                NSArray *stringArray = [KeyboardEngine chStringArray:[NSString stringWithFormat:@"%@%@%@%@%@",_CHAR_MACAO,_CHAR_HK,_CHAR_DEL,okString,_STR_MORE]];
                list = [KeyboardEngine disEnabledKey:stringArray listModel:list reverseModel:YES];
            }else if (numberType == embassy || numberType == airport || numberType == newEnergy){
                NSArray *stringArray = [KeyboardEngine chStringArray:[NSString stringWithFormat:@"%@%@",_STR_MORE,disOkString]];
                list = [KeyboardEngine disEnabledKey:stringArray listModel:list reverseModel:NO];
            }else{
                NSArray *stringArray = [KeyboardEngine chStringArray:[NSString stringWithFormat:@"%@%@%@%@%@",_CHAR_MACAO,_CHAR_HK,disOkString,_CHAR_HANG,_CHAR_SHI]];
                list = [KeyboardEngine disEnabledKey:stringArray listModel:list reverseModel:NO];
            }
        }
        break;
    case 7:
        {
            NSString *complete = keyString.length == 8 ? _STR_OK : @"";
            NSArray *stringArray = [KeyboardEngine chStringArray:[NSString stringWithFormat:@"%@%@%@%@",_STR_NUM,_CHAR_DEL,_STR_DF,complete]];
            list = [KeyboardEngine disEnabledKey:stringArray listModel:list reverseModel:YES];
        }
        break;
    default:
            break;
    }
    return listModel;
}


+ (KeyboardLayout *)defaultNumbersAndLetters{
    KeyboardLayout *listModel = [[KeyboardLayout alloc]init];
    listModel.row0 = [KeyboardEngine getModelArrayWithString:_STR_NUM];
    listModel.row1 = [KeyboardEngine getModelArrayWithString:_STR_Q_OP];
    listModel.row2 = [KeyboardEngine getModelArrayWithString:_STR_A_M];
    listModel.row3 = [KeyboardEngine getModelArrayWithString:[NSString stringWithFormat:@"%@%@",_STR_Z_N,_STR_DEL_OK]];
    return listModel;
}

+ (KeyboardLayout *)defaultSpecial{
    KeyboardLayout *listModel = [[KeyboardLayout alloc]init];
    listModel.row0 = [KeyboardEngine getModelArrayWithString:_CHAR_SPECIAL];
    listModel.row1 = [KeyboardEngine getModelArrayWithString:_STR_NUM];
    listModel.row2 = [KeyboardEngine getModelArrayWithString:_STR_A_K];
    listModel.row3 = [KeyboardEngine getModelArrayWithString:[NSString stringWithFormat:@"%@%@%@",_STR_W_Z,_STR_BACK,_STR_DEL_OK]];
    return listModel;
}

+ (KeyboardLayout *)defaultLast{
    KeyboardLayout *listModel = [[KeyboardLayout alloc]init];
    listModel.row0 = [KeyboardEngine getModelArrayWithString:_STR_NUM];
    listModel.row1 = [KeyboardEngine getModelArrayWithString:_STR_Q_N];
    listModel.row2 = [KeyboardEngine getModelArrayWithString:_STR_A_B];
    listModel.row3 = [KeyboardEngine getModelArrayWithString:[NSString stringWithFormat:@"%@%@%@",_STR_Z_V,_STR_MORE,_STR_DEL_OK]];
    return listModel;
}

+ (KeyboardLayout *)defaultProvinces{
    KeyboardLayout *listModel = [[KeyboardLayout alloc]init];
    listModel.row0 = [KeyboardEngine getModelArrayWithString:[KeyboardEngine subString:_STR_CIVIL_PVS start:0 length:10]];
    listModel.row1 = [KeyboardEngine getModelArrayWithString:[KeyboardEngine subString:_STR_CIVIL_PVS start:10 length:10]];
    listModel.row2 = [KeyboardEngine getModelArrayWithString:[KeyboardEngine subString:_STR_CIVIL_PVS start:20 length:8]];
    listModel.row3 = [KeyboardEngine getModelArrayWithString:[NSString stringWithFormat:@"%@%@%@",[KeyboardEngine subString:_STR_CIVIL_PVS start:28 length:4],_STR_MORE,_STR_DEL_OK]];

    return listModel;
}

+ (NSArray<Key *> *)getModelArrayWithString:(NSString *)keyString{
    NSMutableArray *modelArray = [NSMutableArray array];
    for (NSInteger i = 0; i < keyString.length; i++) {
        NSString *str = [keyString substringWithRange:NSMakeRange(i, 1)];
        Key *model = [[Key alloc]init];
        model.enabled = YES;
        model.text = str;
        [modelArray addObject:model];
    }
    return modelArray;
}

+ (KeyboardLayout *)disEnabledKey:(NSArray<NSString *> *)keyString listModel:(KeyboardLayout *)listModel reverseModel:(BOOL)reverseModel{
    KeyboardLayout *list = listModel;
    list.row0 = [KeyboardEngine disEnableKey:keyString row:list.row0 reverseModel:reverseModel];
    list.row1 = [KeyboardEngine disEnableKey:keyString row:list.row1 reverseModel:reverseModel];
    list.row2 = [KeyboardEngine disEnableKey:keyString row:list.row2 reverseModel:reverseModel];
    list.row3 = [KeyboardEngine disEnableKey:keyString row:list.row3 reverseModel:reverseModel];
    return list;
}

+ (NSArray<Key *> *)disEnableKey:(NSArray<NSString *> *)keyString row:(NSArray<Key *> *)row reverseModel:(BOOL)reverseModel{
    for (Key *model in row) {
        model.enabled = !reverseModel;
        model.keyCode = 0;
        for(NSString *str in keyString) {
            if ([model.text isEqualToString:str]) {
                model.enabled = reverseModel;
            }
        }
        if ([model.text isEqualToString:@"+"]) {
            model.text = @"确定";
            model.keyCode = 2;
        }else if ([model.text isEqualToString:@"-"]){
            model.text = @"删除";
            model.keyCode = 1;
            //>
        } else if ([model.text isEqualToString:@">"]){
            model.keyCode = 3;
            model.text = @"更多";
            ///<
        } else if ([model.text isEqualToString:@"<"]){
            model.keyCode = 4;
            model.text = @"返回";
        }
    }
    return row;
}

+ (NSArray<NSString *> *)chStringArray:(NSString *)string{
    NSMutableArray *strArray = [NSMutableArray array];
    for (NSInteger i = 0; i < string.length; i++) {
        NSString *str = [string substringWithRange:NSMakeRange(i, 1)];
        [strArray addObject:str];
    }
    return strArray;
}

+ (HSKeyboardNumType)detectNumberTypeOf:(NSString *)presetNumber{
    if (presetNumber.length >= 1) {
        if ([[KeyboardEngine subString:presetNumber start:0 length:1] isEqualToString:_CHAR_W]) {
            return wuJing;
        }else if ([[KeyboardEngine subString:presetNumber start:0 length:1] isEqualToString:_CHAR_MIN]){
            return airport;
        }else if ([[KeyboardEngine subString:presetNumber start:0 length:1] isEqualToString:_CHAR_SHI]){
            return embassy;
        }
    }
    if (presetNumber.length == 8) {
        return newEnergy;
    }
    return autos;
}

+ (NSString *)subString:(NSString *)str start:(NSInteger)start length:(NSInteger)length{
    if (length == 0) {
        return @"";
    }
    return [str substringWithRange:NSMakeRange(start, length)];
}
@end
