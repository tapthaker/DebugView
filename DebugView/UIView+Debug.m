//
//  UIView+Debug.m
//  Pray
//
//  Created by Tapan Thaker on 29/08/14.
//  Copyright (c) 2014 Tapan. All rights reserved.
//

#import "UIView+Debug.h"
#import <objc/runtime.h>

@implementation UIView (Debug)

static DebugFrameView *debugFrameView =nil;


+ (void)swizzleSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector {
    
    Class class = [self class];
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    
    
    BOOL didAddMethodInit=class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethodInit) {
        class_addMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+(void)load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSelector:@selector(init) withSelector:@selector(init_debug)];
        [self swizzleSelector:@selector(awakeFromNib) withSelector:@selector(awakeFromNib_debug)];
        [self swizzleSelector:@selector(initWithFrame:) withSelector:@selector(initWithFrame_debug:)];
        [self swizzleSelector:@selector(didAddSubview:) withSelector:@selector(didAddSubview_debug:)];
        [self swizzleSelector:@selector(willRemoveSubview:) withSelector:@selector(willRemoveSubview_debug:)];
         [self swizzleSelector:@selector(setFrame:) withSelector:@selector(setFrame_debug:)];
    });
}

-(id)init_debug{
    
    self = [self init_debug];
    [self commonInitialization];
    return self;
}

-(void)awakeFromNib_debug{
    [self commonInitialization];
}

-(id)initWithFrame_debug:(CGRect)frame{
    self = [self initWithFrame_debug:frame];
    [self commonInitialization];
    return self;
}

-(void)commonInitialization{
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.layer.borderWidth = 1.0;

    if ([self isKindOfClass:[UIWindow class]]) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            debugFrameView=[[DebugFrameView alloc]init];
            [self addSubview:debugFrameView];
        });
    }
}

-(void)didAddSubview_debug:(UIView *)subview{
    [self didAddSubview_debug:subview];
    
    [self.window bringSubviewToFront:debugFrameView];
    [debugFrameView.views addObject:subview];
    [debugFrameView setNeedsDisplay];
}

-(void)willRemoveSubview_debug:(UIView *)subview{
    [self willRemoveSubview_debug:subview];
    
    [debugFrameView.views removeObject:subview];
    [debugFrameView setNeedsDisplay];
}

-(void)setFrame_debug:(CGRect)frame{
    
    [self setFrame_debug:frame];
    
    [debugFrameView setNeedsDisplay];
    
}



@end
