//
//  ViewController.m
//  Button
//
//  Created by yutq on 18/8/2.
//  Copyright © 2018年 yutq. All rights reserved.
//

#import "ViewController.h"
#import "ItemViewController.h"
#import "BookView.h"
#import "BookLayout.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UIImageView *leftImg;
@property (nonatomic, strong) UIImageView *rightImg;

@property(nonatomic,weak)CAGradientLayer *gradient;

@property (nonatomic, strong) NSArray *imgArray;

@property (nonatomic, strong) BookView *book;

#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width
#define desKey  @"hbhbtstsxskjo"

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self demo];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [btn addTarget:self action:@selector(toClick) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    

    
//    [self test];
}

- (void)demo{
    BookLayout *layout = [[BookLayout alloc] init];
    _book = [[BookView alloc] initWithFrame:CGRectMake(10, 100, 360, 500) collectionViewLayout:layout];
    [self.view addSubview:_book];
    
}

- (void)toClick{
    
    [_book setContentOffset:CGPointMake(360 * 1, 0) animated:YES];
    
}

- (void)test{

        _leftImg = [[UIImageView alloc] init];
        [self.view addSubview:_leftImg];
        _leftImg.image = [UIImage imageNamed:@"IMG_2956.JPG"];
        _leftImg.contentMode =  UIViewContentModeScaleToFill;
        
        _rightImg = [[UIImageView alloc] init];
        [self.view addSubview:_rightImg];
        _rightImg.contentMode =  UIViewContentModeScaleToFill;
        _rightImg.image = [UIImage imageNamed:@"IMG_2956.JPG"];
        
        
        //原本是正方形图片，设置图片的宽度是高度的2倍，这样才能保证图片拉动后的效果比例协调
        _leftImg.bounds = CGRectMake(0, 0, Main_Screen_Width/2, Main_Screen_Height);
        _leftImg.center = self.view.center;
        _rightImg.bounds = CGRectMake(0, 0, Main_Screen_Width/2, Main_Screen_Height);
        _rightImg.center = self.view.center;
        
        //上部分图片只显示上半部
        //x,y,宽,高的取值为0---1，是按照图片百分比计算的
        _leftImg.layer.contentsRect = CGRectMake(0, 0, 0.5, 1);
        _leftImg.layer.anchorPoint = CGPointMake(1, 0.5);
        _leftImg.userInteractionEnabled = YES;
        
        //下部分图片只显示下半部
        _rightImg.layer.contentsRect = CGRectMake(0.5, 0, 0.5, 1);
        _rightImg.layer.anchorPoint = CGPointMake(0, 0.5);
        _rightImg.userInteractionEnabled = YES;
        
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [self.view addGestureRecognizer:pan];
        
        //底部图片添加渐变
        //这个是渐变层
        CAGradientLayer *gradient = [CAGradientLayer layer];
        gradient.colors = @[(id)[UIColor clearColor].CGColor,(id)[UIColor blackColor].CGColor];
        gradient.frame = _leftImg.bounds;
        //设置不透明度
        gradient.opacity = 0;
        self.gradient = gradient;
         [_leftImg.layer addSublayer:gradient];
}

- (void)pan:(UIPanGestureRecognizer *)pan{
    
    if (pan.state == UIGestureRecognizerStateChanged) {
        //设置立体效果，近大远小
        CATransform3D transform = CATransform3DIdentity;
        // 设置M34就有立体感(近大远小)。 -1 / z ,z表示观察者在z轴上的值,z越小，看起来离我们越近，东西越大。
        transform.m34 =  -1 / 1000.0;
        
        //拖动的坐标
        CGPoint transP = [pan translationInView:self.view];
        //Main_Screen_Width 是 图片的宽度，即可以拉动的范围
        CGFloat angle = transP.x * (M_PI) / Main_Screen_Width;
        NSLog(@"transP: %f ------angle:%f", transP.x,angle);
        
        if ( transP.x < 0) {
            //从右往左滑动
            //rightImg 在上
            [self.view insertSubview:self.leftImg belowSubview:self.rightImg];
            
            //右半部分图片做旋转
            self.rightImg.layer.transform = CATransform3DRotate(transform, angle, 0, 1, 0);
            
            
        }else if ( transP.x > 0){
            //rightImg 在下
            [self.view insertSubview:self.rightImg belowSubview:self.leftImg];
            
            //左半部分图片做旋转
            self.leftImg.layer.transform = CATransform3DRotate(transform, angle, 0, 1, 0);
        }
        
        
        //设置不透明度  Main_Screen_Width 是 图片的宽度，即可以拉动的范围
        self.gradient.opacity = transP.x * M_PI / Main_Screen_Width;
        
        

    }else if(pan.state == UIGestureRecognizerStateEnded){
        self.gradient.opacity = 0;
        
        //Damping是弹性系数，值越小，弹得越厉害
        //
        //弹簧动画
        [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.25 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
            //让上部分图片反弹回去
            self.rightImg.layer.transform = CATransform3DIdentity;
            self.leftImg.layer.transform = CATransform3DIdentity;

        } completion:^(BOOL finished) {
            
        }];
    }
}



/*********************************************/
//渐变层知识点讲解
- (void)myGradient{
    //底部图片添加渐变
    //这个是渐变层
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.colors = @[(id)[UIColor redColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor blueColor].CGColor];
    gradient.frame = self.leftImg.bounds;
    //设置横的方向偏移
    /*
     对角渐变：
     gradient.startPoint = CGPointMake(0, 0);
     gradient.endPoint = CGPointMake(1, 0);
     */
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1, 0);
    //从哪一个位置渐变到下一个颜色
    gradient.locations = @[@0.1,@0.5];
    
    [self.leftImg.layer addSublayer:gradient];
}

@end
