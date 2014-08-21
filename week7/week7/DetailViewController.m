//
//  DetailViewController.m
//  week7
//
//  Created by 이상진 on 2014. 8. 21..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
            

@end

@implementation DetailViewController
            
#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    length = 0;
    [self readToServer:@"127.0.0.1"];
}


#pragma mark - Network
- (void)readToServer:(NSString*)serverString{
    
    if (![serverString isEqualToString:@""]) {
        NSURL *website = [NSURL URLWithString:serverString];
        if (!website) {
            NSLog(@"%@ is not a valid URL",serverString);
            return;
        }
        
        CFReadStreamRef readStream;
        CFWriteStreamRef writeStream;
        CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)serverString, 8000, &readStream, &writeStream);
        
        
        NSInputStream *inputStream = (__bridge_transfer NSInputStream *)readStream;
        NSOutputStream *outputStream = (__bridge_transfer NSOutputStream *)writeStream;
        [inputStream setDelegate:self];
        [outputStream setDelegate:self];
        [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        [inputStream open];
        [outputStream open];
        
        NSLog(@"OPEN");
    }
    
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode{
    
    switch(eventCode) {
        case NSStreamEventOpenCompleted:
            NSLog(@"서버 커넥트"); break;
            
        case NSStreamEventHasBytesAvailable:
        {
            if (length==0) {
                _data = [NSMutableData data];
                
                uint8_t lengthBuf[8];
                len = [(NSInputStream *)aStream read:lengthBuf maxLength:8];
                
                length = atol((const char*)lengthBuf);
                NSLog(@"length = %ld",length);
                
                return;
            }
            
            else {
                for (int i=0; i<length/1024+1; i++) {
                    
                    uint8_t buf[1024];
                    
                    len = [(NSInputStream *)aStream read:buf maxLength:1024];
                    
                    
                    [_data appendBytes:(const void *)buf length:len];
                    
                }
                
                
                NSLog(@"%zd",_data.length);
                
                UIImage *image = [UIImage imageWithData:_data];
                
                [_imageView setImage:image];
                
                
                length=0;
            }
            
            
            
            
            
            
//            buf[len] = '\0';
            
//            NSData *imgData = [NSData dataWithBytes:buf length:length];
            
//            NSLog(@"%zd",atol((const char*)buf));
            
            
            break;
        }
            
        case NSStreamEventEndEncountered:
        {
            NSLog(@"close");
            [aStream close];
            [aStream removeFromRunLoop:[NSRunLoop currentRunLoop]
                               forMode:NSDefaultRunLoopMode];
            aStream = nil; // stream is ivar, so reinit it
            break;
        }
            
        default:
            break;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
