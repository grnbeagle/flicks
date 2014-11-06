//
//  Kiwi+Helpers.h
//  flicks
//
//  Created by Julian Ramirez on 10/26/14.
//  Copyright (c) 2014 Amie Kweon. All rights reserved.
//

@import Foundation;

@class OHHTTPStubsResponse;


@interface Fixtures : NSObject

+ (NSDictionary *)fixtureNamed:(NSString *)path;
+ (OHHTTPStubsResponse *)responseForPath:(NSString *)path statusCode:(int)code;

@end
