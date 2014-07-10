//
//  main.m
//  fileAndString
//
//  Created by 이상진 on 2014. 7. 10..
//  Copyright (c) 2014년 EntusApps. All rights reserved.
//

#import <Foundation/Foundation.h>

//void printAllFiles(){
//    //파일 매니저 생성
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    
//    
//    //디렉토리
//    NSURL *directoryURL = [fileManager URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//    
//    NSEnumerator *enumerator = [fileManager enumeratorAtURL:directoryURL includingPropertiesForKeys:@[NSURLNameKey, NSURLIsDirectoryKey, NSURLContentModificationDateKey] options:NSDirectoryEnumerationSkipsHiddenFiles errorHandler:nil];
//    
//    NSLog(@"%@",[enumerator allObjects]);
//}

NSArray* getAllfilesAtPath(NSString* dirPath){
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    
    NSArray *arrayFiles = [fileManager contentsOfDirectoryAtPath:dirPath error:nil];
    
    NSMutableArray *resultArray = [[NSMutableArray alloc]initWithArray:arrayFiles];
    
    for (int i=0; i<[arrayFiles count]; i++) {
        if ([arrayFiles[i] rangeOfString:@"."].location == NSNotFound) {
            
            NSString *deepPath = [NSString stringWithFormat:@"%@/%@",dirPath,arrayFiles[i]];
            
            NSArray *arrayDeepDirFiles = [fileManager contentsOfDirectoryAtPath:deepPath error:nil];
            [resultArray addObjectsFromArray:arrayDeepDirFiles];
        }
    }
    
    return resultArray;
}

BOOL isExistFilenameAtPath(NSString* filename, NSString* dirPath){
    NSArray *files = getAllfilesAtPath(dirPath);
    
    for (int i=0; i<[files count]; i++) {
        if ([files[i] isEqualToString:filename]) {
            return YES;
        }
    }
    
    return NO;
}





int main(int argc, const char * argv[])
{

    @autoreleasepool {
        NSString *DIRPATH = @"/Users/retina15/Dropbox/wordpress/videostar";
        
        //모든 파일 출력
//        NSLog(@"%@",getAllfilesAtPath(dirPath));
        
        //파일 있는지
        NSLog(@"%@", isExistFilenameAtPath(@"logo.png", DIRPATH) ? @"YES" : @"NO");
        NSLog(@"%@", isExistFilenameAtPath(@"notExist.png", DIRPATH) ? @"YES" : @"NO");
    }
    
    return 0;
}
