//
//  PTHintController.m
//
//  Created by Sergey Lenkov on 26.08.11.
//  Copyright 2011 Positive Team. All rights reserved.
//

#import "PTHintController.h"

static PTHintController *sharedInstance = nil;

@implementation PTHintController

@synthesize textLabel;
@synthesize text;

+ (PTHintController *)sharedHint {
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [[PTHintController alloc] initWithNibName:@"PTHintView" bundle:nil];
        }
    }
    
    return sharedInstance;
}

+ (PTHintController *)hintControllerWithText:(NSString *)aText {
    PTHintController *controller = [[[PTHintController alloc] initWithNibName:@"PTHintView" bundle:nil] autorelease];
    controller.text = aText;
    
    return controller;
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    
    if (self) {
        self.text = @"";
    }
    
    return self;
}

- (void)dealloc {
    [textLabel release];
    [text release];
    [super dealloc];
}

- (void)setText:(NSString *)newText {
    if (text != newText) {
        [text release];
        text = [newText copy];
    }
}

- (void)showInView:(UIView *)parentView duration:(NSInteger)duration {
    self.view.alpha = 0.0;
    self.view.center = parentView.center;
    
    [parentView addSubview:self.view];
    textLabel.text = text;
    
    [UIView beginAnimations:@"TabFadeIn" context:nil];
	[UIView setAnimationDuration:0.5];
    
	self.view.alpha = 1.0;
    
	[UIView commitAnimations];
    
    if (duration > 0) {
        [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(hide) userInfo:nil repeats:NO];
    }
}

- (void)hide {
    [UIView beginAnimations:@"TabFadeOut" context:nil];
	[UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    
	self.view.alpha = 0.0;
    
	[UIView commitAnimations];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.view removeFromSuperview];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self hide];
}

@end
