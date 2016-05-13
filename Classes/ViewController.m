//
//  ViewController.m
//  Classes
//
//  Created by Kevin B. Adesara on 4/1/16.
//  Copyright © 2016 Kevin B. Adesara. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"Device UDID == %@",[APP_UTILITY getDeviceUdid]);
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
