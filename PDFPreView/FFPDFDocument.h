//
//  FFPDFDocument.h
//  PDFPreView
//
//  Created by fjq on 2018/1/10.
//  Copyright © 2018年 fangjq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Quartz/Quartz.h>

typedef struct {
    NSInteger startIndex;
    NSInteger endIndex;
} FFPageRange;

NS_INLINE FFPageRange FFMakePageRange(NSInteger startIndex, NSInteger endIndex) {
    FFPageRange range;
    range.startIndex = startIndex;
    range.endIndex = endIndex;
    return range;
}

@class FFPDFDocument;

typedef void(^Completed)(FFPDFDocument *document);


@interface FFPDFDocument : NSObject

@property (nonatomic, readonly) NSInteger pageNum;
@property (nonatomic, readonly) NSURL *url;
@property (nonatomic, strong) NSString *savePath;

/**
 需要提取的页面范围 默认(1,1)
 */
@property (nonatomic) FFPageRange pageRange;

- (instancetype)initDocumentWithURL:(NSURL *)pdfURL;

/**
 开始提取页面
 */
- (void)beginToExtractPageCompleted:(Completed)completed;

/**
 依据页面范围开始提取页面

 @param pageRange 需要提取的页面范围
 */
- (void)beginToExtractPageWithRange:(FFPageRange)pageRange completed:(Completed)completed;

/**
 保存新的pdf文件
 */
- (void)saveNewPDF;
- (void)saveNewPDFWithPath:(NSString *)path;
@end
