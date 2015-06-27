//
//  ViewController.h
//  RottenFruit
//
//  Created by Jhih-Yan Lin on 6/19/15.
//  Copyright (c) 2015 Jhih-Yan Lin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synosisLabel;

@property (strong, nonatomic) NSDictionary *movie;

@end

