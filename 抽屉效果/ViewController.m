//
//  ViewController.m
//  抽屉效果
//
//  Created by liuxingchen on 16/10/20.
//  Copyright © 2016年 Liuxingchen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)UIView * mainView ;
@property(nonatomic,strong)UIView * leftView ;
@property(nonatomic,strong)UIView * rightView ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubView];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
    
    /**
     *  添加KVO(也叫观察者模式)
        addObserver:观察者 谁想监听mainView
        forKeyPath:监听mainView的什么属性
        options:mainView的属性发生怎样的改变
        注意:只要监听的属性一改变就会调用，observeValueForKeyPath方法，通知有新得值
        在self.mainView销毁的时候，需要移除观察者
     */
    [self.mainView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}
//mainView的属性发生改变，就会调用该方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"%@",NSStringFromCGRect(self.mainView.frame));
    if (self.mainView.frame.origin.x > 0) {
        self.rightView.hidden = NO;
    }else if(self.mainView.frame.origin.x < 0 ){
        self.rightView.hidden = YES;
    }
}
//对象销毁时调用，移除观察者
-(void)dealloc
{
    [self.mainView removeObserver:self forKeyPath:@"frame"];
}
-(void)pan:(UIPanGestureRecognizer *)pan
{
    //获取开始点到目标点
    CGPoint transPoint = [pan translationInView:self.mainView];
    
    //获取偏移量
    CGFloat offsetX = transPoint.x;
    
//    //修改mainView的frame
//    CGRect frame = self.mainView.frame;
//    frame.origin.x += offsetX;
//    self.mainView.frame = frame;
    self.mainView.frame = [self frameWithOffsetX:offsetX];
    //复位
    [pan setTranslation:CGPointZero inView:self.mainView];
    
}
#pragma mark - 根据offsetX计算mainView的Frame
-(CGRect)frameWithOffsetX:(CGFloat)offsetX
{
    CGRect frame  = self.mainView.frame;
    frame.origin.x += offsetX;
    return frame;
}

-(void)setupSubView
{

    self.leftView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.leftView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.leftView];
    
    self.rightView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.rightView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.rightView];
    
    self.mainView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.mainView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.mainView];
}
@end
