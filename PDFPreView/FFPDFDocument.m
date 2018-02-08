//
//  FFPDFDocument.m
//  PDFPreView
//
//  Created by fjq on 2018/1/10.
//  Copyright © 2018年 fangjq. All rights reserved.
//

#import "FFPDFDocument.h"
#import "FCFileManager.h"
#import "FJFileManager.h"


@implementation FFPDFDocument{
    NSInteger _pageNum;
    NSURL *_url;
    PDFDocument *document;
    PDFDocument *newDocument;
}
- (instancetype)initDocumentWithURL:(NSURL *)pdfURL
{
    self = [super init];
    if (self) {
        _url = pdfURL;
        _pageRange = FFMakePageRange(1, 1);
         document = [[PDFDocument alloc]initWithURL:pdfURL];
        _savePath = @"/Users/fjq/Desktop";
    }
    return self;
}

- (void)beginToExtractPageCompleted:(Completed)completed {
    [self beginToExtractPageWithRange:_pageRange completed:completed];
}

- (void)beginToExtractPageWithRange:(FFPageRange)pageRange completed:(Completed)completed
{
    NSAssert(pageRange.startIndex <= pageRange.endIndex, @"开始页编码大于结束页编码");
    NSAssert(pageRange.startIndex >= 1, @"开始页编码小于1");
    NSAssert(pageRange.endIndex >= 1, @"结束页编码小于1");
    NSInteger startIndex = pageRange.startIndex - 1;
    NSInteger endIndex = pageRange.endIndex - 1;
    
    NSInteger pageCount = document.pageCount;
    if (endIndex > pageCount) {
        endIndex = pageCount;
    }
    if (startIndex > endIndex) {
        startIndex = endIndex;
    }
    PDFPage *page1 = [document pageAtIndex:startIndex];
    PDFPage *page2 = [document pageAtIndex:endIndex];
    
    PDFSelection *selection =  [document selectionFromPage:page1 atCharacterIndex:0 toPage:page2 atCharacterIndex:0];
    
    newDocument = [[PDFDocument alloc]init];
    NSArray *pages = selection.pages;
    for (NSInteger i =0; i < pages.count; i++) {
        PDFPage *page = [pages objectAtIndex:i];
        [newDocument insertPage:page atIndex:i];
    }
    if (completed) {
        completed(self);
    }
}

- (void)saveNewPDF {
    [self saveNewPDFWithPath:_savePath];
}

- (void)saveNewPDFWithPath:(NSString *)path
{
    if (newDocument != nil) {
//        NSString *urlString = [NSString stringWithFormat:@"file://%@/sample.pdf",path];;
//        BOOL success = [newDocument writeToURL:[NSURL URLWithString:urlString]];
        
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        NSArray *arr = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
//        NSString *documentPath = [arr firstObject];
//        NSString *filpath = [documentPath stringByAppendingPathComponent:@"sample.pdf"];
//
//        BOOL exict = [fileManager fileExistsAtPath:filpath];
//
//        if (exict) {
//            NSLog(@"文件不存在");
//        }
//        else{
//
//        }
//        BOOL success = [newDocument writeToFile:@"/Users/fjq/Desktop/sample.pdf"];
//
//        if (success) {
//            NSLog(@"写入成功");
//        }
//        else{
//            NSLog(@"写入失败");
//        }
        
        [FJFileManager createDirectoryOnDesktop];
    }
}
- (NSInteger)pageNum {
    return _pageNum;
}
- (NSURL *)url {
    return _url;
}

@end
