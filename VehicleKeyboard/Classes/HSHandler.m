//
//  HSHandler.m
//  VehicleKeyboard
//
//  Created by huashengsheng on 2021/4/22.
//

#import "HSHandler.h"

#import "HSInputCollectionViewCell.h"

#import "UIView+HSCorners.h"
@implementation HSHandler


- (instancetype)init{
    if (self = [super init]) {
        
        self.textColor = [UIColor blackColor];
        
        self.textFontSize = 17;
        
        self.mainColor = [UIColor colorWithRed:65 / 256.0 green:138 / 256.0 blue:249 / 256.0 alpha:1];
        
        
        self.paletNumber = @"";
        
        self.itemColor = [UIColor whiteColor];
        
        self.itemSpacing = 0;
        
        self.cellBorderColor = [UIColor colorWithRed:216 / 256.0 green:216 / 256.0 blue:216 / 256.0 alpha:1];
        
        
        self.cornerRadius = 2;
        
        self.maxCount = 7;
        
        
    }
    return self;
}

/*
 将车牌输入框绑定到一个你自己创建的UIview
 **/
- (void)setKeyBoardView:(UIView *)view{
    self.view = view;
    self.collectionView = [[UICollectionView alloc]initWithFrame:view.bounds collectionViewLayout:[UICollectionViewFlowLayout new]];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[HSInputCollectionViewCell class] forCellWithReuseIdentifier:identifier];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [view addGestureRecognizer:tap];
    [view addSubview:self.collectionView];
    
    [self setNSLayoutConstraint:self.collectionView superView:view];
    
    self.inputCollectionView = self.collectionView;
    self.inputTextfield = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 0, view.frame.size.height)];
    [view addSubview:self.inputTextfield];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.scrollEnabled = NO;
    self.keyboardView.delegate = self;
    self.keyboardView.mainColor = self.mainColor;
    self.inputTextfield.inputView = self.keyboardView;
    //因为直接切给collectionView加边框 会盖住蓝色的选中边框   所以加一个和collectionView一样大的view再切边框
    [self setBackgroundView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(plateKeyBoardShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(plateKeyBoardHidden) name:UIKeyboardWillHideNotification object:nil];
}
//
///*
// 手动弹出键盘
// **/

- (void)vehicleKeyBoardBecomeFirstResponder{
    [self.inputTextfield becomeFirstResponder];
}

//
///*
// 手动隐藏键盘
// **/
- (void)vehicleKeyBoardEndEditing{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
}
//
///*
// 检查是否是符合新能源车牌的规则
// **/

- (BOOL)checkNewEnginePlate{
    for (NSInteger i = 0; i < self.paletNumber.length; i++) {
        KeyboardLayout *listModel = [KeyboardEngine generateLayout:civilAndArmy inputIndex:i presetNumber:[KeyboardEngine subString:self.paletNumber start:0 length:i] numberType:newEnergy isMoreType:NO];
        BOOL result = NO;
        for (NSInteger j = 0; j < [listModel rowArray].count; j++) {
            for (NSInteger k = 0; k < [listModel rowArray].count; k++) {
                Key *key = [listModel rowArray][j][k];
                if ([[KeyboardEngine subString:self.paletNumber start:i length:1] isEqualToString:key.text] && key.enabled){
                    result = YES;
                }
            }
        }
        if (!result) {
            return NO;
        }
    }
    return YES;
}

//
///*
// 检查输入车牌的完整
// **/

- (BOOL)isComplete{
    return self.paletNumber.length == self.maxCount;
}
- (void)setPlate:(NSString *)plate type:(HSKeyboardNumType)type{
    self.paletNumber = plate;
    BOOL isNewEnergy = type == newEnergy;
    HSKeyboardNumType numType = type;
    self.selectIndex = plate.length;
    if  (numType == autos && self.paletNumber.length > 0 && [[KeyboardEngine subString:self.paletNumber start:0 length:1] isEqualToString:@"W"]) {
        numType = wuJing;
    } else if (numType == autos && self.paletNumber.length == 8){
        numType = newEnergy;
    }
    self.keyboardView.numType = numType;
    self.isSetKeyboard = YES;
    [self changeInputType:isNewEnergy];
}
//
- (void)changeInputType:(BOOL)isNewEnergy{
    HSKeyBoardView *keyboardView = (HSKeyBoardView *)self.inputTextfield.inputView;
    keyboardView.numType = isNewEnergy ? newEnergy : autos;
    HSKeyboardNumType numType = keyboardView.numType;
    if  (self.paletNumber.length > 0 && [[KeyboardEngine subString:self.paletNumber start:0 length:1] isEqualToString:@"W"]) {
        numType = wuJing;
    }
    self.maxCount = (numType == newEnergy || numType == wuJing) ? 8 : 7;
    if (self.paletNumber.length > self.maxCount) {
        self.paletNumber = [KeyboardEngine subString:self.paletNumber start:0 length:self.paletNumber.length - 1];
    } else if (self.maxCount == 8 && self.paletNumber.length == 7) {
        self.selectIndex = 7;
    }
    if (self.selectIndex > (self.maxCount - 1)) {
        self.selectIndex = self.maxCount - 1;
    }
    [keyboardView updateText:self.paletNumber isMoreType:NO inputIndex:self.selectIndex];
    [self updateCollection];
}


- (void)setBackgroundView{
    if (self.itemSpacing <= 0) {
        UIView *backgroundView = [[UIView alloc]initWithFrame:self.inputCollectionView.bounds];
        backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:backgroundView];
        [self setNSLayoutConstraint:backgroundView superView:self.view];
        backgroundView.layer.borderWidth = 1;
        backgroundView.layer.borderColor = self.cellBorderColor.CGColor;
        backgroundView.userInteractionEnabled = NO;
        backgroundView.layer.masksToBounds = YES;
        backgroundView.layer.cornerRadius = self.cornerRadius;
        self.selectView.userInteractionEnabled = NO;
    }
    [self.view addSubview:self.selectView];
}

- (void)setNSLayoutConstraint:(UIView *)subView superView:(UIView *)superView{
    superView.frame = CGRectMake(subView.frame.origin.x, subView.frame.origin.y, subView.frame.size.width, subView.frame.size.height);
}

- (void)plateKeyBoardShow{
    if ([self.inputTextfield isFirstResponder]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(plateKeyBoardShow)]) {
            [self.delegate plateKeyBoardShow];
        }
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(plateKeyBoardHidden)]) {
            [self.delegate plateKeyBoardHidden];
        }
    }
}

- (void)plateKeyBoardHidden{
    if ([self.inputTextfield isFirstResponder]) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(plateKeyBoardHidden)]) {
            [self.delegate plateKeyBoardHidden];
        }
    }
}

- (void)plateInputComplete:(nonnull NSString *)plate {
    
}


- (void)tapAction:(UITapGestureRecognizer *)ges{
    CGPoint tapPoint = [ges locationInView:self.view];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:tapPoint];
    if (indexPath) {
        [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
    }
}

- (void)updateCollection{
    [self.inputCollectionView reloadData];
    if (![self.inputTextfield isFirstResponder] && !self.isSetKeyboard) {
        [self.inputTextfield becomeFirstResponder];
    }
    self.isSetKeyboard = NO;
}

- (void)selectComplete:(NSString *)chars inputIndex:(NSInteger)inputIndex{
    BOOL isMoreType = NO;
    if ([chars isEqualToString:@"删除"] && self.paletNumber.length >= 1 ){
        self.paletNumber = [KeyboardEngine subString:self.paletNumber start:0 length:self.paletNumber.length - 1];
        self.selectIndex = self.paletNumber.length;
    }else  if ([chars isEqualToString:@"确定"]){
        [[UIApplication sharedApplication].keyWindow endEditing:YES];
        if (self.delegate && [self.delegate respondsToSelector:@selector(plateInputComplete:)]) {
            [self.delegate plateInputComplete:self.paletNumber];
            return;
        }
    }else if ([chars isEqualToString:@"更多"]) {
        isMoreType = YES;
    } else if ([chars isEqualToString:@"返回"]) {
        isMoreType = NO;
    } else {
        if (self.paletNumber.length <= inputIndex){
            self.paletNumber = [NSString stringWithFormat:@"%@%@",self.paletNumber,chars];
        } else {
            NSMutableString *NSPalet = [NSMutableString stringWithString:self.paletNumber];
            [NSPalet replaceCharactersInRange:NSMakeRange(inputIndex, 1) withString:chars];
            self.paletNumber = NSPalet;
        }
        HSKeyBoardView *keyboardView = (HSKeyBoardView *)self.inputTextfield.inputView;
        
        NSInteger numType = keyboardView.numType == newEnergy ? newEnergy : [KeyboardEngine detectNumberTypeOf:self.paletNumber];
        self.maxCount = (numType == newEnergy || numType == wuJing) ? 8 : 7;
        if (self.maxCount > self.paletNumber.length || self.selectIndex < self.paletNumber.length - 1) {
            self.selectIndex += 1;
        }
    }
    [self.keyboardView updateText:self.paletNumber isMoreType:isMoreType inputIndex:self.selectIndex];
    [self updateCollection];
    if (!isMoreType){
        if (self.delegate && [self.delegate respondsToSelector:@selector(palteDidChnage:complete:)]) {
            [self.delegate palteDidChnage:self.paletNumber complete:self.paletNumber.length == self.maxCount];
        }
    }
}

- (NSString *)getPaletChar:(NSInteger)index{
    if (self.paletNumber.length > index) {
        NSString *NSPalet = self.paletNumber;
        NSString *chars = [NSPalet substringWithRange:NSMakeRange(index, 1)];
        return chars;
    }
    return @"";
}
    
- (void)corners:(UIView *)view index:(NSInteger)index{
    if (self.itemSpacing > 0) {
        view.layer.cornerRadius = self.cornerRadius;
    }else{
        //当格子之间没有间距时，第一个的左边和最后一个的右边会切圆角，其他都是直角
        [view addRounded:UIRectCornerAllCorners radii:CGSizeMake(0, 0)];
        if (index == 0) {
            [view addRounded:UIRectCornerTopLeft | UIRectCornerBottomLeft radii:CGSizeMake(2, 2)];
        }else if (index == self.maxCount - 1){
            [view addRounded:UIRectCornerTopRight | UIRectCornerBottomRight radii:CGSizeMake(2, 2)];
        }
    }
}
    

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];

}


//MARK:- collectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selectIndex = indexPath.row > self.paletNumber.length ? self.paletNumber.length : indexPath.row;
    [self.keyboardView updateText:self.paletNumber isMoreType:NO inputIndex:self.selectIndex];
    [self updateCollection];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.maxCount;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(((collectionView.frame.size.width - (self.maxCount - 1) * self.itemSpacing) / self.maxCount) - 0.01, collectionView.frame.size.height);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HSInputCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.charLab.text = [self getPaletChar:indexPath.row];
    cell.charLab.textColor = self.textColor;
    cell.charLab.font = [UIFont systemFontOfSize:self.textFontSize];
    cell.backgroundColor = self.itemColor;
    if (indexPath.row == self.selectIndex) {
        //给cell加上选中的边框
        self.selectView.layer.borderWidth = 2;
        self.selectView.layer.borderColor = self.mainColor.CGColor;
        self.selectView.frame = cell.frame;
        CGFloat rightSpace  = (self.maxCount - 1) == self.selectIndex ? 0 : 0.5;
        if (self.itemSpacing > 0){
            rightSpace = 0;
        }
        self.selectView.center = CGPointMake(cell.center.x + rightSpace, cell.center.y);
        [self corners:self.selectView index:self.selectIndex];
    }
    if (self.itemSpacing > 0) {
        cell.layer.borderWidth = 1;
        cell.layer.borderColor = self.cellBorderColor.CGColor;
    }
    [self corners:cell index:indexPath.row];
    cell.layer.masksToBounds = YES;
    return cell;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return self.itemSpacing;
}
@end
