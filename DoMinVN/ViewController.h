//
//  ViewController.h
//  DoMinVN
//
//  Created by Bao on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Min.h"
#import "TopAlert.h"


@interface ViewController : UIViewController
{
    NSMutableArray *listMin;
    int soDong;
    int soCot;
    int soMin;
}
@property int soDong;
@property int soCot;
@property int soMin;
@property int dem;
@property int thoiGianPlay;
@property int manChoi;
@property int datCo; // 0 la chua dat, 1 la dang dat
@property (nonatomic, retain) TopAlert *alertView;
@property (nonatomic, retain) NSTimer *timer;
@property (nonatomic, retain) UILabel *labelTime;
@property (nonatomic, retain) UILabel *labelManChoi;
@property (nonatomic, retain) UIButton *btnDatCo;
    
- (void)lanTruyenOMin:(int)_x _y:(int)_y;
- (void) openAll;
- (void) drawMinNo:(int)x y:(int)y;
- (void) loadMin;
- (void) hamDemThoiGian;
- (void) nhanDatCo;
- (void) initMangTrangThai;
- (void) newGame;
- (void)quaMan;
- (BOOL)kiemTraWin;
- (void)initManChoi;
@end
