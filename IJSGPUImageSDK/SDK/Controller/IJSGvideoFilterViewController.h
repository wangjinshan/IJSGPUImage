//
//  IJSGvideoFilterViewController.h
//  IJSGPUImageSDK
//
//  Created by 山神 on 2017/11/8.
//  Copyright © 2017年 山神. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "IJSGimageBaseController.h"
static NSString *const videoTitle = @"视频处理中心";
@interface IJSGvideoFilterViewController : IJSGimageBaseController

@property (nonatomic, strong) AVAsset *video; // 视频资源

@end
