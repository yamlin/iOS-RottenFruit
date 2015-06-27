//
//  ViewController.m
//  RottenFruit
//
//  Created by Jhih-Yan Lin on 6/19/15.
//  Copyright (c) 2015 Jhih-Yan Lin. All rights reserved.
//

#import "ViewController.h"
#import <UIImageView+AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>


@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // start progress
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading";

    
    
    NSString *posterUrlString = [self.movie valueForKeyPath:@"posters.detailed"];
    posterUrlString = [self convertPosterUrlToHighRes:posterUrlString];
    //[self.posterView setImageWithURL: [NSURL URLWithString:posterUrlString]];
    [self.posterView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:posterUrlString]] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        [self.posterView setImage:image];
        self.titleLabel.text = self.movie[@"title"];
        self.synosisLabel.text = self.movie[@"synopsis"];
        [hud hide:YES];
        NSLog(@"OK");
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        [hud hide:YES];
        [self showAlert];
        
        NSLog(@"Fail");
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self.navigationController popViewControllerAnimated:YES];

}


- (void) showAlert {
    UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                       message:@"Network Error!"
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
    [theAlert show];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)convertPosterUrlToHighRes:(NSString *)urlString {
    NSRange range = [urlString rangeOfString:@".*cloudfront.net/" options:NSRegularExpressionSearch];
    NSString *returnValue = urlString;
    if (range.length > 0) {
        returnValue = [urlString stringByReplacingCharactersInRange:range withString:@"https://content6.flixster.com/"];
    }
    return returnValue;
}

@end
