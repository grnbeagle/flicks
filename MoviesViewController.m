//
//  MoviesViewController.m
//  flicks
//
//  Created by Amie Kweon on 6/9/14.
//  Copyright (c) 2014 Amie Kweon. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieDetailViewController.h"
#import "MovieCell.h"
#import "Movie.h"
#import "Utils.h"

@interface MoviesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *movies;
@end

@implementation MoviesViewController

NSString *screenTitle;
NSString *apiUrl;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self.listType = @"Movies";
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateConfig];
    
    self.navigationItem.title = screenTitle;
    self.tableView.rowHeight = 120;
    //self.announcementView.hidden = YES;
    
    [self fetchData];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self createToolbar];
    
    // Is this okay?
    // http://stackoverflow.com/questions/12497940/uirefreshcontrol-without-uitableviewcontroller
    UITableViewController *tableViewController = [[UITableViewController alloc] init];
    tableViewController.tableView = self.tableView;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [tableViewController setRefreshControl:refreshControl];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *movieCell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    Movie *movie = self.movies[indexPath.row];
    movieCell.titleLabel.text = movie.title;
    NSString *html = [NSString stringWithFormat:@"<span class=\"mppa\">%@</span> <span class=\"synopsis\">%@</span>", movie.mpaaRating, movie.synopsis];
    NSString *styledHtml = [Utils styledHTMLwithHTML:html];
    NSAttributedString *attributedText = [Utils attributedStringWithHTML:styledHtml];
    
    movieCell.synopsisLabel.attributedText = attributedText;
    
    [Utils loadImageUrl:movie.posterThumbUrl inImageView:movieCell.posterView withAnimation:YES];
    return movieCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MovieCell *movieCell = (MovieCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    MovieDetailViewController *movieDetailViewController = [[MovieDetailViewController alloc] init];
    movieDetailViewController.movie = self.movies[indexPath.row];
    movieDetailViewController.preloadImage = [movieCell.posterView image];
    [self.navigationController pushViewController:movieDetailViewController animated:YES];
}

- (void)fetchData {
    //    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"movies" ofType:@"json"];
    //    NSData *data = [NSData dataWithContentsOfFile:filePath];
    //    id object = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    //    self.movies = [Movie moviesWithArray:object[@"movies"]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:apiUrl]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError != nil) {
            //self.announcementView.hidden = NO;
        } else {
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.movies = [Movie moviesWithArray:object[@"movies"]];
            [self.tableView reloadData];
        }
    }];
}

- (void)refresh:(id)sender {
    NSLog(@"refreshing");
    [self fetchData];
    [(UIRefreshControl *)sender endRefreshing];
}

- (void)switchView:(id)sender {
    self.listType = [[(UIButton *)sender titleLabel] text];
    [self updateConfig];
    [self viewDidLoad];
}

- (void)updateConfig {
    if ([self.listType isEqualToString:@"Movies"]) {
        screenTitle = @"Movies";
        apiUrl = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=g9au4hv6khv6wzvzgt55gpqs&limit=20&country=us";
        
    } else {
        screenTitle = @"DVD";
        apiUrl = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&limit=20&country=us";
    }
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
    
    [movieButton addTarget:self action:@selector(switchView:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *movieBtn = [[UIBarButtonItem alloc] initWithCustomView:movieButton];
    
    UIImage *dvdIconImage = [UIImage imageNamed:@"DVDIcon"];
    UIButton *dvdButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [dvdButton setImage:dvdIconImage forState:UIControlStateNormal];
    [dvdButton setTitle:@"DVD" forState:UIControlStateNormal];
    [dvdButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [dvdButton setTitleEdgeInsets:UIEdgeInsetsMake(3, 10, 0, 0)];
    dvdButton.titleLabel.font = [UIFont systemFontOfSize:12];
    dvdButton.frame = CGRectMake(170, 0, 90, 30);
    
    [dvdButton addTarget:self action:@selector(switchView:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *dvdBtn = [[UIBarButtonItem alloc] initWithCustomView:dvdButton];
    
    NSArray *buttons = [NSArray arrayWithObjects:movieBtn, flexiableItem, dvdBtn, nil];
    self.toolbarItems = buttons;
}
@end
