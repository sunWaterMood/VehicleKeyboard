//
//  HSKeyBoardView.h
//  VehicleKeyboard
//
//  Created by huashengsheng on 2021/4/23.
//

#import <UIKit/UIKit.h>
#import "Marco.h"
#import "KeyboardLayout.h"
#import "HSPromptView.h"
#import "KeyboardEngine.h"
NS_ASSUME_NONNULL_BEGIN

@protocol HSKeyBoardViewDeleagte <NSObject>

- (void)selectComplete:(NSString *)chars inputIndex:(NSInteger)inputIndex;

@end

@interface HSKeyBoardView : UIView<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView  *collectionView;


@property (nonatomic, strong) KeyboardLayout *  listModel;

@property (nonatomic, assign) HSKeyboardNumType  numType;


@property (nonatomic, assign) NSInteger  inputIndex;

@property (nonatomic, weak) id<HSKeyBoardViewDeleagte>  delegate;

@property (nonatomic, strong) HSPromptView  *promptView;

@property (nonatomic, strong) UIColor  *mainColor;

- (void)updateText:(NSString *)text isMoreType:(BOOL)isMoreType inputIndex:(NSInteger)inputIndex;
@end

NS_ASSUME_NONNULL_END
