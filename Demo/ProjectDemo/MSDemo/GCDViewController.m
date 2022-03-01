//
//  GCDViewController.m
//  Demo
//
//  Created by chenxiaojie on 2021/5/25.
//  Copyright © 2021 ChenJie. All rights reserved.
//

#import "GCDViewController.h"

@interface GCDViewController ()

@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - dispatch_group
- (IBAction)groupAction:(id)sender {
    NSLog(@"dispatch_group");
    
    dispatch_queue_t queue = dispatch_queue_create("com.test.queue", DISPATCH_QUEUE_CONCURRENT);

    dispatch_group_t group = dispatch_group_create();

    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"开始任务A");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"结束任务A");
        dispatch_group_leave(group);
    });

    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"开始任务B");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"结束任务B");
        dispatch_group_leave(group);
    });

    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"开始任务C");
        [NSThread sleepForTimeInterval:1];
        NSLog(@"结束任务C");
        dispatch_group_leave(group);
    });

    // 当所有任务执行结束后才执行以下代码
    dispatch_group_notify(group, queue, ^{
        NSLog(@"----------> group <----------");
        NSLog(@"开始任务D");
    });
}

#pragma mark - dispatch_barrier_async
- (IBAction)barrierAction:(id)sender {
    NSLog(@"dispatch_barrier_async");
    NSLog(@"---------- 1111111111 ----------");
    
    dispatch_queue_t queue = dispatch_queue_create("com.test.queue", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue, ^{
        NSLog(@"开始任务A，来自线程：%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:3];
        NSLog(@"结束任务A，来自线程：%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"开始任务B，来自线程：%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2];
        NSLog(@"结束任务B，来自线程：%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"开始任务C，来自线程：%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:1];
        NSLog(@"结束任务C，来自线程：%@",[NSThread currentThread]);
    });
    NSLog(@"---------- 2222222222 ----------");
    // 栅栏函数（异步）
    dispatch_barrier_async(queue, ^{
        NSLog(@"----------> barrier <----------");
    });

    dispatch_async(queue, ^{
        NSLog(@"开始任务D，来自线程：%@",[NSThread currentThread]);
    });
    NSLog(@"---------- 3333333333 ----------");
}

- (IBAction)barrier2Action:(id)sender {
    dispatch_queue_t queue = dispatch_queue_create("com.test.queue", DISPATCH_QUEUE_CONCURRENT);

    dispatch_barrier_async(queue, ^{
        NSLog(@"开始任务A");
        [NSThread sleepForTimeInterval:1];
        NSLog(@"结束任务A");
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"开始任务B");
        [NSThread sleepForTimeInterval:2];
        NSLog(@"结束任务B");
    });
    dispatch_barrier_async(queue, ^{
        NSLog(@"开始任务C");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"结束任务C");
    });

    dispatch_barrier_async(queue, ^{
        NSLog(@"----------> A B C 有顺序 <----------");
        NSLog(@"开始任务D");
    });
}

#pragma mark - dispatch_barrier_sync
- (IBAction)dispatch_barrier_syncAction:(id)sender {
    NSLog(@"dispatch_barrier_sync");
    NSLog(@"---------- 1111111111 ----------");
    
    dispatch_queue_t queue = dispatch_queue_create("com.test.queue", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue, ^{
        NSLog(@"开始任务A，来自线程：%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:3];
        NSLog(@"结束任务A，来自线程：%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"开始任务B，来自线程：%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2];
        NSLog(@"结束任务B，来自线程：%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"开始任务C，来自线程：%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:1];
        NSLog(@"结束任务C，来自线程：%@",[NSThread currentThread]);
    });
    NSLog(@"---------- 2222222222 ----------");
    // 栅栏函数（同步）
    dispatch_barrier_sync(queue, ^{
        NSLog(@"----------> barrier <----------");
    });

    dispatch_async(queue, ^{
        NSLog(@"开始任务D，来自线程：%@",[NSThread currentThread]);
    });
    NSLog(@"---------- 3333333333 ----------");

}

// 更深层次理解栅栏函数
- (IBAction)dispatch_queue_createAction:(id)sender {
    NSLog(@"dispatch_queue_create");
    dispatch_queue_t queue = dispatch_queue_create("com.test.queue", DISPATCH_QUEUE_CONCURRENT);
    
    for (int i = 0; i<100; i++) {
        dispatch_async(queue, ^{
            NSLog(@"i = %d，来自线程：%@", i, [NSThread currentThread]);
        });
    }
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"----------> barrier <----------");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"101");
    });
}
 
- (IBAction)dispatch_get_global_queueAction:(id)sender {
    NSLog(@"dispatch_get_global_queue");
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    for (int i = 0; i<100; i++) {
        dispatch_async(queue, ^{
            NSLog(@"i = %d，来自线程：%@", i, [NSThread currentThread]);
        });
    }
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"----------> barrier <----------");
    });
    
    dispatch_async(queue, ^{
        NSLog(@"101");
    });
}

// 那如果使用 全局队列的话

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
