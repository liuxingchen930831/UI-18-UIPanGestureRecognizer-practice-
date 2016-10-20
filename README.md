```
/**
     *  添加KVO(也叫观察者模式)
        addObserver:观察者 谁想监听mainView
        forKeyPath:监听mainView的什么属性
        options:mainView的属性发生怎样的改变
        注意:只要监听的属性一改变就会调用，observeValueForKeyPath方法，通知有新得值
        在self.mainView销毁的时候，需要移除观察者
     */
    [self.mainView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
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
    ```