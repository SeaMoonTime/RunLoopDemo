//
//  ViewController.m
//  RunLoopDemo
//
//  Created by Yang on 25/04/2018.
//  Copyright © 2018 SeaMoonTime. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(strong, nonatomic) NSThread *subThread;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testThread];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self performSelector:@selector(subThreadOperation) onThread:self.subThread withObject:nil waitUntilDone:NO];
}

-(void)testThread{
    NSThread *subThread = [[NSThread alloc]initWithTarget:self selector:@selector(subThreadEntryPoint) object:nil];
    [subThread setName:@"TestThread"];
    [subThread start];
    self.subThread = subThread;
}

//子线程启动后，启动runloop
- (void)subThreadEntryPoint{
    @autoreleasepool{
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSRunLoopCommonModes];
        NSLog(@"启动RunLoop前--%@",runLoop.currentMode);
        [runLoop run];
    }
}

//子线程任务
- (void)subThreadOperation{
    NSLog(@"启动RunLoop后--%@",[NSRunLoop currentRunLoop].currentMode);
    NSLog(@"%@----子线程任务开始",[NSThread currentThread]);
    [NSThread sleepForTimeInterval:3.0];
    NSLog(@"%@----子线程任务结束",[NSThread currentThread]);
    
}


@end
