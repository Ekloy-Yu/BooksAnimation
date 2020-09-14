//
//  BookCell.m
//  Button
//
//  Created by yutq on 2020/9/1.
//  Copyright © 2020 yutq. All rights reserved.
//


#import "BookCell.h"
 
@implementation BookCell
 
{
    BOOL isRightPage;
}
 
//初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //设置背景
        self.bgView = [[UIView alloc] initWithFrame:self.contentView.bounds];
        self.bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.bgView];
        
        //添加图片
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bgView.bounds.size.width, self.bgView.bounds.size.height)];
        [self.bgView addSubview:self.imageView];
        
        //添加星座label
        self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
        self.textLabel.center = CGPointMake(self.bgView.bounds.size.width / 2 + 20, self.bgView.bounds.size.height - 20);
        [self.bgView addSubview:self.textLabel];
        
        //开启反锯齿
        self.layer.allowsEdgeAntialiasing = YES;
        
    }
    return self;
}
 
//默认自定义布局,布局圆角 和 中心线
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    //判断cell的奇数偶数
    if (layoutAttributes.indexPath.item % 2 == 0) {
        //如果偶数,则中心线在左边,页面右边有圆角,左边没有圆角
        isRightPage = YES;
        self.layer.anchorPoint = CGPointMake(0, 0.5);
        //右部分图片只显示右半部
        //x,y,宽,高的取值为0---1，是按照图片百分比计算的
        self.imageView.layer.contentsRect = CGRectMake(0.5, 0, 0.5, 1);
    } else {
        isRightPage = NO;
        self.layer.anchorPoint = CGPointMake(1, 0.5);
        self.imageView.layer.contentsRect = CGRectMake(0, 0, 0.5, 1);
    }
    
    //圆角设置
    UIRectCorner corner = isRightPage ? UIRectCornerTopRight | UIRectCornerBottomRight : UIRectCornerTopLeft | UIRectCornerBottomLeft;
    UIBezierPath *bezier = [UIBezierPath bezierPathWithRoundedRect:self.bgView.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(16, 16)];
    //CAShapeLayer: 通过给定的贝塞尔曲线UIBezierPath,在空间中作图
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bgView.bounds;
    maskLayer.path = bezier.CGPath;
    self.bgView.layer.mask = maskLayer;
    self.bgView.clipsToBounds = YES;
}
@end
