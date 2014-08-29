//
//  ViewController.m
//  DebugView
//
//  Created by Tapan Thaker on 29/08/14.
//  Copyright (c) 2014 Tapan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self generateRandomViews];
}

-(void)generateRandomViews{
    
    int width = self.view.frame.size.width;
    int height = self.view.frame.size.height;
    const int minimumLength = 20;
    
    for (int i=0;i<15;i++) {
        
        int x = arc4random()%width;
        int y = arc4random()%height;
        int w = arc4random()%(width-x-minimumLength)+minimumLength;
        int h = arc4random()%(height-y-minimumLength)+minimumLength;
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(x,y,w,h)];
        view.backgroundColor=[self randomColor];
        
        [self.view addSubview:view];
        
    }
    
    
}

-(UIColor*)randomColor{
    
    float r = (arc4random()%255/255.0);
    float g = (arc4random()%255/255.0);
    float b = (arc4random()%255/255.0);

    
    return [UIColor colorWithRed:r green:g blue:b alpha:0.5];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
