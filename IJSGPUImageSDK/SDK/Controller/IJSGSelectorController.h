//
//  IJSGSelectorController.h
//  IJSGPUImageSDK
//
//  Created by 山神 on 2017/11/8.
//  Copyright © 2017年 山神. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
typedef NS_ENUM(NSUInteger, IJSGSourceType) {
    IJSGSourceTypeImage,
    IJSGSourceTypeVideo,
    IJSGSourceTypeCamera,
    IJSGSourceTypePhoto,
};



@interface IJSGSelectorController : UINavigationController

/**
 初始化方法

 @param type 选择需要跳转的控制器类型
 @param image 图片资源
 @param video 视频资源
 @return 控制器自己
 */
- (instancetype)initWithSourceType:(IJSGSourceType)type image:(UIImage *)image video:(AVAsset *)video;

@property(nonatomic,assign) IJSGSourceType sourceType;  // 资源类型

@end
