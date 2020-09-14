//
//  BookView.m
//  Button
//
//  Created by yutq on 2020/9/1.
//  Copyright © 2020 yutq. All rights reserved.
//

#import "BookView.h"
#import "BookCell.h"
#import "BookLayout.h"


@implementation BookView
{
    NSMutableArray *_array;
    NSMutableArray *_arrayStr;
}
static NSString *const reuseIdentifier = @"cell";
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.dataSource = self;
        self.delegate =self;
        [self registerClass:[BookCell class] forCellWithReuseIdentifier:reuseIdentifier];
        self.showsHorizontalScrollIndicator = NO;
        
        _array = (NSMutableArray *)@[@"",@"1.jpg",@"1.jpg",@"2.jpg",@"2.jpg",@"3.jpg",@"3.jpg",@"4.jpg",@"4.jpg",@"5.jpg",@"5.jpg",@"1.jpg",@"1.jpg",@"2.jpg",@"2.jpg",@""];
        _arrayStr = (NSMutableArray *)@[@"",@"",@"白羊座",@"金牛座",@"双子座",@"巨蟹座",@"狮子座",@"处女座",@"天平座",@"天蝎座",@"射手座",@"魔蝎座",@"水瓶座",@"双鱼座",@"",@""];
    }
    return self;
}
 
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    CGFloat x = point.x/180;
    NSLog(@"%f", x);
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    CGPoint point = scrollView.contentOffset;
    float locaIndex = point.x/(180);
    NSLog(@"collectionLoca: %f", locaIndex);
    
    
}
 
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 16;
}
 
 
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BookCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:_array[indexPath.row]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", _arrayStr[indexPath.row]];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.textColor = [UIColor colorWithRed:148 / 255.0f green:0.0f blue:211 / 255.0f alpha:1.0f];
    return cell;
}
@end
