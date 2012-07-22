//
//  TopAlert.m
//  DoMinVN
//
//  Created by Bao on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "TopAlert.h"
#import "ViewController.h"

UIColor *sysBlueColor(float percent)
{
    float red = percent*255.0f;
    float green = (red + 20.0f)/255.0f;
    float blue = (red + 45.0f)/255.0f;
    if (green > 1.0) green = 1.0f;
    if (blue > 1.0f) blue = 1.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}
@implementation TopAlert
@synthesize parent;
/*
- (void) setParent: (ViewController*) _parent
{
    [self setParent:_parent];
}
 */

- (void) setTitle:(NSString *)titleText
{
    [(UILabel*)[self viewWithTag:TITLE_TAG] setText:titleText];
}

- (void) setMessage:(NSString *)messageText
{
    [(UILabel*)[self viewWithTag:MESSAGE_TAG] setText:messageText];
}



- (id)initWithFrame:(CGRect)rect
{
    rect.origin.y = 20.0f - rect.size.height;
    self = [super initWithFrame:rect];
    [self setAlpha:0.6];
    [self setBackgroundColor:[UIColor blueColor]];
    
    
    
    UIButton *new = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    new.frame = CGRectMake(80.0f, 50.0f, 160.0f, 50.0f);
    [new setAlpha:1.0f];
    [new setTitle:@"Chơi Mới" forState:UIControlStateNormal];
    [new setBackgroundImage:[UIImage imageNamed:@"whiteButton.png"] forState:UIControlStateNormal];
    [new setTitle:@"Chơi Mới" forState:UIControlStateHighlighted];
    [new setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [new addTarget:self action:@selector(newGame) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:new];
    
    UIButton *tieptuc = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [tieptuc setAlpha:1.0f];
    tieptuc.frame = CGRectMake(80.0f, 110.0f, 160.0f, 50.0f);
    [tieptuc setTitle:@"Chơi tiếp" forState:UIControlStateNormal];
    [tieptuc setBackgroundImage:[UIImage imageNamed:@"whiteButton.png"] forState:UIControlStateNormal];
    [tieptuc setTitle:@"Chơi tiếp" forState:UIControlStateHighlighted];
    [tieptuc setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [tieptuc addTarget:self action:@selector(loadMin) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:tieptuc];
    
    UIButton *exit = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [exit setAlpha:1.0f];
    exit.frame = CGRectMake(80.0f, 170.0f, 160.0f, 50.0f);
    [exit setTitle:@"Thoát" forState:UIControlStateNormal];
    [exit setBackgroundImage:[UIImage imageNamed:@"whiteButton.png"] forState:UIControlStateNormal];
    [exit setTitle:@"Thoát" forState:UIControlStateHighlighted];
    [exit setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [exit addTarget:self action:@selector(exitGame) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:exit];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setAlpha:1.0f];
    button.frame = CGRectMake(80.0f, 230.0f, 160.0f, 50.0f);
    [button setTitle:@"Quay Lại" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"whiteButton.png"] forState:UIControlStateNormal];
    [button setTitle:@"Quay Lại" forState:UIControlStateHighlighted];
    
    [button setFont:[UIFont boldSystemFontOfSize:14.0f]];
    [button addTarget:self action:@selector(removeView) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 15.0, 320.0, 32.0)];
    title.text = @"Menu";
    title.textAlignment = UITextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    title.font = [UIFont boldSystemFontOfSize:20.0f];
    [self addSubview:title];
    
    /*
    UILabel *message = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 40.0f, 280.0f, 200.0f - 48.0f)];
    message.text = @"Nguyen Tien Bao - DH Khoa Hoc Tu nhien - DH Quoc Gia TPHCM";
    message.textAlignment = UITextAlignmentCenter;
    message.numberOfLines = 999;
    message.textColor = [UIColor whiteColor];
    message.backgroundColor = [UIColor clearColor];
    message.lineBreakMode = UILineBreakModeWordWrap;
    message.font = [UIFont boldSystemFontOfSize:20.0f];
    [self addSubview:message];
     */
    
    return self;
}

- (void) removeView
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.5];
    CGRect rect = [self frame];
    rect.origin.y = -10.0f - rect.size.height;
    [self setFrame:rect];
    [UIView commitAnimations];
}

- (void) loadMin // New game
{
    [(ViewController*)parent loadMin];
}

- (void) newGame // New game
{
    [(ViewController*)parent newGame];
}

- (void) presentView
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.5];
    CGRect rect = [self frame];
    rect.origin.y = 0.0f;
    [self setFrame:rect];
    [UIView commitAnimations];
}

- (void) exitGame
{
    exit(0);
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


@end