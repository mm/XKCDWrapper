//
//  XKCDWrapper.m
//  XKCDWrapper
//
//  Created by Matthew Mascioni on 2014-04-26.
//  Copyright (c) 2014 Matthew Mascioni. All rights reserved.
//

#import "XKCDWrapper.h"
#import "XKCDComic.h"

@implementation XKCDWrapper

static NSString *baseURLString = @"http://xkcd.com/";

+ (void)getComicWithId:(NSUInteger)comicId withCompletionBlock:(MMComicReturnBlock)completionBlock {
    
    NSString *requestString;
    
    if (comicId != 0) {
        requestString = [NSString stringWithFormat:@"%@%i/%@", baseURLString, comicId, @"/info.0.json"];
    } else {
        requestString = [NSString stringWithFormat:@"%@%@", baseURLString, @"/info.0.json"];
    }
    
    NSURL *requestURL = [NSURL URLWithString:requestString];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSData *downloadedData = [NSData dataWithContentsOfURL:location];
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:downloadedData options:0 error:&error];
            
            XKCDComic *comic = [[XKCDComic alloc] init];
            NSURL *imageURL = [NSURL URLWithString:[dataDictionary objectForKey:@"img"]];
            NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
            comic.title = [dataDictionary objectForKey:@"safe_title"];
            comic.image = [UIImage imageWithData:imageData];
            comic.altText = [dataDictionary objectForKey:@"alt"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(comic, error);
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(nil, error);
            });
        }
    }];
    
    [task resume];
}

+ (void)getRandomComicWithCompletionBlock:(MMComicReturnBlock)completionBlock {
    
    NSString *requestString = [NSString stringWithFormat:@"%@%@", baseURLString, @"/info.0.json"];
    
    NSURL *requestURL = [NSURL URLWithString:requestString];
    NSURLRequest *request = [NSURLRequest requestWithURL:requestURL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            NSString *maxString = [dataDictionary objectForKey:@"num"];
            NSUInteger max = [maxString integerValue];
            
            NSUInteger randomNumber = arc4random_uniform(max);
            
            NSLog(@"%lu", (unsigned long)randomNumber);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getComicWithId:randomNumber withCompletionBlock:completionBlock];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                completionBlock(nil, error);
            });
        }
    }];
    
    [dataTask resume];
}

@end
