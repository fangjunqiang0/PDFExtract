//
//  FJFileManager.m
//  PDFPreView
//
//  Created by fjq on 2018/1/12.
//  Copyright © 2018年 fangjq. All rights reserved.
//

#import "FJFileManager.h"

@implementation FJFileManager
+ (NSString *)createFolderNameByDate {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    NSString *folderName = [NSString stringWithFormat:@"PDFPreView %@",[dateFormatter stringFromDate:date]];
    return folderName;
}

+ (NSString *)createFolderPathOnDesktop {
    NSArray *arr = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [arr firstObject];
    NSString *folderPath = [documentPath stringByAppendingPathComponent:[self createFolderNameByDate]];
    return folderPath;;
}
+ (BOOL)isExistFolderPathOnDesktop {
    BOOL isDir;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExist = [fileManager fileExistsAtPath:[self createFolderPathOnDesktop] isDirectory:&isDir];
    if (isExist) {
        NSLog(@"目录存在");
    }
    else {
        NSLog(@"目录不存在");
    }
    return isExist;
}
+ (BOOL)createDirectoryOnDesktop {
    if ([self isExistFolderPathOnDesktop]) {
        return YES;
    }
    NSError *err;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager createDirectoryAtPath:[self createFolderPathOnDesktop] //路径
                          withIntermediateDirectories:YES //创建路径的时候,YES自动创建路径中缺少的目录,NO的不会创建缺少的目录
                                           attributes:nil //属性的字典
                                                error:&err]; //错误对象
    NSLog(@"%@",err);
    if (success) {
        NSLog(@"创建成功");
    }
    else{
        NSLog(@"创建失败");
    }
    return success;
}


@end
