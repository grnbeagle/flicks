//
//  MovieDetailViewController.h
//  flicks
//
//  Created by Amie Kweon on 6/9/14.
//  Copyright (c) 2014 Amie Kweon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieDetailViewController : UIViewController

@property (nonatomic, strong) Movie *movie;
@property (nonatomic, strong) UIImage *preloadImage;

@end
