//
//  SocketClient.m
//  sdfd
//
//  Created by 梁齐才 on 16/12/19.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "SocketClient.h"
#import <GCDAsyncSocket.h>

@interface SocketClient ()<GCDAsyncSocketDelegate>
{
    GCDAsyncSocket *_socket;
}

@end

@implementation SocketClient

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    
}


- (IBAction)ss:(UIButton *)sender
{
    if (_socket.isConnected) return;
    
    [_socket connectToHost:@"172.19.15.144" onPort:8000 error:nil];
}



- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    
}

@end
