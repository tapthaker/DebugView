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

const NSInteger kRandomViewTAG = 356;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *randomizeButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 22, 150, 44)];
    [randomizeButton setTitle:@"RANDOMIZE" forState:UIControlStateNormal];
    randomizeButton.backgroundColor=[UIColor blackColor];
    [randomizeButton addTarget:self action:@selector(onButtonRandomizeClicked:) forControlEvents:UIControlEventTouchUpInside];

    [self generateRandomViews];
    
    [self.view addSubview:randomizeButton];
    
}

-(void)onButtonRandomizeClicked:(UIButton*)sender{
    
    [self removeRandomViews];
    [self generateRandomViews];
    [self.view bringSubviewToFront:sender];
}

-(void)generateRandomViews{
    
    int width = self.view.frame.size.width;
    int height = self.view.frame.size.height;
    const int minimumLength = 20;
    
    for (int i=0;i<15;i++) {
        
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(onViewPanned:)];
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onViewDoubleTapped:)];
        tapGestureRecognizer.numberOfTapsRequired=2;
        
        int x = arc4random()%width;
        int y = arc4random()%height;
        int w = arc4random()%(width-x-minimumLength)+minimumLength;
        int h = arc4random()%(height-y-minimumLength)+minimumLength;
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(x,y,w,h)];
        view.backgroundColor=[self randomColor];
        [view addGestureRecognizer:panGestureRecognizer];
        [view addGestureRecognizer:tapGestureRecognizer];
        view.userInteractionEnabled=YES;
        view.tag=kRandomViewTAG;
        [self.view addSubview:view];
        
    }
    
    
}

-(void)onViewPanned:(UIPanGestureRecognizer*)gesture{
    
    CGPoint translation = [gesture translationInView:self.view];
    gesture.view.frame = CGRectOffset(gesture.view.frame, translation.x, translation.y);
    [gesture setTranslation:CGPointMake(0, 0) inView:self.view];

}

-(void)onViewDoubleTapped:(UITapGestureRecognizer*)gesture{
    
    if (gesture.state==UIGestureRecognizerStateEnded) {
    [UIView animateWithDuration:0.3 animations:^{
        gesture.view.frame=CGRectMake(gesture.view.center.x,gesture.view.center.y,0 ,0 );

    } completion:^(BOOL finished) {
        [gesture.view removeFromSuperview];
    }];
    }
    
    
}

-(UIColor*)randomColor{
    
    float r = (arc4random()%255/255.0);
    float g = (arc4random()%255/255.0);
    float b = (arc4random()%255/255.0);

    
    return [UIColor colorWithRed:r green:g blue:b alpha:0.5];
}

-(void)removeRandomViews{
    UIView *removeView;
    while((removeView = [self.view viewWithTag:kRandomViewTAG]) != nil) {
        [removeView removeFromSuperview];
        
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
