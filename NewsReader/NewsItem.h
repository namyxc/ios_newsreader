//
//  NewsItem.h
//  NewsReader
//
//  Created by rentit on 2015. 11. 11..
//  Copyright © 2015. rentit. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NewsItem : NSObject

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* body;
@property (nonatomic, strong) NSString* imageUrl;
@property (nonatomic, strong) NSString* articleUrl;

@end
