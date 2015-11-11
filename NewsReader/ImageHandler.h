//
//  ImageHandler.h
//  NewsReader
//
//  Created by rentit on 2015. 11. 11..
//  Copyright © 2015. rentit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MKNetworkKit/MKNetworkKit.h>

typedef void(^fetchImageOnCompleteBlock)(UIImage *image, NSString* imageUrl);
@interface ImageHandler : NSObject

-(id)initWithNetworkEngine:(MKNetworkEngine*)engine;

-(void)fetchImageWithUrlString:(NSString*)urlString onComplete:(fetchImageOnCompleteBlock) onComplete;

@end
