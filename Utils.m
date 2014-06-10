//
//  Utils.m
//  flicks
//
//  Created by Amie Kweon on 6/7/14.
//  Copyright (c) 2014 Amie Kweon. All rights reserved.
//

#import "Utils.h"
#import "UIImageView+AFNetworking.h"

@implementation Utils

+ (void)loadImageUrl:(NSString *)url inImageView:(UIImageView *)imageView withAnimation:(BOOL)enableAnimation {
    NSURL *urlObject = [NSURL URLWithString:url];
    __weak UIImageView *iv = imageView;

    [imageView
     setImageWithURLRequest:[NSURLRequest requestWithURL:urlObject]
     placeholderImage:nil
     success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
         if (enableAnimation) {
             iv.alpha = 0.0;
             iv.image = image;
             [UIView animateWithDuration:0.5
                              animations:^{
                                  iv.alpha = 1.0;
                              }];
         } else {
             iv.image = image;             
         }
     }
     failure:nil];
}


+ (NSString *)styledHTMLwithHTML:(NSString *)HTML {
    NSString *style = @"<meta charset=\"UTF-8\"><style> \
        body { \
            font-family: 'HelveticaNeue'; \
        } \
        span.title { \
            font-size: 17px; \
            font-weight: bold; \
        } \
        span.synopsis { \
            font-size: 12px; \
            color: #ccc; \
        } \
        span.scores { \
            font-size: 14px; \
            line-height: 20px; \
            color: #ccc; \
        } \
        span.synopsis-detail { \
            font-size: 14px; \
            line-height: 20px; \
            color: #ccc; \
        } \
        span.mppa { \
            color: #fff; \
            font-size: 11px; \
            font-weight: bold; \
            margin-right: 5px; \
            border: 1px solid #fff; \
        } \
    </style>";
    
    return [NSString stringWithFormat:@"%@%@", style, HTML];
}

+ (NSAttributedString *)attributedStringWithHTML:(NSString *)HTML {
    NSDictionary *options = @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType };
    return [[NSAttributedString alloc] initWithData:[HTML dataUsingEncoding:NSUTF8StringEncoding] options:options documentAttributes:NULL error:NULL];
}
@end
