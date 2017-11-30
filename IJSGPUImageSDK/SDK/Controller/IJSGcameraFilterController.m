//
//  IJSGcameraFilterController.m
//  IJSGPUImageSDK
//
//  Created by 山神 on 2017/11/8.
//  Copyright © 2017年 山神. All rights reserved.
//

#import "IJSGcameraFilterController.h"
#import "IJSGHeaderConst.h"
#import "IJSGToolsView.h"
#import <GPUImage.h>
#import "IJSGSelectorController.h"
@interface IJSGcameraFilterController ()
@property(nonatomic,weak) IJSGToolsView *toolsView;  // 工具条
@property(nonatomic,weak) UISlider *filterSettingsSlider;  // 滑条

@end

@implementation IJSGcameraFilterController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = cameraTitle;
    self.view.backgroundColor =[UIColor blackColor];
 
    
    [self setupUI];
    [self blockCallBackAction];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}

-(void)setupUI
{
    // 创建展示的视图区域
    self.gpuImageView = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.gpuImageView];
    self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait; // 方向
    
    // 创建滤镜：磨皮，美白，组合滤镜
    GPUImageFilterGroup *groupFilter = [[GPUImageFilterGroup alloc] init];
    
    // 磨皮滤镜
    GPUImageBilateralFilter *bilateralFilter = [[GPUImageBilateralFilter alloc] init];
    [groupFilter addTarget:bilateralFilter];
  
    
    // 美白滤镜
    GPUImageBrightnessFilter *brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
    [groupFilter addTarget:brightnessFilter];
  
    
    // 设置滤镜组链
    [bilateralFilter addTarget:brightnessFilter];
    [groupFilter setInitialFilters:@[bilateralFilter]];
    groupFilter.terminalFilter = brightnessFilter;
    
    // 设置GPUImage响应链，从数据源 => 滤镜 => 最终界面效果
    [self.videoCamera addTarget:groupFilter];
    [groupFilter addTarget:self.gpuImageView];
    
    // 必须调用startCameraCapture，底层才会把采集到的视频源，渲染到GPUImageView中，就能显示了。
    // 开始采集视频
    [self.videoCamera startCameraCapture];
    
    //按钮
    UIButton *leftB =[UIButton buttonWithType:(UIButtonTypeCustom)];
    leftB.frame = CGRectMake(10, IJSGStatusBarHeight, 70, 30);
    [leftB setTitle:@"取消" forState:UIControlStateNormal];
    [self.view addSubview:leftB];
    [leftB addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightB = [UIButton buttonWithType:UIButtonTypeCustom];
    rightB.frame = CGRectMake(IJSGScreenWidth - 80, IJSGStatusBarHeight, 70, 30);
    [rightB setTitle:@"完成" forState:UIControlStateNormal];
    [self.view addSubview:rightB];
    [rightB addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];

    // 切换摄像头
    UIButton *switchB =[UIButton buttonWithType:(UIButtonTypeCustom)];
    switchB.frame = CGRectMake(IJSGScreenWidth / 2 - 50, IJSGStatusBarHeight, 100, 30);
    [switchB setTitle:@"切换摄像头" forState:UIControlStateNormal];
    [self.view addSubview:switchB];
    [switchB addTarget:self action:@selector(switchBAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 加载工具条
    // 工具条
    IJSGToolsView *toolsView = [[IJSGToolsView alloc]initWithFrame: CGRectMake(0, IJSGScreenHeight - IJSGTabbarSafeBottomMargin - IJSGToolsViewHeight, IJSGScreenWidth, IJSGToolsViewHeight)];
    [self.view addSubview:toolsView];
    self.toolsView = toolsView;
    
    // 原图
    UIButton *imageBt =[UIButton buttonWithType:(UIButtonTypeCustom)];
    imageBt.frame = CGRectMake(IJSGScreenWidth - IJSGScreenWidth / 7 , 0, IJSGScreenWidth / 7, CGRectGetHeight(toolsView.frame));
    [imageBt setTitle:@"清空" forState:UIControlStateNormal];
    imageBt.backgroundColor =[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    [toolsView addSubview:imageBt];
    [imageBt addTarget:self action:@selector(originalImageAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    // 滑条
    // UISlite
    UISlider *filterSettingsSlider = [[UISlider alloc]initWithFrame:CGRectMake(20,  IJSGScreenHeight - IJSGTabbarSafeBottomMargin - IJSGToolsViewHeight - IJSGToolsViewHeight, IJSGScreenWidth - 40, 40)];
    [filterSettingsSlider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:filterSettingsSlider];
    self.filterSettingsSlider = filterSettingsSlider;
    
}
#pragma mark block 回调按钮
-(void)blockCallBackAction
{
    self.toolsView.didSelectedCallBack = ^(NSInteger index) {
        
        
        
    };
  
}

#pragma mark 按钮事件
-(void)cancelAction:(UIButton *)button
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)finishAction:(UIButton *)button
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

// 原图
-(void)originalImageAction:(UIButton *)button
{
    
}
//切换摄像头
-(void)switchBAction:(UIButton *)button
{
    if (button.selected)
    {
      
    }
    else
    {
      
    }
    AVCaptureDevice *inputCamera = self.videoCamera.inputCamera;
    inputCamera.position = AVCaptureDevicePositionBack;
    
    button.selected = !button.selected;
}
// 滑条
-(void)sliderAction:(UISlider *)slider
{
    
}

// 获取对应位置的摄像头对象
- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices)
    {
        if (device.position == position)
        {
            return device;
        }
    }
    return nil;
}

// 当前捕捉会话对应的摄像头
- (AVCaptureDevice *)activeCamera
{
    return self.activeVideoInput.device;
}

// 当前未激活的摄像头
- (AVCaptureDevice *)inactiveCamera
{
    AVCaptureDevice *device = nil;
    if (self.cameraCount > 1)
    {
        if ([self activeCamera].position == AVCaptureDevicePositionBack)
        {
            device = [self cameraWithPosition:AVCaptureDevicePositionFront];
        }
        else
        {
            device = [self cameraWithPosition:AVCaptureDevicePositionBack];
        }
    }
    return device;
}

// 是否有多个摄像头可以切换
- (BOOL)canSwitchCameras
{
    return self.cameraCount > 1;
}

- (NSUInteger)cameraCount
{
    // 返回可用摄像头的数组的个数
    return [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] count];
}

// 切换摄像头
- (BOOL)switchCameras
{
    //1. 判断是否可以切换
    if (![self canSwitchCameras])
    {
        return NO;
    }
    //2. 获取当前未使用的摄像头,并为他创建一个新的Input.
    NSError *error;
    AVCaptureDevice *videoDevice = [self inactiveCamera];

    AVCaptureDeviceInput *videoInput =
    [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];

    //3. 用新的Input替换掉正在激活的Input
    if (videoInput)
    {
        // 原子性配置开始.保证线程安全
        [self.captureSession beginConfiguration];
        // 移除当前摄像头的Input
        [self.captureSession removeInput:self.activeVideoInput];
        // 判断是否可以添加,添加新的Input
        if ([self.captureSession canAddInput:videoInput])
        {
            [self.captureSession addInput:videoInput];
            self.activeVideoInput = videoInput;
        }
        else
        {
            [self.captureSession addInput:self.activeVideoInput];
        }
        // 原子性配置完成
        [self.captureSession commitConfiguration];
    }
    else
    { // 错误处理
        [self.delegate deviceConfigurationFailedWithError:error];
        return NO;
    }

    return YES;
}





































- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}


@end
