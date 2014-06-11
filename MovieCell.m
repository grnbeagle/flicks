//
//  MovieCell.m
//  flicks
//
//  Created by Amie Kweon on 6/9/14.
//  Copyright (c) 2014 Amie Kweon. All rights reserved.
//

#import "MovieCell.h"

@implementation MovieCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    UIView *view = [[UIView alloc] initWithFrame:self.frame];
    view.backgroundColor = [UIColor colorWithRed:255 green:255 blue:255 alpha:0.2];
    
    self.selectedBackgroundView = view;
    [super setSelected:selected animated:animated];
}

@end
