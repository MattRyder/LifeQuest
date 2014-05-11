//
//  LQDetailViewController.m
//  LifeQuest
//
//  Created by matt on 10/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import "LQDetailViewController.h"

@interface LQDetailViewController ()

@end

@implementation LQDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Increase the Progress View size and set the header background:   
    [self.progressView setTransform:CGAffineTransformMakeScale(1.0, 5.0)];
    [self setPurpleBackground:1];
    
    //Setup the label data with the Quest Details:
    self.titleLabel.text = self.detailQuest.title;
    self.descriptionLabel.text = self.detailQuest.desc;
    self.experienceLabel.text = [NSString stringWithFormat:@"%@", self.detailQuest.experiencePoints];
    
    // Setup the border on the infoBox:
    self.infoView.layer.borderColor = [[UIColor grayColor] CGColor];
    self.infoView.layer.borderWidth = 2;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
