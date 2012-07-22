//
//  ViewController.m
//  DoMinVN
//
//  Created by Bao on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#define ANIMATION_DURATION (6.0)

@implementation ViewController
@synthesize soDong, soCot, dem, alertView, datCo, timer, thoiGianPlay, labelTime, btnDatCo;
@synthesize manChoi, labelManChoi;
- (id) init{
    if (!(self = [super init])) return self;
    self.title = @"Dò Mìn";
    return self;
}

- (void) newGame
{
    manChoi = 1;
    [self initManChoi];
    [self loadMin];
}
- (void) initMangTrangThai
{
    //listTrangThai = [[NSArray alloc] init];
    for (int i = 0; i< soMin; i++)
    {
        int giatri =  arc4random()%(soCot*soDong-1);
        [[[listMin objectAtIndex:giatri/soCot] objectAtIndex:giatri%soCot] setSoMin:-1];       // [listTrangThai addObject:giatri];
        
    }
    
    for (int k = 0; k<soDong; k++) {
        for (int l = 0; l< soCot; l++)
        {
            
            if ([[[listMin objectAtIndex:k] objectAtIndex:l] soMin] != -1)
            {
                int demSoMin = 0;
                if (l!=0)
                {
                    if ([[[listMin objectAtIndex:k] objectAtIndex:l-1] soMin] == -1)
                    {
                        demSoMin++;
                    }
                }
                if (l!=soCot-1)
                {
                    if ([[[listMin objectAtIndex:k] objectAtIndex:l+1] soMin] == -1)
                    {
                        demSoMin++;
                    }
                }
                if (k!=0)
                {
                    if ([[[listMin objectAtIndex:k-1] objectAtIndex:l] soMin] == -1)
                    {
                        demSoMin++;
                    }
                }
                if (k!=soDong-1)
                {
                    if ([[[listMin objectAtIndex:k+1] objectAtIndex:l] soMin] == -1)
                    {
                        demSoMin++;
                    }
                }
                if (k!=0 && l!=0)
                {
                    if ([[[listMin objectAtIndex:k-1] objectAtIndex:l-1] soMin] == -1)
                    {
                        demSoMin++;
                    }
                }
                if (k!=0 && l!=soCot-1)
                {
                    if ([[[listMin objectAtIndex:k-1] objectAtIndex:l+1] soMin] == -1)
                    {
                        demSoMin++;
                    }
                }
                if (k!=soDong-1 && l!=0)
                {
                    if ([[[listMin objectAtIndex:k+1] objectAtIndex:l-1] soMin] == -1)
                    {
                        demSoMin++;
                    }
                }
                if (k!=soDong-1 && l!=soCot-1)
                {
                    if ([[[listMin objectAtIndex:k+1] objectAtIndex:l+1] soMin] == -1)
                    {
                        demSoMin++;
                    }
                }
                [[[listMin objectAtIndex:k] objectAtIndex:l] setSoMin:demSoMin];
                
            }
        }
    }
}


- (void) loadMin
{
    datCo = 0;
    thoiGianPlay = 60;
    UIView *contentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    [contentView setUserInteractionEnabled:YES];
    self.view = contentView;
    //[contentVi relse];
    listMin = [[NSMutableArray alloc] init];
    //[contentView setBackgroundColor:[UIColor blueColor]];
    [contentView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgplay.png"]]];
    for (int i = 0; i < soDong; i++)
    {
        NSMutableArray *listDong = [[NSMutableArray alloc] init];
        for (int j = 0; j < soCot; j++)
        {
            Min *_min = [[Min alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
            [_min initMin:i y:j _parent:self];
            [_min setCenter:CGPointMake(j*32.0f+30.0f, i*32.0f+30.0f)];
            [listDong addObject:_min];
            [contentView addSubview:_min];
        }
        [listMin addObject:listDong];
    }
    
    [self initMangTrangThai];
    for (int i = 0; i < soDong; i++)
    {
        for (int j = 0; j < soCot; j++)
        {
            Min *a = [[listMin objectAtIndex:i] objectAtIndex:j];
            [a setTitle:[NSString stringWithFormat:@"%d",[a soMin]] forState:UIControlStateNormal];
            [a setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
           // [contentView addSubview:a];
            
        }       
    }
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Do it" style:UIBarButtonItemStylePlain target:self action:@selector(presentSheet)];
    
    self.alertView = [[TopAlert alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 320.0f)];
    [self.alertView setParent:self];
    [self.alertView setCenter:CGPointMake(160.0f, -200.0f)];
    [contentView addSubview:alertView];
    
    
    btnDatCo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnDatCo.frame = CGRectMake(30.0f, 405.0f, 60.0f, 40.0f);
    [btnDatCo setBackgroundImage:[UIImage imageNamed:@"datco.png"] forState:UIControlStateNormal];
    //[btnDatCo setBackgroundImage:[UIImage imageNamed:@"datco.png"] forState:UIControlStateHighlighted];
    [btnDatCo addTarget:self action:@selector(nhanDatCo) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:btnDatCo];  
    
    UIButton *menu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    menu.frame = CGRectMake(233.0f, 405.0f, 60.0f, 40.0f);
    [menu setBackgroundImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
    [menu setBackgroundImage:[UIImage imageNamed:@"menuselect.png"] forState:UIControlStateHighlighted];
    [menu addTarget:self action:@selector(presentSheet) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:menu];
    
    labelTime = [[UILabel alloc] init];
    labelTime.frame = CGRectMake(122, 410.0f, 40.0f, 40.0f);
    [labelTime setText:[NSString stringWithFormat:@"%d",thoiGianPlay]];
    [labelTime setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [labelTime setTextColor:[UIColor blueColor]];
    [labelTime setBackgroundColor:[UIColor clearColor]];
    [contentView addSubview:labelTime];
    
    labelManChoi = [[UILabel alloc] init];
    labelManChoi.frame = CGRectMake(178, 410.0f, 40.0f, 40.0f);
    [labelManChoi setText:[NSString stringWithFormat:@"%d",manChoi]];
    [labelManChoi setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [labelManChoi setTextColor:[UIColor blueColor]];
    [labelManChoi setBackgroundColor:[UIColor clearColor]];
    [contentView addSubview:labelManChoi];
    
    if (timer)
    {
        [timer invalidate];
        timer = nil;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(hamDemThoiGian) userInfo:nil repeats:YES];
}


- (void) doit
{
    CALayer *reflectionLayer = [CALayer layer];
    reflectionLayer.contents = [self.view layer].contents;
    
    reflectionLayer.opacity = 0.4;
    reflectionLayer.frame = CGRectOffset([self.view layer].frame, 0.5, 406.0f+0.5);
    reflectionLayer.transform = CATransform3DMakeScale(1.0, -1.0, 1.0);
    
    reflectionLayer.sublayerTransform = reflectionLayer.transform;
    [[self.view layer] addSublayer:reflectionLayer];
    
    CALayer * shadowLayer = [CALayer layer];
    shadowLayer.frame = reflectionLayer.bounds;
    shadowLayer.delegate = self;
    [shadowLayer setNeedsDisplay];
    [reflectionLayer addSublayer:shadowLayer];
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:ANIMATION_DURATION] forKey:kCATransactionAnimationDuration];
    
    CABasicAnimation *shrinkAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    shrinkAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    shrinkAnimation.toValue = [NSNumber numberWithFloat:0.0];
    [[self.view layer] addAnimation:shrinkAnimation forKey:@"shrinkAnimation"];
    
    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.toValue = [NSNumber numberWithFloat:0.0];
    fadeAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [[self.view layer] addAnimation:shrinkAnimation forKey:@"fadeAnimation"];
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef positionPath = CGPathCreateMutable();
    CGPathMoveToPoint(positionPath, NULL, [self.view layer].position.x, [self.view layer].position.y);
    CGPathAddQuadCurveToPoint(positionPath, NULL, [self.view layer].position.x, -[self.view layer].position.y, [self.view layer].position.x, [self.view layer].position.y);
    
    
    CGPathAddQuadCurveToPoint(positionPath, NULL, [self.view layer].position.x, -[self.view layer].position.y*1.5, [self.view layer].position.x, [self.view layer].position.y);
    
    CGPathAddQuadCurveToPoint(positionPath, NULL, [self.view layer].position.x, -[self.view layer].position.y*2, [self.view layer].position.x, [self.view layer].position.y);
    positionAnimation.path = positionPath;
    positionAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [[self.view layer] addAnimation:positionAnimation forKey:@"positionAnimation"];
    [CATransaction commit];
    //[self loadMin];
}

- (void) loadBanDau
{
    dem++;
    if (dem == 5)
    {
        [self initManChoi];
        [self loadMin];
    }
}

- (void) presentSheet
{
    if (self.alertView) [self.alertView presentView];
}

- (void) loadView
{
    [super loadView];
    
    manChoi = 1;
    thoiGianPlay = 60;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [[[self.view layer] contents] setBackgroundColor:[UIColor whiteColor]];
    UIImageView *content = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    content.image = [UIImage imageNamed:@"Default.png"];
    content.userInteractionEnabled = YES;
    [content setBackgroundColor:[UIColor whiteColor]];
    self.view = content;
    //[super loadView];
    [self.navigationController setNavigationBarHidden:NO];
    
    [self doit];
    dem = 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(loadBanDau) userInfo:nil repeats:YES];
    
}

- (void)lanTruyenOMin:(int)_x _y:(int)_y
{
    [[[listMin objectAtIndex:_x] objectAtIndex:_y] setTrangThai:1];
    if (_x != soDong-1 && [[[listMin objectAtIndex:_x+1] objectAtIndex:_y] trangThai] != 1 && [[[listMin objectAtIndex:_x+1] objectAtIndex:_y] soMin] == 0)
    {
        [self lanTruyenOMin:_x+1 _y:_y];
    }
    if (_x!=0 && [[[listMin objectAtIndex:_x-1] objectAtIndex:_y] trangThai] != 1 && [[[listMin objectAtIndex:_x-1] objectAtIndex:_y] soMin] == 0)
    {
        [self lanTruyenOMin:_x-1 _y:_y];
    }
    if (_y != soCot-1 && [[[listMin objectAtIndex:_x] objectAtIndex:_y+1] trangThai] != 1 && [[[listMin objectAtIndex:_x] objectAtIndex:_y+1] soMin] == 0)
    {
        [self lanTruyenOMin:_x _y:_y+1];
    }
    if (_y!=0 && [[[listMin objectAtIndex:_x] objectAtIndex:_y-1] trangThai] != 1 && [[[listMin objectAtIndex:_x] objectAtIndex:_y-1] soMin] == 0)
    {
        [self lanTruyenOMin:_x _y:_y-1];
    }
    [[[listMin objectAtIndex:_x] objectAtIndex:_y] setLanTruyen:@"+"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


// ---------------------------
- (void) openAll
{
    for (int i = 0; i < soDong; i++)
    {
        for (int j = 0; j < soCot; j++)
        {
            [[[listMin objectAtIndex:i] objectAtIndex:j] setTrangThai:1];
            [[[listMin objectAtIndex:i] objectAtIndex:j] drawMin];
            
        }       
    }
}

- (void) drawMinNo:(int)x y:(int)y // drăw hiệu ứng khi mìn nô?
{
    NSMutableArray *bflies = [[NSMutableArray alloc] init];
    
    for (int i= 0; i<= 16; i++)
    {
        NSString *name = [NSString stringWithFormat:@"mine%d.png", i];
        UIImage *img = [UIImage imageNamed:name];
        if(img) [bflies addObject:img];
    }
    
    UIImageView *imageView  = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 71.0f, 100.0f)];
    [imageView setAnimationImages:bflies];
    [imageView setAnimationDuration:1.2f];
    [imageView startAnimating];
    [imageView setCenter:CGPointMake(y*32.0f+20.0f, x*32.0f +20.0f)];
    [self.view addSubview:imageView];
}

- (void) nhanDatCo
{
    if (datCo == 0)
    {
        datCo = 1;
        [btnDatCo setBackgroundImage:[UIImage imageNamed:@"datcoselect.png"] forState:UIControlStateNormal];
    }
    else
    {
        datCo = 0;
        [btnDatCo setBackgroundImage:[UIImage imageNamed:@"datco.png"] forState:UIControlStateNormal];
    }
}

- (void) hamDemThoiGian
{

    thoiGianPlay--;
    [labelTime setText:[NSString stringWithFormat:@"%d", thoiGianPlay]];
    if (thoiGianPlay == 0)
    {
        if (timer)
        {
            [timer invalidate];
            timer = nil;
        }
        [self openAll];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thông báo" message:@"Hết giờ!!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)quaMan
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Chúc mừng" message:@"Qua màn!!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    manChoi++;
    [self initManChoi];
    [self loadMin];
}
- (BOOL)kiemTraWin
{
    for (int i = 0; i < soDong; i++)
    {
        for (int j = 0; j < soCot; j++)
        {
            if ([[[listMin objectAtIndex:i] objectAtIndex:j] trangThai] != 1 && [[[listMin objectAtIndex:i] objectAtIndex:j] soMin] != -1)
                return FALSE;
            
        }       
    }
    return TRUE;
}

- (void)initManChoi
{
    switch (manChoi) {
        case 1:
        {
            soDong = 4;
            soCot = 5;
            soMin = 4;
            break;
        }
        case 2:
        {
            soDong = 5;
            soCot = 6;
            soMin = 6;
            break;
        }
        case 3:
        {
            soDong = 5;
            soCot = 7;
            soMin = 8;
            break;
        }
        case 4:
        {
            soDong = 6;
            soCot = 8;
            soMin = 10;
            break;
        }
        case 5:
        {
            soDong = 7;
            soCot = 9;
            soMin = 12;
            break;
        }
        case 6:
        {
            soDong = 7;
            soCot = 10;
            break;
            soMin = 14;
        }
        case 7:
        {
            soDong = 8;
            soCot = 10;
            soMin = 16;
            break;
        }
        case 8:
        {
            soDong = 9;
            soCot = 10;
            soMin = 18;
            break;
        }
        case 9:
        {
            soDong = 9;
            soCot = 11;
            soMin = 20;
            break;
        }
        default:
        {
            soDong = 9;
            soCot = 11;
            soMin = 20;
            break;
        }
    }
}
@end
