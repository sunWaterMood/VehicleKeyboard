# 车牌号码专用键盘 

## 概述

* 车牌号码专用键盘ios版，支持新能源、武警、领事馆等多项专用格式车牌。
* 绑定UItextfield输入，键盘与系统键盘用法类似。



<img src="/Users/apple/Library/Application Support/typora-user-images/image-20210426104009749.png" alt="image-20210426104009749" style="zoom:50%;" />

## 如何使用

### 使用cocoaPods导入

在podfile中添加

```ruby
pod 'VehicleKeyboard'
```

然后pod install一下

## OC调用

oc引用pod中的库

```objective-c
#import <VehicleKeyboard/UITextField+Extension.h>
```

### 直接作为inputView使用

```objective-c
[self.myTextField changeToPlatePWKeyBoardInpurView];
```

直接作为inputView使用时，回调于取值都与系统方法一直，直接当做系统UItextfield使用即可

## 主要类的介绍

> 详细属性介绍请看注释

* HSKeyboardView:核心类，主要实现键盘逻辑与布局;
* HSHandler:自定义输入框的核心类，主要实现输入框逻辑，若使用者希望更好的调整布局，可继承此类重写layout的代理方法;
* Engine:键盘逻辑的核心类，实现键位的布局和注册。


## 注意

* 直接作为inputView使用时，当输入长度超过车牌规定长度时，会默认更新最后一位输入内容

## 可能的Q&A

* Q:   pod intall的时候失败提示找不到这个库？
* A:   pod其实是找的本地缓存目录，新上传的库可能出现找不到的情况，删除本地的~/Library/Caches/CocoaPods/search_index.json 缓存目录，用pod repo update master这个命令更新了本地的索引库，再pod install 试试。
* Q:  我设置了一些ui参数，但是实际显示和设置又些出入?
* A:   请在设置各种ui参数后再调用setKeyBoardView方法。
