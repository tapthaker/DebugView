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
@dynamic debugFrameView;

-(void)setDebugFrameView:(DebugFrameView *)debugFrameView{
    objc_setAssociatedObject(self, @selector(debugFrameView), debugFrameView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(DebugFrameView*)debugFrameView{
    return objc_getAssociatedObject(self, @selector(debugFrameView));
}

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
        
#ifndef NO_DEBUG_VIEW

        [self swizzleSelector:@selector(init) withSelector:@selector(init_debug)];
        [self swizzleSelector:@selector(awakeFromNib) withSelector:@selector(awakeFromNib_debug)];
        [self swizzleSelector:@selector(initWithFrame:) withSelector:@selector(initWithFrame_debug:)];
        [self swizzleSelector:@selector(setFrame:) withSelector:@selector(setFrame_debug:)];
#endif
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

    self.debugFrameView = [[DebugFrameView alloc]initWithFrame_debug:self.bounds];
    [self addSubview:self.debugFrameView];
}




-(void)setFrame_debug:(CGRect)frame{
    
    [self setFrame_debug:frame];
    self.debugFrameView.frame=self.bounds;
    [self.debugFrameView setNeedsDisplay];
}



@end
