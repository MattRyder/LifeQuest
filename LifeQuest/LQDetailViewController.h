//
//  LQDetailViewController.h
//  LifeQuest
//
//  Created by matt on 10/05/2014.
//  Copyright (c) 2014 MattRyder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQViewController.h"
#import "Quest.h"

@interface LQDetailViewController : LQViewController

@property (strong, nonatomic) IBOutlet UIProgressView *progressView;
@property (strong, nonatomic) IBOutlet UIView *infoView;

@property (strong, nonatomic) IBOutlet UILabel *experienceLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;


@property (strong, nonatomic) IBOutlet Quest *detailQuest;

@end
