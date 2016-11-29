//
//  APLViewController.m
//  sdfd
//
//  Created by 梁齐才 on 16/11/28.
//  Copyright © 2016年 梁齐才. All rights reserved.
//

#import "APLViewController.h"


static NSString *DownloadURLString = @"http://sdk.umsns.com/download/ios/6.0.3_arm64/?custom=1573119";

@interface APLViewController ()
<NSURLSessionDownloadDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;



@property (nonatomic) NSURLSession *session;
@property (nonatomic) NSURLSessionDownloadTask *downloadTask;

@end

@implementation APLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.session = [self backgroundSession];
    
//    self.progressView.progress = 0;
//    self.imageView.hidden = NO;
//    self.progressView.hidden = YES;
}


- (IBAction)start:(id)sender
{
    if (self.downloadTask)
    {
        return;
    }
    
    /*
     Create a new download task using the URL session. Tasks start in the “suspended” state; to start a task you need to explicitly call -resume on a task after creating it.
     */
    NSURL *downloadURL = [NSURL URLWithString:DownloadURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:downloadURL];
    self.downloadTask = [self.session downloadTaskWithRequest:request];
    [self.downloadTask resume];
    
    
//    [self.downloadTask cancelByProducingResumeData:<#^(NSData * _Nullable resumeData)completionHandler#>]
    
//    [self.session downloadTaskWithResumeData:<#(nonnull NSData *)#>]
    
//    self.imageView.hidden = YES;
//    self.progressView.hidden = NO;
}


- (NSURLSession *)backgroundSession
{
    /*
     Using disptach_once here ensures that multiple background sessions with the same identifier are not created in this instance of the application. If you want to support multiple background sessions within a single process, you should create each session with its own identifier.
     */
    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.example.apple-samplecode.SimpleBackgroundTransfer.BackgroundSession"];
        
       NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    });
    return session;
}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    
    NSLog(@"memeda");
    
    /*
     Report progress on the task.
     If you created more than one task, you might keep references to them and report on them individually.
     */
    
//    if (downloadTask == self.downloadTask)
//    {
        double progress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
        dispatch_async(dispatch_get_main_queue(), ^{
            _label.text = Str_F(@"%lf",progress);
        });
        
        
        
//        BLog(@"DownloadTask: %@ progress: %lf", downloadTask, progress);
//        dispatch_async(dispatch_get_main_queue(), ^{
//            self.progressView.progress = progress;
//        });
//    }
}


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)downloadURL
{

//    downloadTask.originalRequest
    
    /*
     The download completed, you need to copy the file at targetPath before the end of this block.
     As an example, copy the file to the Documents directory of your app.
     */
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *URLs = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsDirectory = [URLs objectAtIndex:0];
    
    NSURL *originalURL = [[downloadTask originalRequest] URL];
    NSURL *destinationURL = [documentsDirectory URLByAppendingPathComponent:[originalURL lastPathComponent]];
    NSError *errorCopy;
    
    // For the purposes of testing, remove any esisting file at the destination.
    [fileManager removeItemAtURL:destinationURL error:NULL];
    BOOL success = [fileManager copyItemAtURL:downloadURL toURL:destinationURL error:&errorCopy];
    
    if (success)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithContentsOfFile:[destinationURL path]];
//            self.imageView.image = image;
//            self.imageView.hidden = NO;
//            self.progressView.hidden = YES;
        });
    }
    else
    {
        /*
         In the general case, what you might do in the event of failure depends on the error and the specifics of your application.
         */
//        BLog(@"Error during the copy: %@", [errorCopy localizedDescription]);
    }
}


- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    NSLog(@"...%@,",error.userInfo);
//    (NSURLSessionDownloadTask *)task.res
    
    if (error == nil)
    {
        NSLog(@"Task: %@ completed successfully", task);
    }
    else
    {
        NSLog(@"Task: %@ completed with error: %@", task, [error localizedDescription]);
    }
    
//    double progress = (double)task.countOfBytesReceived / (double)task.countOfBytesExpectedToReceive;
    dispatch_async(dispatch_get_main_queue(), ^{
        _label.text = Str_F(@"%lld",task.countOfBytesReceived);
//        self.progressView.progress = progress;
    });
    
    self.downloadTask = nil;
}


/*
 If an application has received an -application:handleEventsForBackgroundURLSession:completionHandler: message, the session delegate will receive this message to indicate that all messages previously enqueued for this session have been delivered. At this time it is safe to invoke the previously stored completion handler, or to begin any internal updates that will result in invoking the completion handler.
 */
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session
{
//    APLAppDelegate *appDelegate = (APLAppDelegate *)[[UIApplication sharedApplication] delegate];
//    if (appDelegate.backgroundSessionCompletionHandler) {
//        void (^completionHandler)() = appDelegate.backgroundSessionCompletionHandler;
//        appDelegate.backgroundSessionCompletionHandler = nil;
//        completionHandler();
//    }
//    
//    NSLog(@"All tasks are finished");
}


-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
//    BLog();
}

@end
