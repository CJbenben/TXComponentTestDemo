//
//  SocketViewController.m
//  Demo
//
//  Created by chenxiaojie on 2020/7/20.
//  Copyright © 2020 ChenJie. All rights reserved.
//

#import "SocketViewController.h"
#import "XKBaseScrollView.h"
#import "XKTargetTableView.h"

#import <sys/socket.h>

#import <netinet/in.h>

#import <arpa/inet.h>

#import <unistd.h>

#import <netinet/tcp.h>
#import "GCDAsyncSocket.h"

@interface SocketViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) GCDAsyncSocket *socket;

@property (nonatomic,strong) XKBaseScrollView *scrollView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic,strong) XKTargetTableView *tableView;
///是否可以滑动 scrollView
@property (nonatomic,assign) BOOL canSlide;
@property (nonatomic,assign) CGFloat lastPositionY;
///滑动临界范围值
@property (nonatomic,assign) CGFloat dragCriticalY;

@end

@implementation SocketViewController

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
        _topView.backgroundColor = [UIColor redColor];
    }
    return _topView;
}

- (XKBaseScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[XKBaseScrollView alloc]initWithFrame:CGRectMake(0, naviHeight, SCREEN_WIDTH, SCREEN_HEIGHT - naviHeight)];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor redColor];
    }
    return _scrollView;
}

- (XKTargetTableView *)tableView{
    if(!_tableView){
        _tableView = [[XKTargetTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.frame = CGRectMake(0, 300, SCREEN_WIDTH, SCREEN_HEIGHT - (300 - self.dragCriticalY));
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self connectSocket];

    _dragCriticalY = 200;
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.topView];
    [self.scrollView addSubview:self.tableView];
    [self.scrollView setContentSize:CGSizeMake(SCREEN_WIDTH, self.tableView.bottom - naviHeight)];
    
    __weak __typeof__(self) weekSelf = self;
    self.tableView.slideDragBlock = ^{
        weekSelf.canSlide = YES;
        weekSelf.tableView.canSlide = NO;
    };
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat currentPostion = scrollView.contentOffset.y;
    NSLog(@"currentPostion = %.2f", currentPostion);
    /*
     当 底层滚动式图滚动到指定位置时，
     停止滚动，开始滚动子视图
     */
    if (currentPostion >= self.dragCriticalY) {
        scrollView.contentOffset = CGPointMake(0, self.dragCriticalY);
        if (self.canSlide) {
            self.canSlide = NO;
            self.tableView.canSlide = YES;
        }
        else{
            if (_lastPositionY - currentPostion > 0){
                if (self.tableView.contentOffset.y > 0) {
                    self.tableView.canSlide = YES;
                    self.canSlide = NO;
                }
                else{
                    self.tableView.canSlide = NO;
                    self.canSlide = YES;
                }
            }
        }
    }else{
        if (!self.canSlide && scrollView.contentOffset.y ==  self.dragCriticalY ) {
            scrollView.contentOffset = CGPointMake(0, self.dragCriticalY);
        }
        else{
            if (self.tableView.canSlide &&
                self.tableView.contentOffset.y != 0) {
                scrollView.contentOffset = CGPointMake(0, self.dragCriticalY);
            }
            else{
                
            }
        }
    }
    
    _lastPositionY = currentPostion;
}

- (void)connectSocket {
    // 1.与服务器通过三次握手建立连接
    NSString *host = @"127.0.0.1";
    int port = 8080;
    
    //创建一个socket对象
    _socket = [[GCDAsyncSocket alloc] initWithDelegate:self
                                         delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
    NSError *error = nil;
    
    // 开始连接
    [_socket connectToHost:host
                    onPort:port
                     error:&error];
    
    if (error) {
        NSLog(@"%@",error);
    }
}


#pragma mark - Socket代理方法
// 连接成功
- (void)socket:(GCDAsyncSocket *)sock
didConnectToHost:(NSString *)host
          port:(uint16_t)port {
    NSLog(@"%s",__func__);
}


// 断开连接
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock
                  withError:(NSError *)err {
    if (err) {
        NSLog(@"连接失败");
    } else {
        NSLog(@"正常断开");
    }
}


// 发送数据
- (void)socket:(GCDAsyncSocket *)sock
didWriteDataWithTag:(long)tag {
    
    NSLog(@"%s",__func__);
    
    //发送完数据手动读取，-1不设置超时
    [sock readDataWithTimeout:-1
                          tag:tag];
}

// 读取数据
-(void)socket:(GCDAsyncSocket *)sock
  didReadData:(NSData *)data
      withTag:(long)tag {
    
    NSString *receiverStr = [[NSString alloc] initWithData:data
                                                  encoding:NSUTF8StringEncoding];
    
    NSLog(@"%s %@",__func__,receiverStr);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
