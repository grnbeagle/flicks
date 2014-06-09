//
//  Movie.h
//  flicks
//
//  Created by Amie Kweon on 6/7/14.
//  Copyright (c) 2014 Amie Kweon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Movie : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *mpaaRating;
@property (nonatomic, strong) NSString *synopsis;
@property (nonatomic, strong) NSString *posterThumbUrl;
@property (nonatomic, strong) NSString *posterUrl;
@property NSInteger year;
@property NSInteger criticsScore;
@property NSInteger audienceScore;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)moviesWithArray:(NSArray *)array;

@end
