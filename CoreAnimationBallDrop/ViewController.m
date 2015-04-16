//
//  ViewController.m
//  CoreAnimationBallDrop
//
//  Created by Dario Macagnano on 2013/06/08.
//
//

#import "ViewController.h"
#import "QuartzCore/QuartzCore.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *ballImage = [UIImage imageNamed:@"ball"];
    UIImageView *ball = [[UIImageView alloc] initWithImage:ballImage];
    
    [self.view addSubview:ball];
    [self addFallAnimationForLayer:ball.layer];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addFallAnimationForLayer:(CALayer *)layer{
    
    // The keyPath to animate
    NSString *keyPath = @"transform.translation.y";
    
    // Allocate a CAKeyFrameAnimation for the specified keyPath.
    CAKeyframeAnimation *translation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    
    // Set animation duration and repeat
    translation.duration = 3.5f;
    translation.repeatCount = HUGE_VAL;
    translation.autoreverses = YES;
    
    // Allocate array to hold the values to interpolate
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    // Add the start value
    // The animation starts at a y offset of 0.0
    [values addObject:[NSNumber numberWithFloat:0.0f]];
    
    // Add the end value
    // The animation finishes when the ball would contact the bottom of the screen
    // This point is calculated by finding the height of the applicationFrame
    // and subtracting the height of the ball.
    CGFloat height = [[UIScreen mainScreen] applicationFrame].size.height - layer.frame.size.height;
    [values addObject:[NSNumber numberWithFloat:height]];
    
    // Set the values that should be interpolated during the animation
    translation.values = values;
    
    [layer addAnimation:translation forKey:keyPath];
    
    //=======
    // Allocate array to hold the timing functions
    NSMutableArray *timingFunctions = [[NSMutableArray alloc] init];
    
    // add a timing function for the first animation step to ease in the animation
    // this step crudely simulates gravity by easing in the effects of y offset
    [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    
    // Set the timing functions that should be used to calculate interpolation between the first two keyframes
    translation.timingFunctions = timingFunctions;
    //=======
}

@end
