//
//  ViewController.m
//  ThreadSecurity
//
//  Created by pencho on 16/6/19.
//  Copyright © 2016年 litong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic,strong) NSNumber *leftTiketsCount;
@property (nonatomic,strong) NSThread *thread1;
@property (nonatomic,strong) NSThread *thread2;
@property (nonatomic,strong) NSThread *thread3;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leftTiketsCount = [NSNumber numberWithInteger:10];
    self.thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(selltickets) object:nil];
    self.thread1.name = @"售货员1";
    
    self.thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(selltickets) object:nil];
    self.thread2.name = @"售货员2";
    
    self.thread3 = [[NSThread alloc] initWithTarget:self selector:@selector(selltickets) object:nil];
    self.thread3.name = @"售货员3";
    [self.thread1 start];
    [self.thread2 start];
    [self.thread3 start];

}

- (void)selltickets{
    while (YES) {
        @synchronized (self) {//针对某个元素比如 self.leftTiketsCount 原子操作没用。？？？为啥
            NSInteger count = [self.leftTiketsCount integerValue];
            if(count >0 ){
                [NSThread sleepForTimeInterval:0.2f];
                self.leftTiketsCount = [NSNumber numberWithInteger: count -1 ];
                NSThread *currentThread = [NSThread currentThread];
                NSLog(@"%@--卖了一张票，还剩下%ld张票",currentThread.name,count -1);
            }else{
                [NSThread exit];
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
