//
//  IJSGToolsViewCell.m
//  IJSGPUImageSDK
//
//  Created by 山神 on 2017/11/8.
//  Copyright © 2017年 山神. All rights reserved.
//

#import "IJSGToolsViewCell.h"

@interface IJSGToolsViewCell()
@property(nonatomic,weak) UILabel *nameLabel;  // 名字标签
@end

@implementation IJSGToolsViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupUI];
    }
    return self;
}

-(void)setupUI
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(1, 0, self.frame.size.width - 2, self.frame.size.height)];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:label];
    self.nameLabel= label;
}

-(void)setName:(NSString *)name
{
    _name = name;
    self.nameLabel.text = name;
}








@end
