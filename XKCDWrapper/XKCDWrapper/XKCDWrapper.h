//
//  XKCDWrapper.h
//  XKCDWrapper
//
//  Created by Matthew Mascioni on 2014-04-26.
//  Copyright (c) 2014 Matthew Mascioni. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XKCDComic;

typedef void (^MMComicReturnBlock)(XKCDComic *comic, NSError *error);

@interface XKCDWrapper : NSObject

/**
 * Returns a comic wrapped in an XKCDComic object based on the comic number you specify with a completion block. If 0 is passed for comicId, today's comic will be returned.
 * @param comicId The comic number to retrieve.
 * @param completionBlock The completion handler you update your UI in with the data returned.
 */

+ (void)getComicWithId:(NSUInteger)comicId withCompletionBlock:(MMComicReturnBlock)completionBlock;

/**
 * Returns a random comic wrapped in an XKCDComic object with a completion block.
 * @param completionBlock The completion handler you update your UI in with the data returned.
 */

+ (void)getRandomComicWithCompletionBlock:(MMComicReturnBlock)completionBlock;

@end
