
//
//  IJSGHeaderConst.h
//  IJSGPUImageSDK
//
//  Created by 山神 on 2017/11/8.
//  Copyright © 2017年 山神. All rights reserved.
//

#ifndef IJSGHeaderConst_h
#define IJSGHeaderConst_h

#define  IJSGScreenWidth   [UIScreen mainScreen].bounds.size.width

#define  IJSGScreenHeight  [UIScreen mainScreen].bounds.size.height

#define  IJSGiPhoneX (IJSGScreenWidth == 375.f && IJSGScreenHeight == 812.f ? YES : NO)

#define  IJSGStatusBarHeight      (IJSGiPhoneX ? 44.f : 20.f)

#define  IJSGNavigationBarHeight  44.f

#define  IJSGTabbarHeight         (IJSGiPhoneX ? (49.f+34.f) : 49.f)

#define  IJSGTabbarSafeBottomMargin         (IJSGiPhoneX ? 34.f : 0.f)

#define  IJSGStatusBarAndNavigationBarHeight  (IJSGiPhoneX ? 88.f : 64.f)

#define IJSGViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})

#define IJSGToolsViewHeight 50




#endif /* IJSGHeaderConst_h */
