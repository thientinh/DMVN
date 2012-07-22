//
//  Min.m
//  DoMinVN
//
//  Created by Bao on 1/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Min.h"

@implementation Min
@synthesize min_x, min_y, trangThai, soMin, parent;

- (void) initMin: (int)x y:(int)y _parent:(ViewController*)_parent
{
    //[self setCenter:CGPointMake(min_x, min_y)];
    [self setTrangThai:0];
    [self setParent: _parent];
    [self setTitle:[NSString stringWithFormat:@"%d",soMin] forState:UIControlStateNormal];
    [self setMin_x:x];
    [self setMin_y:y];
    //[self setBackgroundColor:[UIColor grayColor]];
    [self setImage:[UIImage imageNamed:@"node.png"] forState:UIControlStateNormal];
    
    
    NSString *sndpath = [[NSBundle mainBundle] pathForResource:@"beep" ofType:@"wav"];
    NSURL *filePath = [NSURL fileURLWithPath:sndpath];
    AudioServicesCreateSystemSoundID((CFURLRef)objc_unretainedPointer(filePath), &beep);
    
    NSString *sndpath1 = [[NSBundle mainBundle] pathForResource:@"co" ofType:@"wav"];
    NSURL *filePath1 = [NSURL fileURLWithPath:sndpath1];
    AudioServicesCreateSystemSoundID((CFURLRef)objc_unretainedPointer(filePath1), &cowav);
    
    NSString *sndpath2 = [[NSBundle mainBundle] pathForResource:@"min" ofType:@"wav"];
    NSURL *filePath2 = [NSURL fileURLWithPath:sndpath2];
    AudioServicesCreateSystemSoundID((CFURLRef)objc_unretainedPointer(filePath2), &minwav);
    
    NSString *sndpath3 = [[NSBundle mainBundle] pathForResource:@"quaman" ofType:@"wav"];
    NSURL *filePath3 = [NSURL fileURLWithPath:sndpath3];
    AudioServicesCreateSystemSoundID((CFURLRef)objc_unretainedPointer(filePath3), &quamanwav);
    
    
}

-(void)setLanTruyen: (NSString*)string
{
    [self drawMin];
    //[self setTitle:string forState:UIControlStateNormal];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SoMin" message:[NSString stringWithFormat:@"%d",soMin] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //[alert show];
    
    [self setImage:[UIImage imageNamed:@"0.png"] forState:UIControlStateNormal];
}


- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (trangThai == -1 && [((ViewController*)parent) datCo] == 1)
    {
        AudioServicesPlaySystemSound(beep);
        trangThai = 0;
        [self drawMin];
        return;
        
    }
    if (trangThai == 0)
    {
        if ([((ViewController*)parent) datCo] == 1)
        {
            AudioServicesPlaySystemSound(beep);
            trangThai = -1;
            [self drawMin];
            return;
        }
        else
        if (soMin == -1)
        {   
            AudioServicesPlaySystemSound(minwav);
            [((ViewController*)parent) openAll];
                [((ViewController*)parent) drawMinNo:min_x y:min_y];
                return;
        }
        else
        if (soMin == 0) 
        {
            [((ViewController*)parent) lanTruyenOMin:min_x _y:min_y];
        }
        else
         [self setTitle:[NSString stringWithFormat:@"%d",trangThai] forState:UIControlStateNormal];
        trangThai = 1;
        
        if([((ViewController*)parent) kiemTraWin])
        {
            AudioServicesPlaySystemSound(quamanwav);
            [((ViewController*)parent) quaMan];
        }
        else
            AudioServicesPlaySystemSound(cowav);
    }
    [self drawMin];
    
    
}

- (void)drawMin
{
    if (trangThai == 0)
    {
        [self setImage:[UIImage imageNamed:@"node.png"] forState:UIControlStateNormal];
    }
    if (trangThai == 1)
    {
        if (soMin == -1)
        {
            [self setImage:[UIImage imageNamed:@"mine.png"] forState:UIControlStateNormal];
        }
        else
         [self setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",soMin]] forState:UIControlStateNormal];
    }
    if (trangThai == -1)
    {
        [self setImage:[UIImage imageNamed:@"flag.png"] forState:UIControlStateNormal];
    }
}



@end
