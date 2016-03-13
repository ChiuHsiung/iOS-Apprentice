//
//  ViewController.m
//  BullsEye-OC
//
//  Created by zhuangqiuxiong on 16/3/13.
//  Copyright © 2016年 zhuangqiuxiong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showAlert:(id)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello, world" message:@"This is my first app!" delegate:nil cancelButtonTitle:@"Awesome" otherButtonTitles:nil];
    
    
    [alert show];
    
}

@end
