//
//  Utils.h
//  flicks
//
//  Created by Amie Kweon on 6/7/14.
//  Copyright (c) 2014 Amie Kweon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+(void)loadImageUrl:(NSString *)url inImageView:(UIImageView *)imageView withAnimation:(BOOL)enableAnimation;

+ (NSString *)styledHTMLwithHTML:(NSString *)HTML;
+ (NSAttributedString *)attributedStringWithHTML:(NSString *)HTML;
@end
