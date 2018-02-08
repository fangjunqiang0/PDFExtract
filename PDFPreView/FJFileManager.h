//
//  FJFileManager.h
//  PDFPreView
//
//  Created by fjq on 2018/1/12.
//  Copyright © 2018年 fangjq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FJFileManager : NSObject

/**
 创建文件夹名称，按照现在时间

 @return 文件夹名 格式为"yyyy-MM-dd HH-mm-ss“
 */
+ (NSString *)createFolderNameByDate;

/**
 创建目录路径，按照现在时间

 @return 目录路径
 */
+ (NSString *)createFolderPathOnDesktop;

/**
 判断文件夹否存在

 @return BOOL
 */
+ (BOOL)isExistFolderPathOnDesktop;
/**
 创建文件夹，在桌面上

 @return 创建是否成功
 */
+ (BOOL)createDirectoryOnDesktop;
@end
