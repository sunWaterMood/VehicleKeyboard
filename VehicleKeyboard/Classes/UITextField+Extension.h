//
//  UITextField+Extension.h
//  VehicleKeyboard
//
//  Created by huashengsheng on 2021/4/23.
//

#import <UIKit/UIKit.h>
#import "HSKeyBoardView.h"
#import "Marco.h"
#import "KeyboardEngine.h"
NS_ASSUME_NONNULL_BEGIN

@interface UITextField (Extension)<HSKeyBoardViewDeleagte>

- (void)changeToPlatePWKeyBoardInpurView;

- (void)changePlateInputType:(BOOL)isNewEnergy;

- (void)setPlate:(NSString *)plate type:(HSKeyboardNumType)type;
@end

NS_ASSUME_NONNULL_END
