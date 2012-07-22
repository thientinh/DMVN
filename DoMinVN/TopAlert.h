//
//  TopAlert.h
//  DoMinVN
//
//  Created by Bao on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


#define TITLE_TAG 999
#define MESSAGE_TAG 998
@interface TopAlert : UIView {
       
}
- (void) setTitle: (NSString*) titleText;
- (void) setMessage: (NSString*) messageText;
- (void) presentView;
- (void) removeView;
- (void) setParent: (UIViewController*) _parent;
@property (nonatomic, retain) UIViewController *parent;
- (void) loadMin; // new game
- (void) newGame;
- (void) exitGame;
@end
