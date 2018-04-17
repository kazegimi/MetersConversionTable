//
//  URLDownloader.h
//  MetersConversionTable
//
//  Created by Eiichi Hayashi on 2018/04/13.
//  Copyright © 2018年 skyElements. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol URLDownloaderDelegate

@optional

- (void)didFinishDownloadingWithData:(NSData *)data;
- (void)didFailDownloading;

@end

@interface URLDownloader : NSObject <NSURLSessionDelegate>

@property (strong, nonatomic) id<URLDownloaderDelegate> delegate;

- (void)startDownloading:(NSString *)urlString;

@end
