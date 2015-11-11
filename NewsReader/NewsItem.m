//
//  NewsItem.m
//  NewsReader
//
//  Created by rentit on 2015. 11. 11..
//  Copyright © 2015. rentit. All rights reserved.
//

#import "NewsItem.h"

@implementation NewsItem

-(NSString*) description{
    return [NSString stringWithFormat:@"Title: %@\r%@", self.title, [self.body substringToIndex:25]];
}

@end
