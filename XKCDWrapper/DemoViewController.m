//
//  DemoViewController.m
//  XKCDWrapper
//
//  Created by Matthew Mascioni on 2014-04-26.
//  Copyright (c) 2014 Matthew Mascioni. All rights reserved.
//

#import "DemoViewController.h"
#import "XKCDWrapper.h"
#import "XKCDComic.h"

@interface DemoViewController ()

@property (nonatomic) UIImageView *imageView;

@end

@implementation DemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0.24f alpha:1.0f];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHue:0 saturation:0 brightness:0.24f alpha:1.0f];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, 320, 320)];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.view addSubview:self.imageView];
    
    [XKCDWrapper getComicWithId:0 withCompletionBlock:^(XKCDComic *comic, NSError *error) {
        self.imageView.image = comic.image;
        self.navigationItem.title = comic.title;
    }];
    
    [XKCDWrapper getRandomComicWithCompletionBlock:^(XKCDComic *comic, NSError *error) {
        
    }];
}

@end
