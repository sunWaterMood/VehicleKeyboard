//
//  Marco.h
//  VehicleKeyboard
//
//  Created by huashengsheng on 2021/4/22.
//

#ifndef Marco_h
#define Marco_h



typedef enum : NSInteger {
    full = 0,
    civil,
    civilAndArmy,
} HSKeyboardType;

typedef enum : NSInteger{
    autos = 0,
    airport,
    wuJing,
    police,
    embassy,
    newEnergy,
} HSKeyboardNumType;

typedef enum : NSInteger {
    output = 0,
    del,
    done,
} HSKeyboardButtonType;


static NSString * const _STR_CIVIL_PVS = @"京津晋冀蒙辽吉黑沪苏浙皖闽赣鲁豫鄂湘粤桂琼渝川贵云藏陕甘青宁新台";
static NSString * const _CHAR_DEL = @"-";
static NSString *const _STR_DEL_OK = @"-+";
static NSString *const _STR_OK = @"+";
static NSString *const _STR_MORE = @">";
static NSString *const _STR_BACK = @"<";
static NSString *const _STR_Q_OP = @"QWERTYUIOP";
static NSString *const _STR_Q_N = @"QWERTYUPMN";
static NSString *const _STR_Q_P = @"QWERTYUP";
static NSString *const _STR_A_L = @"ASDFGHJKL";
static NSString *const _STR_A_M = @"ASDFGHJKLM";
static NSString *const _STR_A_B = @"ASDFGHJKLB";
static NSString *const _STR_A_K = @"ABCDEFGHJK";
static NSString *const _STR_Z_V = @"ZXCV";
static NSString *const _STR_Z_N = @"ZXCVBN";
static NSString *const _STR_W_Z = @"WXYZ";
static NSString *const _CHAR_W = @"W";
static NSString *const _CHAR_I = @"I";
static NSString *const _CHAR_O = @"O";
static NSString *const _CHAR_J = @"J";
static NSString *const _STR_DF = @"DF";
static NSString *const _STR_ZX = @"ZX";
static NSString *const _STR_NUM = @"1234567890";
static NSString *const _STR_NUM1_3 = @"123";
static NSString *const _STR_NUM4_0 = @"4567890";
static NSString *const _CHAR_MACAO = @"澳";
static NSString *const _CHAR_HK = @"港";
static NSString *const _CHAR_TAI = @"台";
static NSString *const _CHAR_XUE = @"学";
static NSString *const _CHAR_MIN = @"民";
static NSString *const _CHAR_HANG = @"航";
static NSString *const _CHAR_SHI = @"使";
static NSString *const _CHAR_SPECIAL = @"学警港澳航挂试超使领";
static NSString *const _STR_HK_MACAO = @"港澳";

#define kMainBundle [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"VehicleKeyboard" ofType:@"bundle"]]
#define kHSBundle   [NSBundle bundleWithPath:[kMainBundle pathForResource:@"HSBundle.bundle" ofType:nil]]
#endif /* Marco_h */
