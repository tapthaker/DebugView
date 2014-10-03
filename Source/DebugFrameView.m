//
//  DebugFrameView.m
//  DebugView
//
//  Created by Tapan Thaker on 02/10/14.
//  Copyright (c) 2014 Tapan. All rights reserved.
//

#import "DebugFrameView.h"

@implementation DebugFrameView

-(id)init{
    
    self = [super init];
    if (self) {
    self.views =[[NSMutableArray alloc]init];
    }
    return self;
    
}



-(void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (self.window!=nil) {
        
    for (UIView *view in self.views) {
        [self drawForView:view inContext:context];
    }
        
        
    }
    
}

-(void)didMoveToSuperview{

    [self setNeedsDisplay];
    [self commonSetup];
}

-(void)commonSetup{
    self.backgroundColor=[UIColor clearColor];
    self.frame=self.superview.bounds;
    self.userInteractionEnabled=NO;
}




-(void)drawForView:(UIView*)view inContext:(CGContextRef)context{
    
    const CGFloat padding = 5;
    const CGFloat arrowLength = 5;
    UIFont *font = [UIFont fontWithName: @"Helvetica" size: 8];
    NSMutableParagraphStyle* style = [[NSMutableParagraphStyle alloc] init];
    [style setAlignment:NSTextAlignmentCenter];
    CGRect frame = [self convertRect:view.frame fromView:view.superview];
    CGContextSetLineWidth(context, 1.0);

    
    //FOR WIDTH
    //Drawing Lines
    CGPoint originW = CGPointMake(frame.origin.x+padding, frame.origin.y+frame.size.height-padding);
    CGFloat lineW = frame.size.width-4*padding;

    CGContextMoveToPoint(context, originW.x,originW.y);
    CGContextAddLineToPoint(context,originW.x+lineW/2-2*padding,originW.y);
    CGContextMoveToPoint(context, originW.x+lineW/2+2*padding,originW.y);
    CGContextAddLineToPoint(context,originW.x+lineW,originW.y);
    //Drawing Arrows
    CGContextMoveToPoint(context, originW.x, originW.y);
    CGContextAddLineToPoint(context,originW.x+arrowLength*sqrtf(3)/2, originW.y+arrowLength/2);
    CGContextMoveToPoint(context, originW.x, originW.y);
    CGContextAddLineToPoint(context, originW.x+arrowLength*sqrtf(3)/2, originW.y-arrowLength/2);

    CGContextMoveToPoint(context, originW.x+lineW,originW.y);
    CGContextAddLineToPoint(context,originW.x+lineW-arrowLength*sqrtf(3)/2, originW.y+arrowLength/2);
    CGContextMoveToPoint(context, originW.x+lineW,originW.y);
    CGContextAddLineToPoint(context,originW.x+lineW-arrowLength*sqrtf(3)/2, originW.y-arrowLength/2);
    //Drawing Text
    CGPoint textCenterW =CGPointMake(originW.x+lineW/2-padding, originW.y-padding/2);
    NSString *stringW = [NSString stringWithFormat:@"%0.f",frame.size.width];
    [stringW drawAtPoint:textCenterW withAttributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:style}];
    
    //FOR HEIGHT
    //Drawing Lines
    CGPoint originH = CGPointMake(frame.origin.x+frame.size.width-padding, frame.origin.y+padding);
    CGFloat lineH = frame.size.height-2*padding;
    
    CGContextMoveToPoint(context,originH.x,originH.y);
    CGContextAddLineToPoint(context, originH.x, originH.y+lineH/2-2*padding);
    CGContextMoveToPoint(context, originH.x,originH.y+lineH/2+2*padding);
    CGContextAddLineToPoint(context,originH.x,originH.y+lineH);
    //Drawing Arrows
    CGContextMoveToPoint(context, originH.x, originH.y);
    CGContextAddLineToPoint(context,originH.x+arrowLength/2, originH.y+arrowLength*sqrtf(3)/2);
    CGContextMoveToPoint(context, originH.x, originH.y);
    CGContextAddLineToPoint(context, originH.x-arrowLength/2, originH.y+arrowLength*sqrtf(3)/2);
    
    CGContextMoveToPoint(context, originH.x,originH.y+lineH);
    CGContextAddLineToPoint(context,originH.x+arrowLength/2, originH.y+lineH-arrowLength*sqrtf(3)/2);
    CGContextMoveToPoint(context, originH.x,originH.y+lineH);
    CGContextAddLineToPoint(context,originH.x-arrowLength/2, originH.y+lineH-arrowLength*sqrtf(3)/2);
    //Drawing Text
    CGPoint textCenterH =CGPointMake(originH.x-padding/2, originH.y+lineH/2-padding);
    NSString *stringH = [NSString stringWithFormat:@"%0.f",frame.size.height];
    [stringH drawAtPoint:textCenterH withAttributes:@{NSFontAttributeName:font,NSParagraphStyleAttributeName:style}];
    
    //Drawing View's name in the top-right corner
    NSString *className =  NSStringFromClass([view class]);
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    /// Set line break mode
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    /// Set text alignment
    paragraphStyle.alignment = NSTextAlignmentCenter;
    NSDictionary *attributes = @{ NSFontAttributeName: font,
                                  NSForegroundColorAttributeName: [UIColor blackColor],
                                  NSParagraphStyleAttributeName: paragraphStyle };
    
    CGSize size = [className sizeWithAttributes:attributes];
    
    CGPoint originName = CGPointMake(frame.origin.x+frame.size.width-padding-size.width, frame.origin.y+padding);
    [className drawAtPoint:originName withAttributes:attributes];
    CGContextStrokePath(context);

}


@end
