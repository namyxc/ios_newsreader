//
//  ImageHandler.m
//  NewsReader
//
//  Created by rentit on 2015. 11. 11..
//  Copyright © 2015. rentit. All rights reserved.
//

#import "ImageHandler.h"

@implementation ImageHandler{
    MKNetworkEngine* _engine;
    NSMutableDictionary* _imageCache;
}

-(id)initWithNetworkEngine:(MKNetworkEngine*)engine{
    self = [super init];
    
    if (self) {
        _engine = engine;
        _imageCache = [NSMutableDictionary new];
    }
    
    return self;
}

-(void)fetchImageWithUrlString:(NSString*)urlString onComplete:(fetchImageOnCompleteBlock) onComplete{
    
    UIImage* cachedImage = _imageCache[urlString];
    if (cachedImage != nil) {
        onComplete(cachedImage, urlString);
        NSLog(@"loaded image from cache: %@", urlString);
        return;
    }
    
    NSLog(@"downloading image: %@", urlString);
    
    MKNetworkOperation* operation = [_engine operationWithURLString:urlString];
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        UIImage* image =[completedOperation responseImage];
        _imageCache[urlString] = image;
        onComplete(image, urlString);
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"Error: %@", error);
        onComplete(nil, urlString);
#warning TODO fix this before appstore release
    }];
    
    [_engine enqueueOperation:operation];
}

@end
