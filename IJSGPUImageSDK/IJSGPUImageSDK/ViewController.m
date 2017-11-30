//
//  ViewController.m
//  IJSGPUImageSDK
//
//  Created by 山神 on 2017/11/8.
//  Copyright © 2017年 山神. All rights reserved.
//

#import "ViewController.h"
#import "IJSGSelectorController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)filterAction:(UIButton *)sender
{
    UIImage *image = [UIImage imageNamed:@"WID-small.jpg"];
    IJSGSelectorController *vc = [[IJSGSelectorController alloc] initWithSourceType:IJSGSourceTypeCamera image:image video:nil];
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
