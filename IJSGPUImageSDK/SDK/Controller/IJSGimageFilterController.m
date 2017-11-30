//
//  IJSGimageFilterController.m
//  IJSGPUImageSDK
//
//  Created by 山神 on 2017/11/8.
//  Copyright © 2017年 山神. All rights reserved.
//

#import "IJSGimageFilterController.h"
#import "IJSGToolsView.h"
#import "IJSGHeaderConst.h"
#import <GPUImage.h>
#import "IJSGSelectorController.h"

@interface IJSGimageFilterController () <GPUImageVideoCameraDelegate>
{
    IJSGPUImageShowcaseFilterType filterType;
    GPUImageFilterPipeline *pipeline;
    GPUImageUIElement *uiElementInput;
    UIView *faceView;
}
@property(nonatomic,weak) IJSGToolsView *toolsView;  // 工具条
@property(nonatomic,weak) UISlider *filterSettingsSlider;  // 滑条
@property(nonatomic,assign) IJSGSourceType sourceType;  // 资源的类型
@end

@implementation IJSGimageFilterController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.title = imageTitle;
    self.sourceType = ((IJSGSelectorController *)self.navigationController).sourceType;
    [self setupUI];
    [self didSelectedCallBack];
    [self setupFilter];   // 初始化滤镜
}
-(void)viewWillAppear:(BOOL)animated
{
    
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    
    
}

#pragma mark 导航条
- (void)setupUI
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:(UIBarButtonItemStylePlain) target:self action:@selector(cancelAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishAction)];
//    UINavigationBar * bar = self.navigationController.navigationBar;
//    bar.barTintColor = [UIColor clearColor];
    // 滚动视图
    UIScrollView * scrollV=[[UIScrollView alloc]initWithFrame:CGRectMake(0, IJSGStatusBarHeight, IJSGScreenWidth, IJSGScreenHeight - IJSGTabbarSafeBottomMargin - IJSGStatusBarAndNavigationBarHeight - IJSGToolsViewHeight)];
    scrollV.contentSize=CGSizeMake(IJSGScreenWidth, CGRectGetHeight(scrollV.frame));
    scrollV.pagingEnabled=YES;
    scrollV.bounces=NO;
    scrollV.showsHorizontalScrollIndicator=NO;
    scrollV.showsVerticalScrollIndicator=NO;
    scrollV.contentOffset=CGPointMake(0,0);
    [self.view addSubview:scrollV];
    
    if (self.sourceType == IJSGSourceTypeCamera)
    {
        scrollV.frame = [UIScreen mainScreen].bounds;
    }
    
    // 工具条
    IJSGToolsView *toolsView = [[IJSGToolsView alloc]initWithFrame: CGRectMake(0, IJSGScreenHeight - IJSGTabbarSafeBottomMargin - IJSGToolsViewHeight, IJSGScreenWidth, IJSGToolsViewHeight)];
    [self.view addSubview:toolsView];
    self.toolsView = toolsView;
    
    // UIImage
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:scrollV.bounds];
    imageV.image = self.image;
    [scrollV addSubview:imageV];
    
    // UISlite
    UISlider *filterSettingsSlider = [[UISlider alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(scrollV.frame) - 40, IJSGScreenWidth - 40, 40)];
    [filterSettingsSlider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:filterSettingsSlider];
    self.filterSettingsSlider = filterSettingsSlider;

    // GPUImage 渲染-----
    GPUImageView *gpuimageV = [[GPUImageView alloc]initWithFrame:scrollV.frame];
    [self.view addSubview:gpuimageV];
    self.gpuImageView = gpuimageV;
    
    // 原图
    UIButton *imageBt =[UIButton buttonWithType:(UIButtonTypeCustom)];
    imageBt.frame = CGRectMake(IJSGScreenWidth - IJSGScreenWidth / 7 , 0, IJSGScreenWidth / 7, CGRectGetHeight(toolsView.frame));
    [imageBt setTitle:@"原图" forState:UIControlStateNormal];
    imageBt.backgroundColor =[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1];
    [toolsView addSubview:imageBt];
    [imageBt addTarget:self action:@selector(originalImageAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.view bringSubviewToFront:filterSettingsSlider];
}

// 滑条
-(void)sliderAction:(UISlider *)slider
{
    ((GPUImageSaturationFilter *)self.filter).saturation = slider.value;
    [self.gpuPicture processImage];
}
#pragma mark 回调
-(void)didSelectedCallBack
{
    self.toolsView.didSelectedCallBack = ^(NSInteger index) {
        switch (index)
        {
            case GPUIMAGE_SATURATION:
                filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_CONTRAST:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_BRIGHTNESS:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_LEVELS:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_EXPOSURE:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_RGB:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_HUE:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_WHITEBALANCE:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_MONOCHROME:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_FALSECOLOR:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_SHARPEN:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_UNSHARPMASK:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_GAMMA:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_TONECURVE:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_HIGHLIGHTSHADOW:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_HAZE:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_CHROMAKEYNONBLEND:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_HISTOGRAM:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_HISTOGRAM_EQUALIZATION:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_AVERAGECOLOR:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_LUMINOSITY:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_THRESHOLD:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_ADAPTIVETHRESHOLD:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_AVERAGELUMINANCETHRESHOLD:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_CROP:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_TRANSFORM:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_TRANSFORM3D:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_MASK:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_COLORINVERT:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_GRAYSCALE:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_SEPIA:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_MISSETIKATE:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_SOFTELEGANCE:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_AMATORKA:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_PIXELLATE:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_POLARPIXELLATE:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_PIXELLATE_POSITION:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_POLKADOT:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_HALFTONE:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_CROSSHATCH:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_SOBELEDGEDETECTION:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_PREWITTEDGEDETECTION:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_CANNYEDGEDETECTION:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_THRESHOLDEDGEDETECTION:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_XYGRADIENT:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_HARRISCORNERDETECTION:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_NOBLECORNERDETECTION:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_SHITOMASIFEATUREDETECTION:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_HOUGHTRANSFORMLINEDETECTOR:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_BUFFER:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_MOTIONDETECTOR:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_LOWPASS:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_HIGHPASS:
                filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_SKETCH:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_THRESHOLDSKETCH:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_TOON:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_SMOOTHTOON:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_TILTSHIFT:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_CGA:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_CONVOLUTION:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_EMBOSS:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_LAPLACIAN:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_POSTERIZE:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_SWIRL:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_BULGE:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_SPHEREREFRACTION:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_GLASSSPHERE:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_PINCH:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_STRETCH:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_DILATION:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_EROSION:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_OPENING:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_CLOSING:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_PERLINNOISE:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_VORONOI:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_MOSAIC:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_LOCALBINARYPATTERN:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_CHROMAKEY:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_DISSOLVE:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_SCREENBLEND:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_COLORBURN:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_COLORDODGE:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_LINEARBURN:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_ADD:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_DIVIDE:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_MULTIPLY:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_OVERLAY:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_LIGHTEN:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_DARKEN:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_EXCLUSIONBLEND:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_DIFFERENCEBLEND:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_SUBTRACTBLEND:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_HARDLIGHTBLEND:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_SOFTLIGHTBLEND:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_COLORBLEND:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_HUEBLEND:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_SATURATIONBLEND:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_LUMINOSITYBLEND:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_NORMALBLEND:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_POISSONBLEND:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_OPACITY:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_KUWAHARA:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_KUWAHARARADIUS3:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_VIGNETTE:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_GAUSSIAN:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_MEDIAN:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_BILATERAL:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_MOTIONBLUR:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_ZOOMBLUR:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_BOXBLUR:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_GAUSSIAN_SELECTIVE:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_GAUSSIAN_POSITION:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_IOSBLUR:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_UIELEMENT:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_CUSTOM:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_FILECONFIG:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_FILTERGROUP:
                 filterType = GPUIMAGE_SATURATION;
                break;
            case GPUIMAGE_FACES:
                 filterType = GPUIMAGE_SATURATION;
                break;
        }
    };
}
#pragma mark 按钮事件区域
// 原图
-(void)originalImageAction:(UIButton *)button
{
    
    
}

-(void)cancelAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)finishAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 初始化滤镜失败
- (void)setupFilter
{
    if(self.sourceType ==IJSGSourceTypeImage)
    {
        self.gpuPicture = [[GPUImagePicture alloc] initWithImage:self.image];
    }
    else if(self.sourceType == IJSGSourceTypeVideo)
    {
    
    }
    else if (self.sourceType == IJSGSourceTypeCamera)
    {
        self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset1280x720 cameraPosition:AVCaptureDevicePositionBack];
        self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    }
    else if (self.sourceType == IJSGSourceTypePhoto)
    {
        
    }

    BOOL needsSecondImage = NO;
    
    switch (filterType)
    {
        case GPUIMAGE_SEPIA:
        {
            self.title = @"Sepia Tone";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:1.0];
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            
            self.filter = [[GPUImageSepiaFilter alloc] init];
        }; break;
        case GPUIMAGE_PIXELLATE:
        {
            self.title = @"Pixellate";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:0.05];
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:0.3];
            
            self.filter = [[GPUImagePixellateFilter alloc] init];
        }; break;
        case GPUIMAGE_POLARPIXELLATE:
        {
            self.title = @"Polar Pixellate";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:0.05];
            [self.filterSettingsSlider setMinimumValue:-0.1];
            [self.filterSettingsSlider setMaximumValue:0.1];
            
            self.filter = [[GPUImagePolarPixellateFilter alloc] init];
        }; break;
        case GPUIMAGE_PIXELLATE_POSITION:
        {
            self.title = @"Pixellate (position)";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:0.25];
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:0.5];
            
            self.filter = [[GPUImagePixellatePositionFilter alloc] init];
        }; break;
        case GPUIMAGE_POLKADOT:
        {
            self.title = @"Polka Dot";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:0.05];
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:0.3];
            
            self.filter = [[GPUImagePolkaDotFilter alloc] init];
        }; break;
        case GPUIMAGE_HALFTONE:
        {
            self.title = @"Halftone";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:0.01];
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:0.05];
            
            self.filter = [[GPUImageHalftoneFilter alloc] init];
        }; break;
        case GPUIMAGE_CROSSHATCH:
        {
            self.title = @"Crosshatch";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:0.03];
            [self.filterSettingsSlider setMinimumValue:0.01];
            [self.filterSettingsSlider setMaximumValue:0.06];
            
            self.filter = [[GPUImageCrosshatchFilter alloc] init];
        }; break;
        case GPUIMAGE_COLORINVERT:
        {
            self.title = @"Color Invert";
            self.filterSettingsSlider.hidden = YES;
            
            self.filter = [[GPUImageColorInvertFilter alloc] init];
        }; break;
        case GPUIMAGE_GRAYSCALE:
        {
            self.title = @"Grayscale";
            self.filterSettingsSlider.hidden = YES;
            
            self.filter = [[GPUImageGrayscaleFilter alloc] init];
        }; break;
        case GPUIMAGE_MONOCHROME:
        {
            self.title = @"Monochrome";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:1.0];
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            
            self.filter = [[GPUImageMonochromeFilter alloc] init];
            [(GPUImageMonochromeFilter *)self.filter setColor:(GPUVector4){0.0f, 0.0f, 1.0f, 1.f}];
        }; break;
        case GPUIMAGE_FALSECOLOR:
        {
            self.title = @"False Color";
            self.filterSettingsSlider.hidden = YES;
            
            self.filter = [[GPUImageFalseColorFilter alloc] init];
        }; break;
        case GPUIMAGE_SOFTELEGANCE:
        {
            self.title = @"Soft Elegance (Lookup)";
            self.filterSettingsSlider.hidden = YES;
            
            self.filter = [[GPUImageSoftEleganceFilter alloc] init];
        }; break;
        case GPUIMAGE_MISSETIKATE:
        {
            self.title = @"Miss Etikate (Lookup)";
            self.filterSettingsSlider.hidden = YES;
            
            self.filter = [[GPUImageMissEtikateFilter alloc] init];
        }; break;
        case GPUIMAGE_AMATORKA:
        {
            self.title = @"Amatorka (Lookup)";
            self.filterSettingsSlider.hidden = YES;
            
            self.filter = [[GPUImageAmatorkaFilter alloc] init];
        }; break;
            
        case GPUIMAGE_SATURATION:
        {
            self.title = @"Saturation";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:1.0];
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:2.0];
            
            self.filter = [[GPUImageSaturationFilter alloc] init];
        }; break;
        case GPUIMAGE_CONTRAST:
        {
            self.title = @"Contrast";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:4.0];
            [self.filterSettingsSlider setValue:1.0];
            
            self.filter = [[GPUImageContrastFilter alloc] init];
        }; break;
        case GPUIMAGE_BRIGHTNESS:
        {
            self.title = @"Brightness";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:-1.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.0];
            
            self.filter = [[GPUImageBrightnessFilter alloc] init];
        }; break;
        case GPUIMAGE_LEVELS:
        {
            self.title = @"Levels";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.0];
            
            self.filter = [[GPUImageLevelsFilter alloc] init];
        }; break;
        case GPUIMAGE_RGB:
        {
            self.title = @"RGB";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:2.0];
            [self.filterSettingsSlider setValue:1.0];
            
            self.filter = [[GPUImageRGBFilter alloc] init];
        }; break;
        case GPUIMAGE_HUE:
        {
            self.title = @"Hue";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:360.0];
            [self.filterSettingsSlider setValue:90.0];
            
            self.filter = [[GPUImageHueFilter alloc] init];
        }; break;
        case GPUIMAGE_WHITEBALANCE:
        {
            self.title = @"White Balance";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:2500.0];
            [self.filterSettingsSlider setMaximumValue:7500.0];
            [self.filterSettingsSlider setValue:5000.0];
            
            self.filter = [[GPUImageWhiteBalanceFilter alloc] init];
        }; break;
        case GPUIMAGE_EXPOSURE:
        {
            self.title = @"Exposure";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:-4.0];
            [self.filterSettingsSlider setMaximumValue:4.0];
            [self.filterSettingsSlider setValue:0.0];
            
            self.filter = [[GPUImageExposureFilter alloc] init];
        }; break;
        case GPUIMAGE_SHARPEN:
        {
            self.title = @"Sharpen";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:-1.0];
            [self.filterSettingsSlider setMaximumValue:4.0];
            [self.filterSettingsSlider setValue:0.0];
            
            self.filter = [[GPUImageSharpenFilter alloc] init];
        }; break;
        case GPUIMAGE_UNSHARPMASK:
        {
            self.title = @"Unsharp Mask";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:5.0];
            [self.filterSettingsSlider setValue:1.0];
            
            self.filter = [[GPUImageUnsharpMaskFilter alloc] init];
    
            [(GPUImageUnsharpMaskFilter *)self.filter setIntensity:3.0];
        }; break;
        case GPUIMAGE_GAMMA:
        {
            self.title = @"Gamma";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:3.0];
            [self.filterSettingsSlider setValue:1.0];
            
            self.filter = [[GPUImageGammaFilter alloc] init];
        }; break;
        case GPUIMAGE_TONECURVE:
        {
            self.title = @"Tone curve";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.5];
            
            self.filter = [[GPUImageToneCurveFilter alloc] init];
            [(GPUImageToneCurveFilter *)self.filter setBlueControlPoints:[NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(0.0, 0.0)], [NSValue valueWithCGPoint:CGPointMake(0.5, 0.5)], [NSValue valueWithCGPoint:CGPointMake(1.0, 0.75)], nil]];
        }; break;
        case GPUIMAGE_HIGHLIGHTSHADOW:
        {
            self.title = @"Highlights and Shadows";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:1.0];
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            
            self.filter = [[GPUImageHighlightShadowFilter alloc] init];
        }; break;
        case GPUIMAGE_HAZE:
        {
            self.title = @"Haze / UV";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:-0.2];
            [self.filterSettingsSlider setMaximumValue:0.2];
            [self.filterSettingsSlider setValue:0.2];
            
            self.filter = [[GPUImageHazeFilter alloc] init];
        }; break;
        case GPUIMAGE_AVERAGECOLOR:
        {
            self.title = @"Average Color";
            self.filterSettingsSlider.hidden = YES;
            
            self.filter = [[GPUImageAverageColor alloc] init];
        }; break;
        case GPUIMAGE_LUMINOSITY:
        {
            self.title = @"Luminosity";
            self.filterSettingsSlider.hidden = YES;
            
            self.filter = [[GPUImageLuminosity alloc] init];
        }; break;
        case GPUIMAGE_HISTOGRAM:
        {
            self.title = @"Histogram";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:4.0];
            [self.filterSettingsSlider setMaximumValue:32.0];
            [self.filterSettingsSlider setValue:16.0];
            
            self.filter = [[GPUImageHistogramFilter alloc] initWithHistogramType:kGPUImageHistogramRGB];
        }; break;
        case GPUIMAGE_HISTOGRAM_EQUALIZATION:
        {
            self.title = @"Histogram Equalization";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:4.0];
            [self.filterSettingsSlider setMaximumValue:32.0];
            [self.filterSettingsSlider setValue:16.0];
            
            self.filter = [[GPUImageHistogramEqualizationFilter alloc] initWithHistogramType:kGPUImageHistogramLuminance];
        }; break;
        case GPUIMAGE_THRESHOLD:
        {
            self.title = @"Luminance Threshold";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.5];
            
            self.filter = [[GPUImageLuminanceThresholdFilter alloc] init];
        }; break;
        case GPUIMAGE_ADAPTIVETHRESHOLD:
        {
            self.title = @"Adaptive Threshold";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:1.0];
            [self.filterSettingsSlider setMaximumValue:20.0];
            [self.filterSettingsSlider setValue:1.0];
            
            self.filter = [[GPUImageAdaptiveThresholdFilter alloc] init];
        }; break;
        case GPUIMAGE_AVERAGELUMINANCETHRESHOLD:
        {
            self.title = @"Avg. Lum. Threshold";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:2.0];
            [self.filterSettingsSlider setValue:1.0];
            
            self.filter = [[GPUImageAverageLuminanceThresholdFilter alloc] init];
        }; break;
        case GPUIMAGE_CROP:
        {
            self.title = @"Crop";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.2];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.5];
            
            self.filter = [[GPUImageCropFilter alloc] initWithCropRegion:CGRectMake(0.0, 0.0, 1.0, 0.25)];
        }; break;
        case GPUIMAGE_MASK:
        {
            self.title = @"Mask";
            self.filterSettingsSlider.hidden = YES;
            needsSecondImage = YES;
            
            self.filter = [[GPUImageMaskFilter alloc] init];
            
            [(GPUImageFilter*)self.filter setBackgroundColorRed:0.0 green:1.0 blue:0.0 alpha:1.0];
        }; break;
        case GPUIMAGE_TRANSFORM:
        {
            self.title = @"Transform (2-D)";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:6.28];
            [self.filterSettingsSlider setValue:2.0];
            
            self.filter = [[GPUImageTransformFilter alloc] init];
            [(GPUImageTransformFilter *)self.filter setAffineTransform:CGAffineTransformMakeRotation(2.0)];
            [(GPUImageTransformFilter *)self.filter setIgnoreAspectRatio:YES];
        }; break;
        case GPUIMAGE_TRANSFORM3D:
        {
            self.title = @"Transform (3-D)";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:6.28];
            [self.filterSettingsSlider setValue:0.75];
            
            self.filter = [[GPUImageTransformFilter alloc] init];
            CATransform3D perspectiveTransform = CATransform3DIdentity;
            perspectiveTransform.m34 = 0.4;
            perspectiveTransform.m33 = 0.4;
            perspectiveTransform = CATransform3DScale(perspectiveTransform, 0.75, 0.75, 0.75);
            perspectiveTransform = CATransform3DRotate(perspectiveTransform, 0.75, 0.0, 1.0, 0.0);
            
            [(GPUImageTransformFilter *)self.filter setTransform3D:perspectiveTransform];
        }; break;
        case GPUIMAGE_SOBELEDGEDETECTION:
        {
            self.title = @"Sobel Edge Detection";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.25];
            
            self.filter = [[GPUImageSobelEdgeDetectionFilter alloc] init];
        }; break;
        case GPUIMAGE_XYGRADIENT:
        {
            self.title = @"XY Derivative";
            self.filterSettingsSlider.hidden = YES;
            
            self.filter = [[GPUImageXYDerivativeFilter alloc] init];
        }; break;
        case GPUIMAGE_HARRISCORNERDETECTION:
        {
            self.title = @"Harris Corner Detection";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.01];
            [self.filterSettingsSlider setMaximumValue:0.70];
            [self.filterSettingsSlider setValue:0.20];
            
            self.filter = [[GPUImageHarrisCornerDetectionFilter alloc] init];
            [(GPUImageHarrisCornerDetectionFilter *)self.filter setThreshold:0.20];
        }; break;
        case GPUIMAGE_NOBLECORNERDETECTION:
        {
            self.title = @"Noble Corner Detection";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.01];
            [self.filterSettingsSlider setMaximumValue:0.70];
            [self.filterSettingsSlider setValue:0.20];
            
            self.filter = [[GPUImageNobleCornerDetectionFilter alloc] init];
            [(GPUImageNobleCornerDetectionFilter *)self.filter setThreshold:0.20];
        }; break;
        case GPUIMAGE_SHITOMASIFEATUREDETECTION:
        {
            self.title = @"Shi-Tomasi Feature Detection";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.01];
            [self.filterSettingsSlider setMaximumValue:0.70];
            [self.filterSettingsSlider setValue:0.20];
            
            self.filter = [[GPUImageShiTomasiFeatureDetectionFilter alloc] init];
            [(GPUImageShiTomasiFeatureDetectionFilter *)self.filter setThreshold:0.20];
        }; break;
        case GPUIMAGE_HOUGHTRANSFORMLINEDETECTOR:
        {
            self.title = @"Line Detection";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.2];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.6];
            
            self.filter = [[GPUImageHoughTransformLineDetector alloc] init];
            [(GPUImageHoughTransformLineDetector *)self.filter setLineDetectionThreshold:0.60];
        }; break;
            
        case GPUIMAGE_PREWITTEDGEDETECTION:
        {
            self.title = @"Prewitt Edge Detection";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:1.0];
            
            self.filter = [[GPUImagePrewittEdgeDetectionFilter alloc] init];
        }; break;
        case GPUIMAGE_CANNYEDGEDETECTION:
        {
            self.title = @"Canny Edge Detection";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:1.0];
            
            self.filter = [[GPUImageCannyEdgeDetectionFilter alloc] init];
        }; break;
        case GPUIMAGE_THRESHOLDEDGEDETECTION:
        {
            self.title = @"Threshold Edge Detection";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.25];
            
            self.filter = [[GPUImageThresholdEdgeDetectionFilter alloc] init];
        }; break;
        case GPUIMAGE_LOCALBINARYPATTERN:
        {
            self.title = @"Local Binary Pattern";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:1.0];
            [self.filterSettingsSlider setMaximumValue:5.0];
            [self.filterSettingsSlider setValue:1.0];
            
            self.filter = [[GPUImageLocalBinaryPatternFilter alloc] init];
        }; break;
        case GPUIMAGE_BUFFER:
        {
            self.title = @"Image Buffer";
            self.filterSettingsSlider.hidden = YES;
            
            self.filter = [[GPUImageBuffer alloc] init];
        }; break;
        case GPUIMAGE_LOWPASS:
        {
            self.title = @"Low Pass";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.5];
            
            self.filter = [[GPUImageLowPassFilter alloc] init];
        }; break;
        case GPUIMAGE_HIGHPASS:
        {
            self.title = @"High Pass";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.5];
            
            self.filter = [[GPUImageHighPassFilter alloc] init];
        }; break;
        case GPUIMAGE_MOTIONDETECTOR:
        {
            [self.videoCamera rotateCamera];
            
            self.title = @"Motion Detector";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.5];
            
            self.filter = [[GPUImageMotionDetector alloc] init];
        }; break;
        case GPUIMAGE_SKETCH:
        {
            self.title = @"Sketch";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.25];
            
            self.filter = [[GPUImageSketchFilter alloc] init];
        }; break;
        case GPUIMAGE_THRESHOLDSKETCH:
        {
            self.title = @"Threshold Sketch";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.25];
            
            self.filter = [[GPUImageThresholdSketchFilter alloc] init];
        }; break;
        case GPUIMAGE_TOON:
        {
            self.title = @"Toon";
            self.filterSettingsSlider.hidden = YES;
            
            self.filter = [[GPUImageToonFilter alloc] init];
        }; break;
        case GPUIMAGE_SMOOTHTOON:
        {
            self.title = @"Smooth Toon";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:1.0];
            [self.filterSettingsSlider setMaximumValue:6.0];
            [self.filterSettingsSlider setValue:1.0];
            
            self.filter = [[GPUImageSmoothToonFilter alloc] init];
        }; break;
        case GPUIMAGE_TILTSHIFT:
        {
            self.title = @"Tilt Shift";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.2];
            [self.filterSettingsSlider setMaximumValue:0.8];
            [self.filterSettingsSlider setValue:0.5];
            
            self.filter = [[GPUImageTiltShiftFilter alloc] init];
            [(GPUImageTiltShiftFilter *)self.filter setTopFocusLevel:0.4];
            [(GPUImageTiltShiftFilter *)self.filter setBottomFocusLevel:0.6];
            [(GPUImageTiltShiftFilter *)self.filter setFocusFallOffRate:0.2];
        }; break;
        case GPUIMAGE_CGA:
        {
            self.title = @"CGA Colorspace";
            self.filterSettingsSlider.hidden = YES;
            
            self.filter = [[GPUImageCGAColorspaceFilter alloc] init];
        }; break;
        case GPUIMAGE_CONVOLUTION:
        {
            self.title = @"3x3 Convolution";
            self.filterSettingsSlider.hidden = YES;
            
            self.filter = [[GPUImage3x3ConvolutionFilter alloc] init];
            //            [(GPUImage3x3ConvolutionFilter *)filter setConvolutionKernel:(GPUMatrix3x3){
            //                {-2.0f, -1.0f, 0.0f},
            //                {-1.0f,  1.0f, 1.0f},
            //                { 0.0f,  1.0f, 2.0f}
            //            }];
            [(GPUImage3x3ConvolutionFilter *)self.filter setConvolutionKernel:(GPUMatrix3x3){
                {-1.0f,  0.0f, 1.0f},
                {-2.0f, 0.0f, 2.0f},
                {-1.0f,  0.0f, 1.0f}
            }];
            
            //            [(GPUImage3x3ConvolutionFilter *)filter setConvolutionKernel:(GPUMatrix3x3){
            //                {1.0f,  1.0f, 1.0f},
            //                {1.0f, -8.0f, 1.0f},
            //                {1.0f,  1.0f, 1.0f}
            //            }];
            //            [(GPUImage3x3ConvolutionFilter *)filter setConvolutionKernel:(GPUMatrix3x3){
            //                { 0.11f,  0.11f, 0.11f},
            //                { 0.11f,  0.11f, 0.11f},
            //                { 0.11f,  0.11f, 0.11f}
            //            }];
        }; break;
        case GPUIMAGE_EMBOSS:
        {
            self.title = @"Emboss";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:5.0];
            [self.filterSettingsSlider setValue:1.0];
            
            self.filter = [[GPUImageEmbossFilter alloc] init];
        }; break;
        case GPUIMAGE_LAPLACIAN:
        {
            self.title = @"Laplacian";
            self.filterSettingsSlider.hidden = YES;
            
            self.filter = [[GPUImageLaplacianFilter alloc] init];
        }; break;
        case GPUIMAGE_POSTERIZE:
        {
            self.title = @"Posterize";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:1.0];
            [self.filterSettingsSlider setMaximumValue:20.0];
            [self.filterSettingsSlider setValue:10.0];
            
            self.filter = [[GPUImagePosterizeFilter alloc] init];
        }; break;
        case GPUIMAGE_SWIRL:
        {
            self.title = @"Swirl";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:2.0];
            [self.filterSettingsSlider setValue:1.0];
            
            self.filter = [[GPUImageSwirlFilter alloc] init];
        }; break;
        case GPUIMAGE_BULGE:
        {
            self.title = @"Bulge";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:-1.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.5];
            
            self.filter = [[GPUImageBulgeDistortionFilter alloc] init];
        }; break;
        case GPUIMAGE_SPHEREREFRACTION:
        {
            self.title = @"Sphere Refraction";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.15];
            
            self.filter = [[GPUImageSphereRefractionFilter alloc] init];
            [(GPUImageSphereRefractionFilter *)self.filter setRadius:0.15];
        }; break;
        case GPUIMAGE_GLASSSPHERE:
        {
            self.title = @"Glass Sphere";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.15];
            
            self.filter = [[GPUImageGlassSphereFilter alloc] init];
            [(GPUImageGlassSphereFilter *)self.filter setRadius:0.15];
        }; break;
        case GPUIMAGE_PINCH:
        {
            self.title = @"Pinch";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:-2.0];
            [self.filterSettingsSlider setMaximumValue:2.0];
            [self.filterSettingsSlider setValue:0.5];
            
            self.filter = [[GPUImagePinchDistortionFilter alloc] init];
        }; break;
        case GPUIMAGE_STRETCH:
        {
            self.title = @"Stretch";
            self.filterSettingsSlider.hidden = YES;
            
            self.filter = [[GPUImageStretchDistortionFilter alloc] init];
        }; break;
        case GPUIMAGE_DILATION:
        {
            self.title = @"Dilation";
            self.filterSettingsSlider.hidden = YES;
            
            self.filter = [[GPUImageRGBDilationFilter alloc] initWithRadius:4];
        }; break;
        case GPUIMAGE_EROSION:
        {
            self.title = @"Erosion";
            self.filterSettingsSlider.hidden = YES;
            
            self.filter = [[GPUImageRGBErosionFilter alloc] initWithRadius:4];
        }; break;
        case GPUIMAGE_OPENING:
        {
            self.title = @"Opening";
            self.filterSettingsSlider.hidden = YES;
            
            self.filter = [[GPUImageRGBOpeningFilter alloc] initWithRadius:4];
        }; break;
        case GPUIMAGE_CLOSING:
        {
            self.title = @"Closing";
            self.filterSettingsSlider.hidden = YES;
            
            self.filter = [[GPUImageRGBClosingFilter alloc] initWithRadius:4];
        }; break;
            
        case GPUIMAGE_PERLINNOISE:
        {
            self.title = @"Perlin Noise";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:1.0];
            [self.filterSettingsSlider setMaximumValue:30.0];
            [self.filterSettingsSlider setValue:8.0];
            
            self.filter = [[GPUImagePerlinNoiseFilter alloc] init];
        }; break;
        case GPUIMAGE_VORONOI:
        {
            self.title = @"Voronoi";
            self.filterSettingsSlider.hidden = YES;
            needsSecondImage = YES;
            
            GPUImageJFAVoronoiFilter *jfa = [[GPUImageJFAVoronoiFilter alloc] init];
            [jfa setSizeInPixels:CGSizeMake(1024.0, 1024.0)];
            
            self.gpuPicture = [[GPUImagePicture alloc] initWithImage:[UIImage imageNamed:@"voroni_points2.png"]];
            
            [self.gpuPicture addTarget:jfa];
            
            self.filter = [[GPUImageVoronoiConsumerFilter alloc] init];
            
            [jfa setSizeInPixels:CGSizeMake(1024.0, 1024.0)];
            [(GPUImageVoronoiConsumerFilter *)self.filter setSizeInPixels:CGSizeMake(1024.0, 1024.0)];
            
            [self.videoCamera addTarget:self.filter];
            [jfa addTarget:self.filter];
            [self.gpuPicture processImage];
        }; break;
        case GPUIMAGE_MOSAIC:
        {
            self.title = @"Mosaic";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.002];
            [self.filterSettingsSlider setMaximumValue:0.05];
            [self.filterSettingsSlider setValue:0.025];
            
            self.filter = [[GPUImageMosaicFilter alloc] init];
            [(GPUImageMosaicFilter *)self.filter setTileSet:@"squares.png"];
            [(GPUImageMosaicFilter *)self.filter setColorOn:NO];
            [(GPUImageMosaicFilter *)self.filter setTileSet:@"dotletterstiles.png"];
            [(GPUImageMosaicFilter *)self.filter setTileSet:@"curvies.png"];
            
        }; break;
        case GPUIMAGE_CHROMAKEY:
        {
            self.title = @"Chroma Key (Green)";
            self.filterSettingsSlider.hidden = NO;
            needsSecondImage = YES;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.4];
            
            self.filter = [[GPUImageChromaKeyBlendFilter alloc] init];
            [(GPUImageChromaKeyBlendFilter *)self.filter setColorToReplaceRed:0.0 green:1.0 blue:0.0];
        }; break;
        case GPUIMAGE_CHROMAKEYNONBLEND:
        {
            self.title = @"Chroma Key (Green)";
            self.filterSettingsSlider.hidden = NO;
            needsSecondImage = YES;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.4];
            
            self.filter = [[GPUImageChromaKeyFilter alloc] init];
            [(GPUImageChromaKeyFilter *)self.filter setColorToReplaceRed:0.0 green:1.0 blue:0.0];
        }; break;
        case GPUIMAGE_ADD:
        {
            self.title = @"Add Blend";
            self.filterSettingsSlider.hidden = YES;
            needsSecondImage = YES;
            
            self.filter = [[GPUImageAddBlendFilter alloc] init];
        }; break;
        case GPUIMAGE_DIVIDE:
        {
            self.title = @"Divide Blend";
            self.filterSettingsSlider.hidden = YES;
            needsSecondImage = YES;
            
            self.filter = [[GPUImageDivideBlendFilter alloc] init];
        }; break;
        case GPUIMAGE_MULTIPLY:
        {
            self.title = @"Multiply Blend";
            self.filterSettingsSlider.hidden = YES;
            needsSecondImage = YES;
            
            self.filter = [[GPUImageMultiplyBlendFilter alloc] init];
        }; break;
        case GPUIMAGE_OVERLAY:
        {
            self.title = @"Overlay Blend";
            self.filterSettingsSlider.hidden = YES;
            needsSecondImage = YES;
            
            self.filter = [[GPUImageOverlayBlendFilter alloc] init];
        }; break;
        case GPUIMAGE_LIGHTEN:
        {
            self.title = @"Lighten Blend";
            self.filterSettingsSlider.hidden = YES;
            needsSecondImage = YES;
            
            self.filter = [[GPUImageLightenBlendFilter alloc] init];
        }; break;
        case GPUIMAGE_DARKEN:
        {
            self.title = @"Darken Blend";
            self.filterSettingsSlider.hidden = YES;
            
            needsSecondImage = YES;
            self.filter = [[GPUImageDarkenBlendFilter alloc] init];
        }; break;
        case GPUIMAGE_DISSOLVE:
        {
            self.title = @"Dissolve Blend";
            self.filterSettingsSlider.hidden = NO;
            needsSecondImage = YES;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.5];
            
            self.filter = [[GPUImageDissolveBlendFilter alloc] init];
        }; break;
        case GPUIMAGE_SCREENBLEND:
        {
            self.title = @"Screen Blend";
            self.filterSettingsSlider.hidden = YES;
            needsSecondImage = YES;
            
            self.filter = [[GPUImageScreenBlendFilter alloc] init];
        }; break;
        case GPUIMAGE_COLORBURN:
        {
            self.title = @"Color Burn Blend";
            self.filterSettingsSlider.hidden = YES;
            needsSecondImage = YES;
            
            self.filter = [[GPUImageColorBurnBlendFilter alloc] init];
        }; break;
        case GPUIMAGE_COLORDODGE:
        {
            self.title = @"Color Dodge Blend";
            self.filterSettingsSlider.hidden = YES;
            needsSecondImage = YES;
            
            self.filter = [[GPUImageColorDodgeBlendFilter alloc] init];
        }; break;
        case GPUIMAGE_LINEARBURN:
        {
            self.title = @"Linear Burn Blend";
            self.filterSettingsSlider.hidden = YES;
            needsSecondImage = YES;
            
            self.filter = [[GPUImageLinearBurnBlendFilter alloc] init];
        }; break;
        case GPUIMAGE_EXCLUSIONBLEND:
        {
            self.title = @"Exclusion Blend";
            self.filterSettingsSlider.hidden = YES;
            needsSecondImage = YES;
            
            self.filter = [[GPUImageExclusionBlendFilter alloc] init];
        }; break;
        case GPUIMAGE_DIFFERENCEBLEND:
        {
            self.title = @"Difference Blend";
            self.filterSettingsSlider.hidden = YES;
            needsSecondImage = YES;
            
            self.filter = [[GPUImageDifferenceBlendFilter alloc] init];
        }; break;
        case GPUIMAGE_SUBTRACTBLEND:
        {
            self.title = @"Subtract Blend";
            self.filterSettingsSlider.hidden = YES;
            needsSecondImage = YES;
            
            self.filter = [[GPUImageSubtractBlendFilter alloc] init];
        }; break;
        case GPUIMAGE_HARDLIGHTBLEND:
        {
            self.title = @"Hard Light Blend";
            self.filterSettingsSlider.hidden = YES;
            needsSecondImage = YES;
            
            self.filter = [[GPUImageHardLightBlendFilter alloc] init];
        }; break;
        case GPUIMAGE_SOFTLIGHTBLEND:
        {
            self.title = @"Soft Light Blend";
            self.filterSettingsSlider.hidden = YES;
            needsSecondImage = YES;
            
            self.filter = [[GPUImageSoftLightBlendFilter alloc] init];
        }; break;
        case GPUIMAGE_COLORBLEND:
        {
            self.title = @"Color Blend";
            self.filterSettingsSlider.hidden = YES;
            needsSecondImage = YES;
            
            self.filter = [[GPUImageColorBlendFilter alloc] init];
        }; break;
        case GPUIMAGE_HUEBLEND:
        {
            self.title = @"Hue Blend";
            self.filterSettingsSlider.hidden = YES;
            needsSecondImage = YES;
            
            self.filter = [[GPUImageHueBlendFilter alloc] init];
        }; break;
        case GPUIMAGE_SATURATIONBLEND:
        {
            self.title = @"Saturation Blend";
            self.filterSettingsSlider.hidden = YES;
            needsSecondImage = YES;
            
            self.filter = [[GPUImageSaturationBlendFilter alloc] init];
        }; break;
        case GPUIMAGE_LUMINOSITYBLEND:
        {
            self.title = @"Luminosity Blend";
            self.filterSettingsSlider.hidden = YES;
            needsSecondImage = YES;
            
            self.filter = [[GPUImageLuminosityBlendFilter alloc] init];
        }; break;
        case GPUIMAGE_NORMALBLEND:
        {
            self.title = @"Normal Blend";
            self.filterSettingsSlider.hidden = YES;
            needsSecondImage = YES;
            
            self.filter = [[GPUImageNormalBlendFilter alloc] init];
        }; break;
        case GPUIMAGE_POISSONBLEND:
        {
            self.title = @"Poisson Blend";
            self.filterSettingsSlider.hidden = NO;
            needsSecondImage = YES;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            [self.filterSettingsSlider setValue:0.5];
            
            self.filter = [[GPUImagePoissonBlendFilter alloc] init];
        }; break;
        case GPUIMAGE_OPACITY:
        {
            self.title = @"Opacity Adjustment";
            self.filterSettingsSlider.hidden = NO;
            needsSecondImage = YES;
            
            [self.filterSettingsSlider setValue:1.0];
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:1.0];
            
            self.filter = [[GPUImageOpacityFilter alloc] init];
        }; break;
        case GPUIMAGE_CUSTOM:
        {
            self.title = @"Custom";
            self.filterSettingsSlider.hidden = YES;
            
            self.filter = [[GPUImageFilter alloc] initWithFragmentShaderFromFile:@"CustomFilter"];
        }; break;
        case GPUIMAGE_KUWAHARA:
        {
            self.title = @"Kuwahara";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:3.0];
            [self.filterSettingsSlider setMaximumValue:8.0];
            [self.filterSettingsSlider setValue:3.0];
            
            self.filter = [[GPUImageKuwaharaFilter alloc] init];
        }; break;
        case GPUIMAGE_KUWAHARARADIUS3:
        {
            self.title = @"Kuwahara (Radius 3)";
            self.filterSettingsSlider.hidden = YES;
            
            self.filter = [[GPUImageKuwaharaRadius3Filter alloc] init];
        }; break;
        case GPUIMAGE_VIGNETTE:
        {
            self.title = @"Vignette";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.5];
            [self.filterSettingsSlider setMaximumValue:0.9];
            [self.filterSettingsSlider setValue:0.75];
            
            self.filter = [[GPUImageVignetteFilter alloc] init];
        }; break;
        case GPUIMAGE_GAUSSIAN:
        {
            self.title = @"Gaussian Blur";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:24.0];
            [self.filterSettingsSlider setValue:2.0];
            
            self.filter = [[GPUImageGaussianBlurFilter alloc] init];
        }; break;
        case GPUIMAGE_BOXBLUR:
        {
            self.title = @"Box Blur";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:24.0];
            [self.filterSettingsSlider setValue:2.0];
            
            self.filter = [[GPUImageBoxBlurFilter alloc] init];
        }; break;
        case GPUIMAGE_MEDIAN:
        {
            self.title = @"Median";
            self.filterSettingsSlider.hidden = YES;
            
            self.filter = [[GPUImageMedianFilter alloc] init];
        }; break;
        case GPUIMAGE_MOTIONBLUR:
        {
            self.title = @"Motion Blur";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:180.0f];
            [self.filterSettingsSlider setValue:0.0];
            
            self.filter = [[GPUImageMotionBlurFilter alloc] init];
        }; break;
        case GPUIMAGE_ZOOMBLUR:
        {
            self.title = @"Zoom Blur";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:2.5f];
            [self.filterSettingsSlider setValue:1.0];
            
            self.filter = [[GPUImageZoomBlurFilter alloc] init];
        }; break;
        case GPUIMAGE_IOSBLUR:
        {
            self.title = @"iOS 7 Blur";
            self.filterSettingsSlider.hidden = YES;
            
            self.filter = [[GPUImageiOSBlurFilter alloc] init];
        }; break;
        case GPUIMAGE_UIELEMENT:
        {
            self.title = @"UI Element";
            self.filterSettingsSlider.hidden = YES;
            
            self.filter = [[GPUImageSepiaFilter alloc] init];
        }; break;
        case GPUIMAGE_GAUSSIAN_SELECTIVE:
        {
            self.title = @"Selective Blur";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:.75f];
            [self.filterSettingsSlider setValue:40.0/320.0];
            
            self.filter = [[GPUImageGaussianSelectiveBlurFilter alloc] init];
            [(GPUImageGaussianSelectiveBlurFilter*)self.filter setExcludeCircleRadius:40.0/320.0];
        }; break;
        case GPUIMAGE_GAUSSIAN_POSITION:
        {
            self.title = @"Selective Blur";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:.75f];
            [self.filterSettingsSlider setValue:40.0/320.0];
            
            self.filter = [[GPUImageGaussianBlurPositionFilter alloc] init];
            [(GPUImageGaussianBlurPositionFilter*)self.filter setBlurRadius:40.0/320.0];
        }; break;
        case GPUIMAGE_BILATERAL:
        {
            self.title = @"Bilateral Blur";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:10.0];
            [self.filterSettingsSlider setValue:1.0];
            
            self.filter = [[GPUImageBilateralFilter alloc] init];
        }; break;
        case GPUIMAGE_FILTERGROUP:
        {
            self.title = @"Filter Group";
            self.filterSettingsSlider.hidden = NO;
            
            [self.filterSettingsSlider setValue:0.05];
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:0.3];
            
            self.filter = [[GPUImageFilterGroup alloc] init];
            
            GPUImageSepiaFilter *sepiaFilter = [[GPUImageSepiaFilter alloc] init];
            [(GPUImageFilterGroup *)self.filter addFilter:sepiaFilter];
            
            GPUImagePixellateFilter *pixellateFilter = [[GPUImagePixellateFilter alloc] init];
            [(GPUImageFilterGroup *)self.filter addFilter:pixellateFilter];
            
            [sepiaFilter addTarget:pixellateFilter];
            [(GPUImageFilterGroup *)self.filter setInitialFilters:[NSArray arrayWithObject:sepiaFilter]];
            [(GPUImageFilterGroup *)self.filter setTerminalFilter:pixellateFilter];
        }; break;
            
        case GPUIMAGE_FACES:
        {
//            facesSwitch.hidden = NO;
//            facesLabel.hidden = NO;
            
            [self.videoCamera rotateCamera];
            self.title = @"Face Detection";
            self.filterSettingsSlider.hidden = YES;
            
            [self.filterSettingsSlider setValue:1.0];
            [self.filterSettingsSlider setMinimumValue:0.0];
            [self.filterSettingsSlider setMaximumValue:2.0];
            
            self.filter = [[GPUImageSaturationFilter alloc] init];
            [self.videoCamera setDelegate:self];
            break;
        }
            
        default: self.filter = [[GPUImageSepiaFilter alloc] init]; break;
    }
    
    if (filterType == GPUIMAGE_FILECONFIG)
    {
        self.title = @"File Configuration";
        pipeline = [[GPUImageFilterPipeline alloc] initWithConfigurationFile:[[NSBundle mainBundle] URLForResource:@"SampleConfiguration" withExtension:@"plist"]
                                                                       input:self.videoCamera output:self.gpuImageView];
        
//                [pipeline addFilter:rotationFilter atIndex:0];
    }
    else
    {
        
        if (filterType != GPUIMAGE_VORONOI)
        {
            [self.videoCamera addTarget:self.filter];
        }
        
        self.videoCamera.runBenchmark = YES;
        GPUImageView *filterView = self.gpuImageView;
        
        if (needsSecondImage)
        {
            UIImage *inputImage;
            
            if (filterType == GPUIMAGE_MASK)
            {
                inputImage = [UIImage imageNamed:@"mask"];
            }
            /*
             else if (filterType == GPUIMAGE_VORONOI) {
             inputImage = [UIImage imageNamed:@"voroni_points.png"];
             }*/
            else {
                // The picture is only used for two-image blend filters
                inputImage = [UIImage imageNamed:@"WID-small.jpg"];
            }
            
            //            self.gpuImage = [[GPUImagePicture alloc] initWithImage:inputImage smoothlyScaleOutput:NO];
            self.gpuPicture = [[GPUImagePicture alloc] initWithImage:inputImage smoothlyScaleOutput:YES];
            [self.gpuPicture processImage];
            [self.gpuPicture addTarget:self.filter];
        }
        
        
        if (filterType == GPUIMAGE_HISTOGRAM)
        {
            // I'm adding an intermediary filter because glReadPixels() requires something to be rendered for its glReadPixels() operation to work
            [self.videoCamera removeTarget:self.filter];
            GPUImageGammaFilter *gammaFilter = [[GPUImageGammaFilter alloc] init];
            [self.videoCamera addTarget:gammaFilter];
            [gammaFilter addTarget:self.filter];
            
            GPUImageHistogramGenerator *histogramGraph = [[GPUImageHistogramGenerator alloc] init];
            
            [histogramGraph forceProcessingAtSize:CGSizeMake(256.0, 330.0)];
            [self.filter addTarget:histogramGraph];
            
            GPUImageAlphaBlendFilter *blendFilter = [[GPUImageAlphaBlendFilter alloc] init];
            blendFilter.mix = 0.75;
            [blendFilter forceProcessingAtSize:CGSizeMake(256.0, 330.0)];
            
            [self.videoCamera addTarget:blendFilter];
            [histogramGraph addTarget:blendFilter];
            
            [blendFilter addTarget:filterView];
        }
        else if ( (filterType == GPUIMAGE_HARRISCORNERDETECTION)
                 || (filterType == GPUIMAGE_NOBLECORNERDETECTION)
                 || (filterType == GPUIMAGE_SHITOMASIFEATUREDETECTION) )
        {
            GPUImageCrosshairGenerator *crosshairGenerator = [[GPUImageCrosshairGenerator alloc] init];
            crosshairGenerator.crosshairWidth = 15.0;
            [crosshairGenerator forceProcessingAtSize:CGSizeMake(480.0, 640.0)];
            
            [(GPUImageHarrisCornerDetectionFilter *)self.filter setCornersDetectedBlock:^(GLfloat* cornerArray, NSUInteger cornersDetected, CMTime frameTime) {
                [crosshairGenerator renderCrosshairsFromArray:cornerArray count:cornersDetected frameTime:frameTime];
            }];
            
            GPUImageAlphaBlendFilter *blendFilter = [[GPUImageAlphaBlendFilter alloc] init];
            [blendFilter forceProcessingAtSize:CGSizeMake(480.0, 640.0)];
            GPUImageGammaFilter *gammaFilter = [[GPUImageGammaFilter alloc] init];
            [self.videoCamera addTarget:gammaFilter];
            [gammaFilter addTarget:blendFilter];
            
            [crosshairGenerator addTarget:blendFilter];
            
            [blendFilter addTarget:filterView];
        }
        else if (filterType == GPUIMAGE_HOUGHTRANSFORMLINEDETECTOR)
        {
            GPUImageLineGenerator *lineGenerator = [[GPUImageLineGenerator alloc] init];
//            lineGenerator.crosshairWidth = 15.0;
            [lineGenerator forceProcessingAtSize:CGSizeMake(480.0, 640.0)];
            [lineGenerator setLineColorRed:1.0 green:0.0 blue:0.0];
            [(GPUImageHoughTransformLineDetector *)self.filter setLinesDetectedBlock:^(GLfloat* lineArray, NSUInteger linesDetected, CMTime frameTime){
                [lineGenerator renderLinesFromArray:lineArray count:linesDetected frameTime:frameTime];
            }];
            
            GPUImageAlphaBlendFilter *blendFilter = [[GPUImageAlphaBlendFilter alloc] init];
            [blendFilter forceProcessingAtSize:CGSizeMake(480.0, 640.0)];
            GPUImageGammaFilter *gammaFilter = [[GPUImageGammaFilter alloc] init];
            [self.videoCamera addTarget:gammaFilter];
            [gammaFilter addTarget:blendFilter];
            
            [lineGenerator addTarget:blendFilter];
            
            [blendFilter addTarget:filterView];
        }
        else if (filterType == GPUIMAGE_UIELEMENT)
        {
            GPUImageAlphaBlendFilter *blendFilter = [[GPUImageAlphaBlendFilter alloc] init];
            blendFilter.mix = 1.0;
            
            NSDate *startTime = [NSDate date];
            
            UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 240.0f, 320.0f)];
            timeLabel.font = [UIFont systemFontOfSize:17.0f];
            timeLabel.text = @"Time: 0.0 s";
//            timeLabel.textAlignment = UITextAlignmentCenter;
            timeLabel.backgroundColor = [UIColor clearColor];
            timeLabel.textColor = [UIColor whiteColor];
            
            uiElementInput = [[GPUImageUIElement alloc] initWithView:timeLabel];

            [self.filter addTarget:blendFilter];
            [uiElementInput addTarget:blendFilter];
            
            [blendFilter addTarget:filterView];
            
            __unsafe_unretained GPUImageUIElement *weakUIElementInput = uiElementInput;
            
            [self.filter setFrameProcessingCompletionBlock:^(GPUImageOutput * filter, CMTime frameTime){
                timeLabel.text = [NSString stringWithFormat:@"Time: %f s", -[startTime timeIntervalSinceNow]];
                [weakUIElementInput update];
            }];
        }
        else if (filterType == GPUIMAGE_BUFFER)
        {
            GPUImageDifferenceBlendFilter *blendFilter = [[GPUImageDifferenceBlendFilter alloc] init];
            
            [self.videoCamera removeTarget:self.filter];
            
            GPUImageGammaFilter *gammaFilter = [[GPUImageGammaFilter alloc] init];
            [self.videoCamera addTarget:gammaFilter];
            [gammaFilter addTarget:blendFilter];
            [self.videoCamera addTarget:self.filter];
            
            [self.filter addTarget:blendFilter];
            
            [blendFilter addTarget:filterView];
        }
        else if ( (filterType == GPUIMAGE_OPACITY) || (filterType == GPUIMAGE_CHROMAKEYNONBLEND) )
        {
            [self.gpuPicture removeTarget:self.filter];
            [self.videoCamera removeTarget:self.filter];
            [self.videoCamera addTarget:self.filter];
            
            GPUImageAlphaBlendFilter *blendFilter = [[GPUImageAlphaBlendFilter alloc] init];
            blendFilter.mix = 1.0;
            [self.gpuPicture addTarget:blendFilter];
            [self.filter addTarget:blendFilter];
            
            [blendFilter addTarget:filterView];
        }
        else if ( (filterType == GPUIMAGE_SPHEREREFRACTION) || (filterType == GPUIMAGE_GLASSSPHERE) )
        {
            // Provide a blurred image for a cool-looking background
            GPUImageGaussianBlurFilter *gaussianBlur = [[GPUImageGaussianBlurFilter alloc] init];
            [self.videoCamera addTarget:gaussianBlur];
            gaussianBlur.blurRadiusInPixels = 5.0;
            
            GPUImageAlphaBlendFilter *blendFilter = [[GPUImageAlphaBlendFilter alloc] init];
            blendFilter.mix = 1.0;
            [gaussianBlur addTarget:blendFilter];
            [self.filter addTarget:blendFilter];
            
            [blendFilter addTarget:filterView];
            
        }
        else if (filterType == GPUIMAGE_AVERAGECOLOR)
        {
            GPUImageSolidColorGenerator *colorGenerator = [[GPUImageSolidColorGenerator alloc] init];
            [colorGenerator forceProcessingAtSize:[filterView sizeInPixels]];
            
            [(GPUImageAverageColor *)self.filter setColorAverageProcessingFinishedBlock:^(CGFloat redComponent, CGFloat greenComponent, CGFloat blueComponent, CGFloat alphaComponent, CMTime frameTime) {
                [colorGenerator setColorRed:redComponent green:greenComponent blue:blueComponent alpha:alphaComponent];
                //                NSLog(@"Average color: %f, %f, %f, %f", redComponent, greenComponent, blueComponent, alphaComponent);
            }];
            
            [colorGenerator addTarget:filterView];
        }
        else if (filterType == GPUIMAGE_LUMINOSITY)
        {
            GPUImageSolidColorGenerator *colorGenerator = [[GPUImageSolidColorGenerator alloc] init];
            [colorGenerator forceProcessingAtSize:[filterView sizeInPixels]];
            
            [(GPUImageLuminosity *)self.filter setLuminosityProcessingFinishedBlock:^(CGFloat luminosity, CMTime frameTime) {
                [colorGenerator setColorRed:luminosity green:luminosity blue:luminosity alpha:1.0];
            }];
            
            [colorGenerator addTarget:filterView];
        }
        else if (filterType == GPUIMAGE_IOSBLUR)
        {
            [self.videoCamera removeAllTargets];
            [self.videoCamera addTarget:filterView];
            GPUImageCropFilter *cropFilter = [[GPUImageCropFilter alloc] init];
            cropFilter.cropRegion = CGRectMake(0.0, 0.5, 1.0, 0.5);
            [self.videoCamera addTarget:cropFilter];
            [cropFilter addTarget:self.filter];
            
            CGRect currentViewFrame = filterView.bounds;
            GPUImageView *blurOverlayView = [[GPUImageView alloc] initWithFrame:CGRectMake(0.0, round(currentViewFrame.size.height / 2.0), currentViewFrame.size.width, currentViewFrame.size.height - round(currentViewFrame.size.height / 2.0))];
            [filterView addSubview:blurOverlayView];
            [self.filter addTarget:blurOverlayView];
        }
        else if (filterType == GPUIMAGE_MOTIONDETECTOR)
        {
            faceView = [[UIView alloc] initWithFrame:CGRectMake(100.0, 100.0, 100.0, 100.0)];
            faceView.layer.borderWidth = 1;
            faceView.layer.borderColor = [[UIColor redColor] CGColor];
            [self.view addSubview:faceView];
            faceView.hidden = YES;
            
            __unsafe_unretained IJSGimageFilterController * weakSelf = self;
            [(GPUImageMotionDetector *) self.filter setMotionDetectionBlock:^(CGPoint motionCentroid, CGFloat motionIntensity, CMTime frameTime) {
                if (motionIntensity > 0.01)
                {
                    CGFloat motionBoxWidth = 1500.0 * motionIntensity;
                    CGSize viewBounds = weakSelf.view.bounds.size;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakSelf->faceView.frame = CGRectMake(round(viewBounds.width * motionCentroid.x - motionBoxWidth / 2.0), round(viewBounds.height * motionCentroid.y - motionBoxWidth / 2.0), motionBoxWidth, motionBoxWidth);
                        weakSelf->faceView.hidden = NO;
                    });

                }
                else
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakSelf->faceView.hidden = YES;
                    });
                }

            }];
            
            [self.videoCamera addTarget:filterView];
        }
        else
        {
            [self.filter forceProcessingAtSize:[UIScreen mainScreen].bounds.size]; // 设置渲染的区域
            [self.filter addTarget:filterView];
        }
    }
    
    [self.videoCamera startCameraCapture];
}















- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
