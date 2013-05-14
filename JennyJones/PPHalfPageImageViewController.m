//
//  PPHalfPageImageViewController.m
//  JennyJones
//
//  Created by Corey Manders on 1/8/12.
//  Copyright (c) 2012 A*STAR Institute for Infocomm Research. All rights reserved.
//

#import "PPHalfPageImageViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface PPHalfPageImageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property UIImageView * viewFrame;
@property UIImageView * pageCurl;
@property UITableView * timeTable;
@property int side;

@end

@implementation PPHalfPageImageViewController
@synthesize image = _image;
@synthesize viewFrame = _viewFrame;
@synthesize pageCurl = _pageCurl;
@synthesize showPageCurl = _showPageCurl;
@synthesize side = _side;
@synthesize timeTable = _timeTable;


+ (UIImage *)cropImage:(UIImage*)image inRect:(CGRect)rect {
    
   
 
    CGFloat scale = [[UIScreen mainScreen] scale];
    if (scale>1.0) {
        rect = CGRectMake(rect.origin.x*scale , rect.origin.y*scale, rect.size.width*scale, rect.size.height*scale);
    }
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    UIImage *result = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return result;
}
+ (UIImage*)halfPageImageWithImage:(UIImage*)image pageSide:(int)page
{
    CGRect cropRect;
    float width,height;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    if (screenRect.size.width >screenRect.size.height){
        width = screenRect.size.width;
        height = screenRect.size.height;
    }
    else {
        width = screenRect.size.height;
        height = screenRect.size.width;
    }
    if (page == LEFT)
        cropRect = CGRectMake(0.0, 0.0, width/2.0, height);
    else {
        cropRect = CGRectMake(width/2.0, 0.0, width/2.0, height);
        
    }
    
    return [self cropImage:image inRect:cropRect];
    
}
-(id)initWithImage:(UIImage *)image side:(int)side
{
    self=[super init];
    
    self.image = image;
    self.side = side;
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.showPageCurl = NO;

    
	// Do any additional setup after loading the view.
}
-(void)resetPuzzles
{
    NSLog(@"should reset puzzle here");
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"puzzle one done"];
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"puzzle two done"];
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"puzzle three done"];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * returnedCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"reuser"];

    NSNumber * mytime;
    switch (indexPath.row) {
        case 0:
            if ((mytime=[[NSUserDefaults standardUserDefaults] objectForKey:@"puzzle one time"]))
                returnedCell.textLabel.text = [NSString stringWithFormat:@"Puzzle One:  %.1fs",[mytime floatValue]];
            else returnedCell.textLabel.text = @"Puzzle One:  Not Completed";
            break;
        case 1:
            if ((mytime=[[NSUserDefaults standardUserDefaults] objectForKey:@"puzzle two time"]))
                returnedCell.textLabel.text = [NSString stringWithFormat:@"Puzzle Two:  %.1fs",[mytime floatValue]];
            else returnedCell.textLabel.text = @"Puzzle Two:  Not Completed";
            break;
        case 2:
            if ((mytime=[[NSUserDefaults standardUserDefaults] objectForKey:@"puzzle three time"]))
                returnedCell.textLabel.text = [NSString stringWithFormat:@"Puzzle Three:  %.1fs",[mytime floatValue]];
            else returnedCell.textLabel.text = @"Puzzle Three:  Not Completed";
            break;
        case 3:
            if ((mytime=[[NSUserDefaults standardUserDefaults] objectForKey:@"puzzle four time"]))
                returnedCell.textLabel.text = [NSString stringWithFormat:@"Puzzle Four:  %.1fs",[mytime floatValue]];
            else returnedCell.textLabel.text = @"Puzzle Four:  Not Completed";
            break;
        default:
            break;
    }
    
    return returnedCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.timeTable.hidden = YES;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(void)showPuzzleStats
{
    if(!self.timeTable){
        self.timeTable = [[UITableView alloc] initWithFrame:CGRectMake(210, 100, 320, 180) style:UITableViewStylePlain];
        self.timeTable.dataSource = self;
        self.timeTable.delegate = self;
    
    [self.view addSubview:self.timeTable];
        return;
    }
    if (self.timeTable.isHidden)self.timeTable.hidden = NO;
    else self.timeTable.hidden = YES;
    
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    /*
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) return YES;
    return NO;
     */
}

@end
