//
//  ViewController.m
//  PDFPreView
//
//  Created by fjq on 2018/1/10.
//  Copyright © 2018年 fangjq. All rights reserved.
//

#import "ViewController.h"
#import <Quartz/Quartz.h>
#import "FFPDFDocument.h"
#import "FJFileManager.h"



@interface ViewController()<NSTableViewDelegate,NSTableViewDataSource,PDFDocumentDelegate>
@property (weak) IBOutlet NSTextField *startIndexTF;//默认1
@property (weak) IBOutlet NSTextField *endIndexTF;//默认1
@property (weak) IBOutlet NSTableView *leftTableView;
@property (weak) IBOutlet NSTableView *rightTableView;

@end

@implementation ViewController {
    NSMutableArray *_fileURLs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _fileURLs = [NSMutableArray array];

    
//    [self createPdf];
}
- (IBAction)openPDFFileClick:(id)sender {
    
    [_fileURLs removeAllObjects];
    
    NSOpenPanel *openPanel = [[NSOpenPanel alloc]init];
    openPanel.canChooseFiles = YES;
    openPanel.canChooseDirectories = false;
    openPanel.allowsMultipleSelection = YES;
    openPanel.allowedFileTypes = @[@"pdf",@"PDF"];
    openPanel.prompt = @"选择pdf文件";
    
    [openPanel beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse result) {
        NSArray *URLs = openPanel.URLs;
        [_fileURLs addObjectsFromArray:URLs];
        NSLog(@"----%@----",_fileURLs);
        NSString *fileName = [[_fileURLs objectAtIndex:0] lastPathComponent];
        NSLog(@"----%@----",fileName);
        [self.leftTableView reloadData];
    }];
    //"file:///Users/fjq/Documents/asdqwe.pdf"
}

- (IBAction)runClick:(id)sender {
    [self document];

}
- (IBAction)openInFinder:(id)sender {
    [FJFileManager createDirectoryOnDesktop];
}

#pragma mark - tableViewDelegate

#pragma mark - tableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    if (tableView == self.leftTableView) {
        return _fileURLs.count;
    }
    else {
        return 3;
    }

}
- (nullable id)tableView:(NSTableView *)tableView objectValueForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row {
    if (tableView == self.leftTableView) {
        return [_fileURLs[row] lastPathComponent];
    }
    else {
        return @"12";
    }
    
}
- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)document {
    NSURL *url = [_fileURLs firstObject];
    FFPDFDocument *document = [[FFPDFDocument alloc]initDocumentWithURL:url];
    NSInteger startIndex = 1;
    NSInteger endIndex = 2;
    if (![[_startIndexTF stringValue] isEqualToString:@""]) {
        startIndex = [[_startIndexTF stringValue] integerValue];
    }
    if (![[_endIndexTF stringValue] isEqualToString:@""]) {
        endIndex = [[_endIndexTF stringValue] integerValue];
    }
    [document beginToExtractPageWithRange:FFMakePageRange(startIndex, endIndex) completed:^(FFPDFDocument *document) {
        [document saveNewPDF];
    }];
   
}



#pragma mark - PDFDoucumentDelegate
- (void)documentDidEndPageFind:(NSNotification *)notification
{
    
}




@end
