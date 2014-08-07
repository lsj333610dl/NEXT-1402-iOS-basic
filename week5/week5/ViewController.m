//
//  ViewController.m
//  week5
//
//  Created by 이상진 on 2014. 8. 7..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import "ViewController.h"

#define IMG_HEIGHT 200
#define IMG_WIDTH 320
#define SCROLL (int)scrollView.contentOffset.y/IMG_HEIGHT

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [_scrollView setDelegate:self];
    filenameArray = [NSMutableArray new];
    imageViewArray = [NSMutableArray new];
    
    for (int i=1; i<23; i++) {
        
        NSString *filename = [NSString stringWithFormat:@"%02d.jpg",i];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
        [filenameArray addObject:filePath];
        [imageViewArray addObject:[NSNull null]];
    }
    
    [_scrollView setContentSize:CGSizeMake(_scrollView.frame.size.width, IMG_HEIGHT*22)];
  
    [_scrollView setContentMode:UIViewContentModeScaleAspectFill];

    
    [self drawFirstImage];
    
    NSLog(@"%zd",[imageViewArray count]);
    
//    for (int i=0; i<[imgArray count]; i++) {
//        
//        UIImageView *imageView = [[UIImageView alloc]initWithImage:[imgArray objectAtIndex:i]];
//        
//        [imageView setFrame:CGRectMake(0, IMG_HEIGHT*i, IMG_WIDTH, IMG_HEIGHT)];
//        
//        [imageViewArray addObject:imageView];
//        
//        [_scrollView addSubview:[imageViewArray objectAtIndex:i]];
//        
//    }
    
    
    
}

- (void)drawFirstImage{
    [self addImageAtIndex:0];
    [self addImageAtIndex:1];
    [self addImageAtIndex:2];
    [self addImageAtIndex:3];
}

- (void)drawLastImage{
    
}



- (void)addImageAtIndex:(NSUInteger)index{
    if ([imageViewArray objectAtIndex:index]==[NSNull null]) {
        UIImage *image = [UIImage imageWithContentsOfFile:[filenameArray objectAtIndex:index]];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        [imageView setFrame:CGRectMake(0, IMG_HEIGHT*index, IMG_WIDTH, IMG_HEIGHT)];
        [imageViewArray replaceObjectAtIndex:index withObject:imageView];
        
        [_scrollView addSubview:[imageViewArray objectAtIndex:index]];
    }
    
    
}

- (void)removeImageAtIndex:(NSUInteger)index{
    if ([imageViewArray objectAtIndex:index] != [NSNull null]) {
        [[imageViewArray objectAtIndex:index] setImage:nil];
        [[imageViewArray objectAtIndex:index] removeFromSuperview];
        [imageViewArray replaceObjectAtIndex:index withObject:[NSNull null]];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"%d",(int)scrollView.contentOffset.y/IMG_HEIGHT);

    if (SCROLL<=0) {
        [self addImageAtIndex:0];
        [self addImageAtIndex:1];
        [self addImageAtIndex:2];
        [self addImageAtIndex:3];
        [self addImageAtIndex:4];
    }
    
    else if (SCROLL==1){
        [self removeImageAtIndex:SCROLL-1];
        [self addImageAtIndex:SCROLL];
        [self addImageAtIndex:SCROLL+1];
        [self addImageAtIndex:SCROLL+2];
        [self addImageAtIndex:SCROLL+3];
        [self addImageAtIndex:SCROLL+4];
    }
    
    else if(SCROLL>=2 && SCROLL<18){
        [self removeImageAtIndex:SCROLL-2];
        [self removeImageAtIndex:SCROLL-1];
        [self addImageAtIndex:SCROLL];
        [self addImageAtIndex:SCROLL+1];
        [self addImageAtIndex:SCROLL+2];
        [self addImageAtIndex:SCROLL+3];
        [self addImageAtIndex:SCROLL+4];
    }
    
    else if(SCROLL>=18){
        [self removeImageAtIndex:17];
        [self addImageAtIndex:18];
        [self addImageAtIndex:19];
        [self addImageAtIndex:20];
        [self addImageAtIndex:21];
    }
    
    
//    [imgArray removeAllObjects];
//    [imageViewArray removeAllObjects];
    
//    [imageViewArray ]
    
//    [[imageViewArray objectAtIndex:(int)scrollView.contentOffset.y/IMG_HEIGHT] setImage:nil];
    
//    switch ((int)scrollView.contentOffset.y/IMG_HEIGHT) {
//        case 0:
//            break;
//            
//        case 3:
//            
//            break;
//            
//        case 19:
//            
//            break;
//            
//        default:
//            break;
//    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
