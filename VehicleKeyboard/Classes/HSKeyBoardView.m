//
//  HSKeyBoardView.m
//  VehicleKeyboard
//
//  Created by huashengsheng on 2021/4/23.
//

#import "HSKeyBoardView.h"
#import "HSKeyBoardCollectionViewCell.h"

#define HSScreenWidth [UIScreen mainScreen].bounds.size.width
#define HSScreenHeight [UIScreen mainScreen].bounds.size.height
#define HSScreenBounds [UIScreen mainScreen].bounds
#define HSMainScreen [UIScreen mainScreen]

#define HSkeybordHeight 226
#define kItemSpacing 1
CGFloat kItemHeight = 51;

static NSString * const identifier = @"HSKeyBoardCollectionViewCell";

@implementation HSKeyBoardView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:CGRectMake(0, HSScreenHeight - HSkeybordHeight, HSScreenWidth, HSkeybordHeight)]) {
        
        self.numType = autos;
        
        self.promptView = [[HSPromptView alloc]initWithFrame:CGRectMake(0, 0, 55, 74)];
        
        self.mainColor = [UIColor colorWithRed:65 / 256.0 green:138 / 256.0 blue:249 / 256.0 alpha:1];
        
        
        [self setUI];
        
    }
    return self;
}

- (void)setUI{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(30, 30);
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, HSScreenWidth, [self iphonxKeyBoardHeight]) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor colorWithRed:238 / 256.0 green:238 / 256.0 blue:238 / 256.0 alpha:0];
    
    [self.collectionView registerClass:[HSKeyBoardCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    [self addSubview:self.collectionView];
    self.collectionView.bounces = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.delaysContentTouches = NO;
    self.collectionView.canCancelContentTouches = YES;
    self.listModel = [KeyboardEngine generateLayout:civilAndArmy inputIndex:0 presetNumber:@"" numberType:self.numType isMoreType:NO];
    [self.collectionView reloadData];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HSScreenWidth, 0.5)];
    lineView.backgroundColor = [UIColor colorWithRed:204 / 256.0 green:204 / 256.0 blue:204 / 256.0 alpha:1];
    [self addSubview:lineView];
    self.promptView.hidden = YES;
    [self addSubview:self.promptView];
}


- (BOOL)isIphoneX{
    if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].delegate.window;
        if (window == nil) {
            return NO;
        }
        if (window.safeAreaInsets.left > 0 || window.safeAreaInsets.bottom > 0) {
            return YES;
        }
    }
    return NO;
}
- (CGFloat)iphonxKeyBoardHeight{
    return  HSkeybordHeight + [self iphoneXtabHeight];
}

- (CGFloat)iphoneXtabHeight{
    return [self isIphoneX] ? 34 : 0;
}

- (void)updateText:(NSString *)text isMoreType:(BOOL)isMoreType inputIndex:(NSInteger)inputIndex{
    self.inputIndex = inputIndex;
    self.listModel = [KeyboardEngine generateLayout:civilAndArmy inputIndex:inputIndex presetNumber:text numberType:self.numType isMoreType:isMoreType];
    [self.collectionView reloadData];
}

- (CGFloat)normalItemWith{
    CGFloat width = (HSScreenWidth - 8 - kItemSpacing * ((CGFloat)[[self.listModel rowArray][0] count] - 1)) / (CGFloat)[[self.listModel rowArray][0] count];
    return width;
    
}

- (CGFloat)submitItemWidth{
    return ([self normalItemWith] - 5) / 40 * 70 + 5;
}

- (CGFloat)deleteItemWidth{
//    //在没有更多的情况下删除按钮的大小还需要加上左边的间距
    if (self.listModel.row3[self.listModel.row3.count - 3].keyCode > 2) {
        return [self specialButtonWidth];
    }
    CGFloat width = (HSScreenWidth - 8 - [self submitItemWidth] - [self normalItemWith] * (CGFloat)([self.listModel rowArray][3].count - 2) - (CGFloat)([self.listModel rowArray][3].count - 1) * kItemSpacing) - 0.1;
    return width;
}
- (CGFloat)moreItemWIdth{
    CGFloat width = (HSScreenWidth - 8 - [self submitItemWidth] - [self normalItemWith] * (CGFloat)([self.listModel rowArray][3].count - 3) - (CGFloat)([self.listModel rowArray][3].count - 1) * kItemSpacing) - 0.1 - [self deleteItemWidth];
    return width;
}

- (CGFloat)specialButtonWidth{
    return ([self normalItemWith] - 5) / 40 * 80 + 5;
}

- (void)showPrompt:(HSKeyBoardCollectionViewCell *)item{
    self.promptView.center = CGPointMake(item.center.x, item.center.y - kItemHeight / 2 - 21);
    self.promptView.centerTextLabel.text = item.centerLabel.text;
    self.promptView.centerTextLabel.textColor = self.mainColor;
    self.promptView.hidden = NO;
}

- (void)hiddenPromt{
    self.promptView.hidden = YES;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[self.listModel rowArray][section] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HSKeyBoardCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    
    // 处理reload时，cell的宽度和高度不对
    CGFloat Itemwidth = [self normalItemWith];
    CGFloat sizeWidth = Itemwidth;
    kItemHeight = [self isIphoneX] ? 45 : kItemHeight;
    //更多键的宽度需要加上左边空出来的宽度，没有更多时删除键加上
    if ([self.listModel rowArray][indexPath.section][indexPath.row] == self.listModel.row3[self.listModel.row3.count - 2]){
        sizeWidth = [self deleteItemWidth];
    } else if ([self.listModel rowArray][indexPath.section][indexPath.row] == self.listModel.row3.lastObject){
        sizeWidth = [self submitItemWidth];
    } else if ([self.listModel rowArray][indexPath.section][indexPath.row] == self.listModel.row3[self.listModel.row3.count - 3]){
        //有更多的时候加长
        if (self.listModel.row3[self.listModel.row3.count - 3].keyCode > 2) {
            sizeWidth = [self moreItemWIdth];
        }
    }

    
    Key *currentKey = [self.listModel rowArray][indexPath.section][indexPath.row];
    [cell resetUI:CGSizeMake(sizeWidth, kItemHeight)];
    cell.mainColor = self.mainColor;
    cell.centerLabel.text = currentKey.text;
    cell.isEnabledStatus = currentKey.enabled;
    if (currentKey == self.listModel.row3[self.listModel.row3.count - 2]) {
        //给加宽的删除键左边留间隙
        CGFloat  left = [self deleteItemWidth] - [self specialButtonWidth];
        [cell setDeleteButton:left size:CGSizeMake(sizeWidth, kItemHeight)];
    }else if (currentKey == self.listModel.row3[self.listModel.row3.count - 3] &&
        self.listModel.row3[self.listModel.row3.count - 3].keyCode > 2) {
        //给加宽的更多键左边留间隙
        CGFloat  left = [self moreItemWIdth] - [self specialButtonWidth];
        [cell setMoreButton:left size:CGSizeMake(sizeWidth, kItemHeight)];
    }else if (currentKey == self.listModel.row3.lastObject) {
        //确定键颜色特殊处理
        [cell setSubmitBUtton:currentKey.enabled size:CGSizeMake(sizeWidth, kItemHeight)];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = [self normalItemWith];
    kItemHeight = [self isIphoneX] ? 45 : kItemHeight;
    //更多键的宽度需要加上左边空出来的宽度，没有更多时删除键加上
    if ([self.listModel rowArray][indexPath.section][indexPath.row] == self.listModel.row3[self.listModel.row3.count - 2]){
        return CGSizeMake([self deleteItemWidth], kItemHeight);
    } else if ([self.listModel rowArray][indexPath.section][indexPath.row] == self.listModel.row3.lastObject){
        return CGSizeMake([self submitItemWidth], kItemHeight);
    } else if ([self.listModel rowArray][indexPath.section][indexPath.row] == self.listModel.row3[self.listModel.row3.count - 3]){
        //有更多的时候加长
        if (self.listModel.row3[self.listModel.row3.count - 3].keyCode > 2) {
            return CGSizeMake([self moreItemWIdth], kItemHeight);
        }
    }
    return CGSizeMake(width, kItemHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    CGFloat width = (HSScreenWidth - 8 - kItemSpacing * ((CGFloat)([self.listModel rowArray][0].count) - 1)) / (CGFloat)([self.listModel rowArray][0].count);
    CGFloat leftWidth = (HSScreenWidth - width * (CGFloat)([self.listModel rowArray][section].count) - kItemSpacing * (CGFloat)([self.listModel rowArray][section].count - 1)) / 2;
    leftWidth = section == 3 ? 4 : leftWidth;
    NSArray *topArray = @[@7,@5,@5,@4];
    return UIEdgeInsetsMake([topArray[section] intValue], leftWidth, 0, leftWidth);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return kItemSpacing;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //没有值时点击删除键有点击效果但是不做处理
    if  ((self.listModel.presetNumber != nil || self.listModel.presetNumber.length <= 0 ) &&
        self.listModel.presetNumber.length < 1 &&
        indexPath.section == 3 &&
        indexPath.row == [self.listModel rowArray][indexPath.section].count - 2) {
        [self.collectionView reloadData];
        return;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectComplete:inputIndex:)]) {
        [self.delegate selectComplete:[self.listModel rowArray][indexPath.section][indexPath.row].text inputIndex:self.inputIndex];
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    Key *currentKey = [self.listModel rowArray][indexPath.section][indexPath.row];
    
     if (currentKey == self.listModel.row3.lastObject){
        
     } else if (currentKey == self.listModel.row3[self.listModel.row3.count - 2]){
        
     } else if (currentKey.keyCode > 2){
        
     } else if (currentKey.enabled) {
         HSKeyBoardCollectionViewCell *item = (HSKeyBoardCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
         [self showPrompt:item];
    }
    return currentKey.enabled;
}
- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    [self hiddenPromt];
}
@end
