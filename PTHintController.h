//
//  PTHintController.h
//
//  Created by Sergey Lenkov on 26.08.11.
//  Copyright 2011 Positive Team. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface PTHintController : UIViewController {
    IBOutlet UILabel *textLabel;
    NSString *text;
}

@property (nonatomic, retain) UILabel *textLabel;
@property (nonatomic, copy) NSString *text;

+ (PTHintController *)sharedHint;
+ (PTHintController *)hintControllerWithText:(NSString *)newText;

- (void)showInView:(UIView *)parentView duration:(NSInteger)duration;
- (void)hide;

@end