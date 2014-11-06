//
//  MoviesViewController.h
//  flicks
//
//  Created by Amie Kweon on 6/9/14.
//  Copyright (c) 2014 Amie Kweon. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    movieView,
    dvdView
} ViewMode;

@interface MoviesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>
{
    ViewMode mode;
}

@property (nonatomic, strong) NSString *listType;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

-(id)initWithMode:(ViewMode)aMode;

@end
