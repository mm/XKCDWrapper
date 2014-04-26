# XKCDWrapper

I've always enjoyed reading the hilarious comics from [XKCD](http://xkcd.com/). There's actually a little [API](http://xkcd.com/json.html) to access these comics, so I felt like messing around and made a little Objective-C wrapper to access them easily in your iPhone applications. 

## Requirements
* Xcode 5.0 or higher
* iOS 7.0 and higher

## Getting Started
Add everything in the *XKCDWrapper* folder to your project, and make sure you have "XKCDWrapper.h" and "XKCDComic.h" imported in whatever implementation files you're using them in. 

## Methods

### Getting a specific comic by ID
Use the *getComicWithId* method on XKCDWrapper as such:

	[XKCDWrapper getComicWithId:1256 withCompletionBlock:^(XKCDComic *comic, NSError *error) {
        // update the UI here, or do other neat stuff
    }];
    
As it fetches the comic asynchronously, it returns a completion block. If you specify 0 for comicId, it will fetch today's comic. The XKCDComic object it returns has a few properties you can access:

* comic.title: The title of the comic
* comic.image: A UIImage object with the comic itself
* comic.altText: The alternate text of the comic

### Getting a random comic
Works almost the same way as getting by ID, except use *getRandomComicWithCompletionBlock:*:

	[XKCDWrapper getRandomComicWithCompletionBlock:^(XKCDComic *comic, NSError *error) {
        
    }];
    
It'll return the same XKCDComic object as the previous method.  

