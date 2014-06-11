//
//  MoviesViewController.m
//  flicks
//
//  Created by Amie Kweon on 6/9/14.
//  Copyright (c) 2014 Amie Kweon. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieDetailViewController.h"
#import "MBProgressHUD.h"
#import "MovieCell.h"
#import "Movie.h"
#import "Utils.h"

@interface MoviesViewController ()
{
    NSString *screenTitle;
    NSString *apiUrl;
    UIRefreshControl *refreshControl;
    BOOL isSearch;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *movies;
@property (weak, nonatomic) IBOutlet UIView *announcementView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *searchResult;
@end

@implementation MoviesViewController

- (id)initWithMode:(ViewMode)aMode {
    mode = aMode;

    switch (aMode) {
        case movieView:
            screenTitle = @"Movies";
            apiUrl = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=g9au4hv6khv6wzvzgt55gpqs&limit=20&country=us";
            break;
        case dvdView:
            screenTitle = @"DVD";
            apiUrl = @"http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&limit=20&country=us";
            break;
    }

    self = [super init];
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = screenTitle;
        self.view.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.rowHeight = 115;
    self.announcementView.hidden = YES;
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.tableView.backgroundColor = [UIColor blackColor];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    [self fetchData];
    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];

    self.searchBar.delegate = self;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isSearch) {
        return self.searchResult.count;
    } else {
        return self.movies.count;        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *movieCell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    if (!movieCell) {
        movieCell = [[MovieCell alloc] init];
    }
    Movie *movie;
    if (isSearch) {
        if (self.searchResult.count > indexPath.row) {
            movie = self.searchResult[indexPath.row];
        }
    } else {
        movie = self.movies[indexPath.row];
    }
    movieCell.titleLabel.text = movie.title;
    NSString *html = [NSString stringWithFormat:@"<span class=\"mppa\">%@</span> <span class=\"synopsis\">%@</span>", movie.mpaaRating, movie.synopsis];
    NSString *styledHtml = [Utils styledHTMLwithHTML:html];
    NSAttributedString *attributedText = [Utils attributedStringWithHTML:styledHtml];
    
    movieCell.synopsisLabel.attributedText = attributedText;
    
    [Utils loadImageUrl:movie.posterThumbUrl inImageView:movieCell.posterView withAnimation:YES];
    return movieCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.searchBar resignFirstResponder];

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MovieCell *movieCell = (MovieCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    MovieDetailViewController *movieDetailViewController = [[MovieDetailViewController alloc] init];
    if (isSearch) {
        movieDetailViewController.movie = self.searchResult[indexPath.row];
    } else {
        movieDetailViewController.movie = self.movies[indexPath.row];
    }
    movieDetailViewController.preloadImage = [movieCell.posterView image];
    [self.navigationController pushViewController:movieDetailViewController animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    if([searchText isEqualToString:@""] || searchText==nil) {
        isSearch = NO;
        [self.tableView reloadData];
        return;
    }
    isSearch = YES;
    [self.searchResult removeAllObjects];
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"title contains[c] %@", searchText];
    
    self.searchResult = [NSMutableArray arrayWithArray: [self.movies filteredArrayUsingPredicate:resultPredicate]];
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
}

- (void)fetchData {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Load from cache, else go to source
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:apiUrl] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:5];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError != nil) {
            self.announcementView.hidden = NO;
            self.searchBar.hidden = YES;
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        } else {
            id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.movies = [Movie moviesWithArray:object[@"movies"]];

            [self.tableView reloadData];
            self.searchResult = [NSMutableArray arrayWithCapacity:[self.movies count]];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
}

- (void)refresh:(id)sender {
    [self fetchData];
    [(UIRefreshControl *)sender endRefreshing];
}
@end
