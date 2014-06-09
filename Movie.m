//
//  Movie.m
//  flicks
//
//  Created by Amie Kweon on 6/7/14.
//  Copyright (c) 2014 Amie Kweon. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.title = dictionary[@"title"];
        self.mpaaRating = dictionary[@"mpaa_rating"];
        self.synopsis = dictionary[@"synopsis"];
        self.posterThumbUrl = dictionary[@"posters"][@"thumbnail"];
        self.posterUrl = dictionary[@"posters"][@"original"];
        self.year = [dictionary[@"year"] intValue];
        self.criticsScore = [dictionary[@"ratings"][@"critics_score"] intValue];
        self.audienceScore = [dictionary[@"ratings"][@"audience_score"] intValue];
    }
    return self;
}

+ (NSArray *)moviesWithArray:(NSArray *)array {
    NSMutableArray *movies = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in array) {
        Movie *movie = [[Movie alloc] initWithDictionary:dictionary];
        [movies addObject:movie];
    }
    return movies;
}
@end
