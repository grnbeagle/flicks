//
//  Kiwi+Helpers.m
//  flicks
//
//  Created by Julian Ramirez on 10/26/14.
//  Copyright (c) 2014 Amie Kweon. All rights reserved.
//

#import "Kiwi+Helpers.h"
#import "OHHTTPStubs.h"


@implementation Fixtures : NSObject

+ (NSDictionary *)fixtureNamed:(NSString *)path {
    NSString *filePath = [[NSBundle bundleForClass:self.class] pathForResource:path ofType:@"json"];

    NSAssert([[NSFileManager defaultManager] isReadableFileAtPath:filePath], @"Unable to access fixture file");

    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSError *error;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    NSAssert(!error, @"Unable to parse the json file");

    return jsonDictionary;
}

+ (OHHTTPStubsResponse *)responseForPath:(NSString *)path statusCode:(int)code {
    path = [path stringByAppendingString:[NSString stringWithFormat:@"-%d", code]];
    NSString *filePath = [[NSBundle bundleForClass:self.class] pathForResource:path ofType:@"json"];
    return [OHHTTPStubsResponse responseWithFileAtPath:filePath statusCode:code headers:@{@"content-type": @"application/json"}];
}

@end
