//
//  Min.h
//  DoMinVN
//
//  Created by Bao on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
#import <AudioToolbox/AudioServices.h>
#import <UIKit/UIKit.h>

@interface Min : UIButton 
{
    int min_x;
    int min_y;
    int trangThai; // 0 la o chua mo, 1 la mo, -1 la dat co
    int soMin; // so luong min xung quanh
    //ViewController *parent;
    SystemSoundID beep;
    SystemSoundID minwav;
    SystemSoundID cowav;
    SystemSoundID quamanwav;
    
}
@property int min_x;
@property int min_y;
@property int trangThai;
@property int soMin;
@property (nonatomic, retain) UIViewController *parent;
- (void) initMin: (int)x y:(int)y _parent:(UIViewController*)_parent;
-(void)setLanTruyen: (NSString*)string;
- (void)drawMin;


@end
