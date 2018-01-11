//
//  FFPDFDocument.m
//  PDFPreView
//
//  Created by fjq on 2018/1/10.
//  Copyright © 2018年 fangjq. All rights reserved.
//

#import "FFPDFDocument.h"


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
    if (newDocument != nil) {
        NSString *urlString = @"file:///Users/fjq/Desktop/1.pdf";
        [newDocument writeToURL:[NSURL URLWithString:urlString]];
        [newDocument writeToFile:@"f.pdf"];
    }
}
- (NSInteger)pageNum {
    return _pageNum;
}
- (NSURL *)url {
    return _url;
}

@end
