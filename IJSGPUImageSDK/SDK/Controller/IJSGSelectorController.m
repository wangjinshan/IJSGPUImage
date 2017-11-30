//
//  IJSGSelectorController.m
//  IJSGPUImageSDK
//
//  Created by 山神 on 2017/11/8.
//  Copyright © 2017年 山神. All rights reserved.
//

#import "IJSGSelectorController.h"
#import "IJSGimageFilterController.h"
#import "IJSGvideoFilterViewController.h"
#import "IJSGcameraFilterController.h"
#import "IJSGphotoFilterController.h"

@interface IJSGSelectorController ()

@end

@implementation IJSGSelectorController

- (instancetype)init
{
    self = [self initWithSourceType:IJSGSourceTypeCamera image:nil video:nil];
    self.sourceType =IJSGSourceTypeCamera;
    return self;
}

- (instancetype)initWithSourceType:(IJSGSourceType)type image:(UIImage *)image video:(AVAsset *)video
{

    UIViewController *vc;
    if (type == IJSGSourceTypeImage)
    {
        vc = [[IJSGimageFilterController alloc] init];
        ((IJSGimageFilterController *) vc).image = image;
        self.sourceType = IJSGSourceTypeImage;
    }
    if (type == IJSGSourceTypeVideo)
    {
        IJSGvideoFilterViewController *vc = [[IJSGvideoFilterViewController alloc] init];
        vc.video = video;
        self.sourceType = IJSGSourceTypeVideo;
    }
    if (type == IJSGSourceTypePhoto)
    {
        vc = [[IJSGphotoFilterController alloc] init];
        self.sourceType = IJSGSourceTypePhoto;
    }
    if (type == IJSGSourceTypeCamera)
    {
        vc = [[IJSGcameraFilterController alloc]init];
        self.sourceType = IJSGSourceTypeCamera;
    }    
    self = [super initWithRootViewController:vc];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self setup];
}
//
//#pragma mark 导航条
//- (void)setup
//{
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:(UIBarButtonItemStylePlain) target:self action:@selector(cancelAction)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishAction)];
//}
//
//-(void)cancelAction
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}
//
//-(void)finishAction
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}











- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
