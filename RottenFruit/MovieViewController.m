//
//  MovieViewController.m
//  RottenFruit
//
//  Created by Jhih-Yan Lin on 6/19/15.
//  Copyright (c) 2015 Jhih-Yan Lin. All rights reserved.
//

#import "MovieViewController.h"
#import "MovieCell.h"
#import "ViewController.h"
#import <UIImageView+AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>


@interface MovieViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray* movies;
@property (strong, nonatomic) UIRefreshControl *refreshController;

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    NSString *url = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dagqdghwaq3e3mxyrp7kmmj5";
    
    // start progress
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading";

    
    NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                               [hud hide:YES];
                               if (error != nil) {
                                   [self showAlert];
                               } else {
                                   NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:0                                                               error:nil];
                                   self.movies = dict[@"movies"];
                                   [self.tableView reloadData];
                                   self.refreshController = [[UIRefreshControl alloc] init];
                                   
                                   // Configure Refresh Control
                                   [self.refreshController addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
                                   
                                   self.refreshController.attributedTitle = [[NSAttributedString alloc]initWithString:@"Pull To Refresh"];
                               }
                               
                           }];    
}

-(void)refresh:(id)sender {
    NSLog(@"Refreshing");
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyMovieCell" forIndexPath:indexPath];
    NSDictionary *movie = self.movies[indexPath.row];
    cell.title.text = movie[@"title"];
    cell.synosis.text = movie[@"synopsis"];
    NSString *posterUrlString = [movie valueForKeyPath:@"posters.thumbnail"];
    [cell.postView setImageWithURL: [NSURL URLWithString:posterUrlString]];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MovieCell *cell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSDictionary *movie = self.movies[indexPath.row];
    ViewController *vc = segue.destinationViewController;
    vc.movie = movie;
  
}

@end
