//
//  GCDTest.m
//  sdfd
//
//  Created by 梁齐才 on 16/5/31.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "GCDTest.h"

@implementation GCDTest


+ (void)multipleThreadShareArr:(NSArray *)dataArr complete:(void (^)(NSArray *))completeBlock
{
    //第一，我们要dataArr中取url
    dispatch_queue_t queue = dispatch_queue_create("bingfa", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_queue_t queue_serial = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
    dispatch_group_t group_forSerial = dispatch_group_create();
    
    
    NSMutableArray *rs = [NSMutableArray array];
    
    NSLock *get_lock = [NSLock new];
    NSLock *write_lock = [NSLock new];
    
    
    for (NSInteger i = 0; i < dataArr.count; i++) {
        
        dispatch_group_async(group, queue, ^{
            
            NSLog(@"this is %zd begin  %@",i,[NSThread currentThread]);
            
            
            NSString *urlString = nil;
            [get_lock lock];
            urlString = [dataArr objectAtIndex:i];
            [get_lock unlock];
            
//            NSInteger count = (10 - i) * 10000;  //测试时，就故意多写的
            NSInteger count = (10 - i) * 10;
            for (NSInteger k = 0; k < count; k++ ) {
                urlString = [urlString stringByAppendingFormat:@"_%zd",i];
            }
            
            NSLog(@"this is %zd end  %@",i,[NSThread currentThread]);
            
            //执行完成后，往里rs里面加
            dispatch_group_async(group_forSerial, queue_serial, ^{
                [rs addObject:urlString];
            });
            
            
            /*
             你也可以用锁的方式，在当前线程，把数组往里面加
            
             [write_lock lock];
             [rs addObject:urlString];
             [write_lock unlock];
             
             */
            
        });
    }
   
    
    /*  
     
     dispatch_group_notify  是指，马上异步地，把这个监听操作加到当前线程（这里这个当前线程就是函数执行的线程）的最后。
     ，一旦被加入的这个线程执行到这个代码块，就会马上去检查你有这个group有没有还未执行的block，如果没有，马上执行回调，如果有，则返回。
     
     所以，以下的代码是不能满足需求的。因为这个监听执行时，你还没有往 queue_serial 里面添加任何任务
     
    dispatch_group_notify(group_forSerial, dispatch_get_main_queue(), ^{
        
        NSLog(@"collected complect ,%@",rs);
    });
     */
    
    
    //以下代码，才是正确的。
    
    /* 
     所以，我们要深刻理解，CGD执行任务，dispatch_group_async  dispatch_group_notify 这些都是执行一次任务
     执行任务，是指当前线程中已经有很多任务，我把这些函数中的 block  添加到最后来执行。
    
     同步无非是，我等待 block 执行完了，才执行本我本来已经有的任务。（这也就是解释了，为啥子往线程中同步相同的队列，要死锁的问题）
     
     异步是指，我先执行我原来的任务，一旦原来的任务结束，马上回来执行异步任务。
     
     
     理解一定要到位
     
     */
    
    
    dispatch_group_notify(group, queue, ^{
       
        NSLog(@"getting data FF");
        
        dispatch_group_notify(group_forSerial, dispatch_get_main_queue(), ^{
           
            NSLog(@"collected complect ,%@",rs);
        });
    });
    
    
}



/*
 
 在使用一个类之前，请仔细阅读官方文档
 
 
 An NSLock object is used to coordinate the operation of multiple threads of execution within the same application. An NSLock object can be used to mediate access to an application’s global data or to protect a critical section of code, allowing it to run atomically.
 Overview
 Warning:Warning
 The NSLock class uses POSIX threads to implement its locking behavior. When sending an unlock message to an NSLock object, you must be sure that message is sent from the same thread that sent the initial lock message. Unlocking a lock from a different thread can result in undefined behavior.
 You should not use this class to implement a recursive lock. Calling the lock method twice on the same thread will lock up your thread permanently. Use the NSRecursiveLock class to implement recursive locks instead.
 Unlocking a lock that is not locked is considered a programmer error and should be fixed in your code. The NSLock class reports such errors by printing an error message to the console when they occur.
 

 
 care   1、lock  和 unlock  一定是在同一个线程中调用。
        2、如果你的代码不慎造成了任何可能的两次lock，那么这个线程会永久死锁，后果十分严重。
        3、当一个线程中代码执行到  [mylock lock]，那么这个线程就会等他其他线程 [mylock unlock]
        4、对不同需要保护的资源，尽量使用不同的 lock 实例
        5、请在lock  和  unlock 之间，执行必要的，必须要保护的代码，而不要执行一些不需要保护的代码。以免造成其他线程不必要的等待。
        6、@synchronized(obj){}   也是一个道理，往里面写尽可能少的代码，只许需要保护的代码，这样才能发挥多线程的本来用途（尽快的处理耗时操作）。
 
 */


+ (void)testLockIfNeedLock:(BOOL)needLock
{
    dispatch_queue_t queue = dispatch_queue_create("bingfa", DISPATCH_QUEUE_CONCURRENT);
    
    NSLock *lock = [[NSLock alloc] init];
    
    
    
    for (NSInteger i = 0; i < 3; i++) {
        
        dispatch_async(queue, ^{
            /*
             用lock 的方式
            if (needLock){
                [lock lock];
                [self print:i];
                [lock unlock];
            }else{
                [self print:i];
            }
             */
            
            //用更为方便的方式
            if (needLock){
                @synchronized(self) {//这里的self 是指  GCDTest 这个原类
                    [self print:i];
                }
                
            }else{
                [self print:i];
            }
            
            
           
        });
        
    }
   
}



+ (void)print:(NSInteger)index
{
    NSLog(@"print beging %zd",index);
    
    NSInteger count = (10 - index) * 1000;
    NSString *urlString = @"rs";
    for (NSInteger k = 0; k < count; k++ ) {
        urlString = [urlString stringByAppendingFormat:@"_%zd",k];
    }
    NSLog(@"print end %zd",index);
}


@end
