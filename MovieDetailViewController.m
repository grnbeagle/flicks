//
//  MovieDetailViewController.m
//  flicks
//
//  Created by Amie Kweon on 6/9/14.
//  Copyright (c) 2014 Amie Kweon. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "MoviesViewController.h"
#import "Utils.h"
@interface MovieDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation MovieDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = self.movie.title;
    [self.posterView setImage:self.preloadImage];
    [Utils loadImageUrl:self.movie.posterUrl inImageView:self.posterView withAnimation:NO];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,self.view.frame.size.height)];
    
    contentView.backgroundColor = [UIColor blackColor];
    contentView.alpha = 0.75;
    [self.scrollView addSubview:contentView];
    
    UILabel *synopsisLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];
    synopsisLabel.text = self.movie.synopsis;
    synopsisLabel.numberOfLines = 0;
    synopsisLabel.textColor = [UIColor whiteColor];
    [synopsisLabel sizeToFit];
    
    [contentView addSubview:synopsisLabel];
    
    float contentHeight = self.view.frame.size.height - self.navigationController.toolbar.frame.size.height - self.navigationController.navigationBar.frame.size.height;
    [self.scrollView setContentSize: CGSizeMake(320, contentHeight)];
    
    [self createToolbar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createToolbar {
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setTintColor:[UIColor blackColor]];
    [toolbar setBarTintColor:[UIColor redColor]];
    toolbar.frame = CGRectMake(0, 0, 300, 44);
    UIBarButtonItem *flexiableItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIImage *movieIconImage = [UIImage imageNamed:@"MovieIcon"];
    UIButton *movieButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [movieButton setImage:movieIconImage forState:UIControlStateNormal];
    [movieButton setTitle:@"Movies" forState:UIControlStateNormal];
    [movieButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [movieButton setTitleEdgeInsets:UIEdgeInsetsMake(3, 10, 0, 0)];
    movieButton.titleLabel.font = [UIFont systemFontOfSize:12];
    movieButton.frame = CGRectMake(0, 0, 90, 30);
    
    [movieButton addTarget:self action:@selector(viewListScreen:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *movieBtn = [[UIBarButtonItem alloc] initWithCustomView:movieButton];
    
    UIImage *dvdIconImage = [UIImage imageNamed:@"DVDIcon"];
    UIButton *dvdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dvdButton setImage:dvdIconImage forState:UIControlStateNormal];
    [dvdButton setTitle:@"DVD" forState:UIControlStateNormal];
    [dvdButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [dvdButton setTitleEdgeInsets:UIEdgeInsetsMake(3, 10, 0, 0)];
    dvdButton.titleLabel.font = [UIFont systemFontOfSize:12];
    dvdButton.frame = CGRectMake(170, 0, 90, 30);
    
    [dvdButton addTarget:self action:@selector(viewListScreen:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *dvdBtn = [[UIBarButtonItem alloc] initWithCustomView:dvdButton];
    
    NSArray *buttons = [NSArray arrayWithObjects:movieBtn, flexiableItem, dvdBtn, nil];
    self.toolbarItems = buttons;
}

- (void)viewListScreen:(id)sender  {
    NSString *listType = [[(UIButton *)sender titleLabel] text];
    MoviesViewController *moviesViewController = [[MoviesViewController alloc] init];
    moviesViewController.listType = listType;
    [self.navigationController popToViewController:moviesViewController animated:YES];
}

@end
