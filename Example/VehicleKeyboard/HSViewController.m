//
//  HSViewController.m
//  VehicleKeyboard
//
//  Created by 华生升 on 04/22/2021.
//  Copyright (c) 2021 华生升. All rights reserved.
//

#import "HSViewController.h"


#import <VehicleKeyboard/UITextField+Extension.h>

@interface HSViewController ()

@end

@implementation HSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UITextField *text = [[UITextField alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 50)];
    text.backgroundColor = [UIColor grayColor];
    [self.view addSubview:text];
    [text changeToPlatePWKeyBoardInpurView];
//    [text changePlateInputType:YES];
    
    
//    HSKeyBoardView *keyboardView = [[HSKeyBoardView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 226)];
//    [self.view addSubview:keyboardView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
