//
//  IJSGToolsView.m
//  IJSGPUImageSDK
//
//  Created by 山神 on 2017/11/8.
//  Copyright © 2017年 山神. All rights reserved.
//

#import "IJSGToolsView.h"
#import "IJSGHeaderConst.h"
#import "IJSGToolsViewCell.h"

static NSString *const cellID = @"IJSGTolldViewCell";

@interface IJSGToolsView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,weak) UICollectionView *showCollectioView;  // 展示用的collview
@property(nonatomic,strong) NSMutableArray *nameArr;  // 名字展示的数组
@end

@implementation IJSGToolsView


-(instancetype)initWithFrame:(CGRect)frame
{
    self =[super initWithFrame:frame];
    if (self)
    {
        [self _setupUI];
      
    }
    return self;
}
#pragma mark 初始化UI
-(void)_setupUI
{
    //中间的collectionview
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(IJSGScreenWidth / 7 , IJSGToolsViewHeight);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *showCollectioView =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width , self.frame.size.height) collectionViewLayout:layout];
    showCollectioView.backgroundColor = [UIColor clearColor];
    showCollectioView.alwaysBounceHorizontal = YES;
    showCollectioView.showsVerticalScrollIndicator = NO;
    showCollectioView.showsHorizontalScrollIndicator = NO;
    showCollectioView.pagingEnabled = YES;
    [self addSubview:showCollectioView];
    showCollectioView.dataSource = self;
    showCollectioView.delegate = self;
    self.showCollectioView = showCollectioView;
    [self.showCollectioView registerClass:[IJSGToolsViewCell class] forCellWithReuseIdentifier:cellID];
}

/*-----------------------------------collection-------------------------------------------------------*/
#pragma mark collectionview delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.nameArr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    IJSGToolsViewCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.name = self.nameArr[indexPath.row];
    
    return cell;
}
#pragma mark 点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.didSelectedCallBack)
    {
        self.didSelectedCallBack(indexPath.row);
    }
}


#pragma mark 懒加载区域
-(NSMutableArray *)nameArr
{
    if (_nameArr == nil)
    {
        _nameArr =[NSMutableArray arrayWithObjects:@"Saturation",@"Contrast",@"Brightness",@"Levels",@"Exposure",@"RGB",@"Hue",@"White balance",@"Monochrome",@"False color", nil];
    }
    return _nameArr;
}



//case GPUIMAGE_SATURATION: cell.textLabel.text = @"Saturation"; break;
//case GPUIMAGE_CONTRAST: cell.textLabel.text = @"Contrast"; break;
//case GPUIMAGE_BRIGHTNESS: cell.textLabel.text = @"Brightness"; break;
//case GPUIMAGE_LEVELS: cell.textLabel.text = @"Levels"; break;
//case GPUIMAGE_EXPOSURE: cell.textLabel.text = @"Exposure"; break;
//case GPUIMAGE_RGB: cell.textLabel.text = @"RGB"; break;
//case GPUIMAGE_HUE: cell.textLabel.text = @"Hue"; break;
//case GPUIMAGE_WHITEBALANCE: cell.textLabel.text = @"White balance"; break;
//case GPUIMAGE_MONOCHROME: cell.textLabel.text = @"Monochrome"; break;
//case GPUIMAGE_FALSECOLOR: cell.textLabel.text = @"False color"; break;
//case GPUIMAGE_SHARPEN: cell.textLabel.text = @"Sharpen"; break;
//case GPUIMAGE_UNSHARPMASK: cell.textLabel.text = @"Unsharp mask"; break;
//case GPUIMAGE_GAMMA: cell.textLabel.text = @"Gamma"; break;
//case GPUIMAGE_TONECURVE: cell.textLabel.text = @"Tone curve"; break;
//case GPUIMAGE_HIGHLIGHTSHADOW: cell.textLabel.text = @"Highlights and shadows"; break;
//case GPUIMAGE_HAZE: cell.textLabel.text = @"Haze"; break;
//case GPUIMAGE_CHROMAKEYNONBLEND: cell.textLabel.text = @"Chroma key"; break;
//case GPUIMAGE_HISTOGRAM: cell.textLabel.text = @"Histogram"; break;
//case GPUIMAGE_HISTOGRAM_EQUALIZATION: cell.textLabel.text = @"Histogram Equalization"; break;
//case GPUIMAGE_AVERAGECOLOR: cell.textLabel.text = @"Average color"; break;
//case GPUIMAGE_LUMINOSITY: cell.textLabel.text = @"Luminosity"; break;
//case GPUIMAGE_THRESHOLD: cell.textLabel.text = @"Threshold"; break;
//case GPUIMAGE_ADAPTIVETHRESHOLD: cell.textLabel.text = @"Adaptive threshold"; break;
//case GPUIMAGE_AVERAGELUMINANCETHRESHOLD: cell.textLabel.text = @"Average luminance threshold"; break;
//case GPUIMAGE_CROP: cell.textLabel.text = @"Crop"; break;
//case GPUIMAGE_TRANSFORM: cell.textLabel.text = @"Transform (2-D)"; break;
//case GPUIMAGE_TRANSFORM3D: cell.textLabel.text = @"Transform (3-D)"; break;
//case GPUIMAGE_MASK: cell.textLabel.text = @"Mask"; break;
//case GPUIMAGE_COLORINVERT: cell.textLabel.text = @"Color invert"; break;
//case GPUIMAGE_GRAYSCALE: cell.textLabel.text = @"Grayscale"; break;
//case GPUIMAGE_SEPIA: cell.textLabel.text = @"Sepia tone"; break;
//case GPUIMAGE_MISSETIKATE: cell.textLabel.text = @"Miss Etikate (Lookup)"; break;
//case GPUIMAGE_SOFTELEGANCE: cell.textLabel.text = @"Soft elegance (Lookup)"; break;
//case GPUIMAGE_AMATORKA: cell.textLabel.text = @"Amatorka (Lookup)"; break;
//case GPUIMAGE_PIXELLATE: cell.textLabel.text = @"Pixellate"; break;
//case GPUIMAGE_POLARPIXELLATE: cell.textLabel.text = @"Polar pixellate"; break;
//case GPUIMAGE_PIXELLATE_POSITION: cell.textLabel.text = @"Pixellate (position)"; break;
//case GPUIMAGE_POLKADOT: cell.textLabel.text = @"Polka dot"; break;
//case GPUIMAGE_HALFTONE: cell.textLabel.text = @"Halftone"; break;
//case GPUIMAGE_CROSSHATCH: cell.textLabel.text = @"Crosshatch"; break;
//case GPUIMAGE_SOBELEDGEDETECTION: cell.textLabel.text = @"Sobel edge detection"; break;
//case GPUIMAGE_PREWITTEDGEDETECTION: cell.textLabel.text = @"Prewitt edge detection"; break;
//case GPUIMAGE_CANNYEDGEDETECTION: cell.textLabel.text = @"Canny edge detection"; break;
//case GPUIMAGE_THRESHOLDEDGEDETECTION: cell.textLabel.text = @"Threshold edge detection"; break;
//case GPUIMAGE_XYGRADIENT: cell.textLabel.text = @"XY derivative"; break;
//case GPUIMAGE_HARRISCORNERDETECTION: cell.textLabel.text = @"Harris corner detection"; break;
//case GPUIMAGE_NOBLECORNERDETECTION: cell.textLabel.text = @"Noble corner detection"; break;
//case GPUIMAGE_SHITOMASIFEATUREDETECTION: cell.textLabel.text = @"Shi-Tomasi feature detection"; break;
//case GPUIMAGE_HOUGHTRANSFORMLINEDETECTOR: cell.textLabel.text = @"Hough transform line detection"; break;
//case GPUIMAGE_BUFFER: cell.textLabel.text = @"Image buffer"; break;
//case GPUIMAGE_MOTIONDETECTOR: cell.textLabel.text = @"Motion detector"; break;
//case GPUIMAGE_LOWPASS: cell.textLabel.text = @"Low pass"; break;
//case GPUIMAGE_HIGHPASS: cell.textLabel.text = @"High pass"; break;
//case GPUIMAGE_SKETCH: cell.textLabel.text = @"Sketch"; break;
//case GPUIMAGE_THRESHOLDSKETCH: cell.textLabel.text = @"Threshold Sketch"; break;
//case GPUIMAGE_TOON: cell.textLabel.text = @"Toon"; break;
//case GPUIMAGE_SMOOTHTOON: cell.textLabel.text = @"Smooth toon"; break;
//case GPUIMAGE_TILTSHIFT: cell.textLabel.text = @"Tilt shift"; break;
//case GPUIMAGE_CGA: cell.textLabel.text = @"CGA colorspace"; break;
//case GPUIMAGE_CONVOLUTION: cell.textLabel.text = @"3x3 convolution"; break;
//case GPUIMAGE_EMBOSS: cell.textLabel.text = @"Emboss"; break;
//case GPUIMAGE_LAPLACIAN: cell.textLabel.text = @"Laplacian"; break;
//case GPUIMAGE_POSTERIZE: cell.textLabel.text = @"Posterize"; break;
//case GPUIMAGE_SWIRL: cell.textLabel.text = @"Swirl"; break;
//case GPUIMAGE_BULGE: cell.textLabel.text = @"Bulge"; break;
//case GPUIMAGE_SPHEREREFRACTION: cell.textLabel.text = @"Sphere refraction"; break;
//case GPUIMAGE_GLASSSPHERE: cell.textLabel.text = @"Glass sphere"; break;
//case GPUIMAGE_PINCH: cell.textLabel.text = @"Pinch"; break;
//case GPUIMAGE_STRETCH: cell.textLabel.text = @"Stretch"; break;
//case GPUIMAGE_DILATION: cell.textLabel.text = @"Dilation"; break;
//case GPUIMAGE_EROSION: cell.textLabel.text = @"Erosion"; break;
//case GPUIMAGE_OPENING: cell.textLabel.text = @"Opening"; break;
//case GPUIMAGE_CLOSING: cell.textLabel.text = @"Closing"; break;
//case GPUIMAGE_PERLINNOISE: cell.textLabel.text = @"Perlin noise"; break;
//case GPUIMAGE_VORONOI: cell.textLabel.text = @"Voronoi"; break;
//case GPUIMAGE_MOSAIC: cell.textLabel.text = @"Mosaic"; break;
//case GPUIMAGE_LOCALBINARYPATTERN: cell.textLabel.text = @"Local binary pattern"; break;
//case GPUIMAGE_CHROMAKEY: cell.textLabel.text = @"Chroma key blend (green)"; break;
//case GPUIMAGE_DISSOLVE: cell.textLabel.text = @"Dissolve blend"; break;
//case GPUIMAGE_SCREENBLEND: cell.textLabel.text = @"Screen blend"; break;
//case GPUIMAGE_COLORBURN: cell.textLabel.text = @"Color burn blend"; break;
//case GPUIMAGE_COLORDODGE: cell.textLabel.text = @"Color dodge blend"; break;
//case GPUIMAGE_LINEARBURN: cell.textLabel.text = @"Linear burn blend"; break;
//case GPUIMAGE_ADD: cell.textLabel.text = @"Add blend"; break;
//case GPUIMAGE_DIVIDE: cell.textLabel.text = @"Divide blend"; break;
//case GPUIMAGE_MULTIPLY: cell.textLabel.text = @"Multiply blend"; break;
//case GPUIMAGE_OVERLAY: cell.textLabel.text = @"Overlay blend"; break;
//case GPUIMAGE_LIGHTEN: cell.textLabel.text = @"Lighten blend"; break;
//case GPUIMAGE_DARKEN: cell.textLabel.text = @"Darken blend"; break;
//case GPUIMAGE_EXCLUSIONBLEND: cell.textLabel.text = @"Exclusion blend"; break;
//case GPUIMAGE_DIFFERENCEBLEND: cell.textLabel.text = @"Difference blend"; break;
//case GPUIMAGE_SUBTRACTBLEND: cell.textLabel.text = @"Subtract blend"; break;
//case GPUIMAGE_HARDLIGHTBLEND: cell.textLabel.text = @"Hard light blend"; break;
//case GPUIMAGE_SOFTLIGHTBLEND: cell.textLabel.text = @"Soft light blend"; break;
//case GPUIMAGE_COLORBLEND: cell.textLabel.text = @"Color blend"; break;
//case GPUIMAGE_HUEBLEND: cell.textLabel.text = @"Hue blend"; break;
//case GPUIMAGE_SATURATIONBLEND: cell.textLabel.text = @"Saturation blend"; break;
//case GPUIMAGE_LUMINOSITYBLEND: cell.textLabel.text = @"Luminosity blend"; break;
//case GPUIMAGE_NORMALBLEND: cell.textLabel.text = @"Normal blend"; break;
//case GPUIMAGE_POISSONBLEND: cell.textLabel.text = @"Poisson blend"; break;
//case GPUIMAGE_OPACITY: cell.textLabel.text = @"Opacity adjustment"; break;
//case GPUIMAGE_KUWAHARA: cell.textLabel.text = @"Kuwahara"; break;
//case GPUIMAGE_KUWAHARARADIUS3: cell.textLabel.text = @"Kuwahara (fixed radius)"; break;
//case GPUIMAGE_VIGNETTE: cell.textLabel.text = @"Vignette"; break;
//case GPUIMAGE_GAUSSIAN: cell.textLabel.text = @"Gaussian blur"; break;
//case GPUIMAGE_MEDIAN: cell.textLabel.text = @"Median (3x3)"; break;
//case GPUIMAGE_BILATERAL: cell.textLabel.text = @"Bilateral blur"; break;
//case GPUIMAGE_MOTIONBLUR: cell.textLabel.text = @"Motion blur"; break;
//case GPUIMAGE_ZOOMBLUR: cell.textLabel.text = @"Zoom blur"; break;
//case GPUIMAGE_BOXBLUR: cell.textLabel.text = @"Box blur"; break;
//case GPUIMAGE_GAUSSIAN_SELECTIVE: cell.textLabel.text = @"Gaussian selective blur"; break;
//case GPUIMAGE_GAUSSIAN_POSITION: cell.textLabel.text = @"Gaussian (centered)"; break;
//case GPUIMAGE_IOSBLUR: cell.textLabel.text = @"iOS 7 blur"; break;
//case GPUIMAGE_UIELEMENT: cell.textLabel.text = @"UI element"; break;
//case GPUIMAGE_CUSTOM: cell.textLabel.text = @"Custom"; break;
//case GPUIMAGE_FILECONFIG: cell.textLabel.text = @"Filter Chain"; break;
//case GPUIMAGE_FILTERGROUP: cell.textLabel.text = @"Filter Group"; break;
//case GPUIMAGE_FACES: cell.textLabel.text = @"Face Detection"; break;









@end
