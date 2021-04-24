//
//  HSHandler.h
//  VehicleKeyboard
//
//  Created by huashengsheng on 2021/4/22.
//

#import <Foundation/Foundation.h>

#import "HSKeyBoardView.h"
NS_ASSUME_NONNULL_BEGIN

@protocol HSHandlerDelegate <NSObject>

- (void)plateInputComplete:(NSString *)plate;

@optional

- (void)palteDidChnage:(NSString *)plate complete:(BOOL)complete;

- (void)plateKeyBoardShow;

- (void)plateKeyBoardHidden;

@end

static NSString * const identifier = @"HSInputCollectionViewCell";

@interface HSHandler : NSObject<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,HSHandlerDelegate,HSKeyBoardViewDeleagte>

////格子中字体的颜色
@property (nonatomic, strong) UIColor  *textColor;

//格子中字体的大小
@property (nonatomic, assign) CGFloat  textFontSize;

//设置主题色（会影响格子的边框颜色、按下去时提示栏颜色、确定按钮可用时的颜色）
@property (nonatomic, strong) UIColor  *mainColor;

//当前格子中的输入内容

@property (nonatomic, strong) NSString *  paletNumber;
//每个格子的背景色
@property (nonatomic, strong) UIColor  *itemColor;

//格子之间的间距

@property (nonatomic, assign) CGFloat  itemSpacing;

//边框颜色
@property (nonatomic, strong) UIColor  *cellBorderColor;

//每个格子的圆角(ps:仅在有间距时生效)

@property (nonatomic, assign) CGFloat  cornerRadius;

@property (nonatomic, weak) id<HSHandlerDelegate>  delegate;

@property (nonatomic, strong) UICollectionView  *inputCollectionView;

@property (nonatomic, assign) NSInteger  maxCount;

@property (nonatomic, assign) NSInteger  selectIndex;

@property (nonatomic, strong) UITextField  *inputTextfield;

@property (nonatomic, strong) HSKeyBoardView  *keyboardView;

@property (nonatomic, strong) UIView  *selectView;
//预设值时不设置为第一响应对象
@property (nonatomic, assign) BOOL  isSetKeyboard;

@property (nonatomic, strong) UIView  *view;

@property (nonatomic, strong) UICollectionView  *collectionView;

@end

NS_ASSUME_NONNULL_END
