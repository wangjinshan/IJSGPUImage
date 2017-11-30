//
//  IJSGToolsView.h
//  IJSGPUImageSDK
//
//  Created by 山神 on 2017/11/8.
//  Copyright © 2017年 山神. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IJSGToolsView : UIView


@property(nonatomic,copy) void(^didSelectedCallBack)(NSInteger index);  // 点击回调


@end
