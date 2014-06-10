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
    
    NSInteger offset = 350;
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, offset, 320, self.view.frame.size.height)];
    
    contentView.backgroundColor = [UIColor blackColor];
    contentView.alpha = 0.75;
    [self.scrollView addSubview:contentView];
    
    UILabel *synopsisLabel =[[UILabel alloc] initWithFrame:CGRectMake(15, 15, 290, 20)];

    NSString *html = [NSString stringWithFormat:@"\
                      <span class=\"title\">%@ (%i)</span><br> \
                      <span class=\"scores\">Critics Score: %i, Audience Score: %i</span><br> \
                      <span class=\"mppa\">%@</span><br><br> \
                      <span class=\"synopsis-detail\">%@</span>",
                      self.movie.title,
                      self.movie.year,
                      self.movie.criticsScore,
                      self.movie.audienceScore,
                      self.movie.mpaaRating,
                      self.movie.synopsis];
    NSString *styledHtml = [Utils styledHTMLwithHTML:html];
    NSAttributedString *attributedText = [Utils attributedStringWithHTML:styledHtml];
    synopsisLabel.attributedText = attributedText;
    
    synopsisLabel.numberOfLines = 0;
    synopsisLabel.textColor = [UIColor whiteColor];
    [synopsisLabel sizeToFit];
    
    [contentView addSubview:synopsisLabel];
    
    float scrollHeight = offset + contentView.frame.size.height - self.navigationController.toolbar.frame.size.height;
    [self.scrollView setContentSize: CGSizeMake(320, scrollHeight)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
