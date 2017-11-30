//
//  IJSGimageFilterController.h
//  IJSGPUImageSDK
//
//  Created by 山神 on 2017/11/8.
//  Copyright © 2017年 山神. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IJSGimageBaseController.h"
static NSString *const imageTitle = @"滤镜处理中心";

@interface IJSGimageFilterController : IJSGimageBaseController

@property (nonatomic, strong) UIImage *image; // 需要处理的资源

@end
