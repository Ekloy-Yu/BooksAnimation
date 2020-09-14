//
//  BookCell.h
//  Button
//
//  Created by yutq on 2020/9/1.
//  Copyright © 2020 yutq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BookCell : UICollectionViewCell

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *textLabel;

@end

NS_ASSUME_NONNULL_END
