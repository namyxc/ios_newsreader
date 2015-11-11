//
//  ArticleTableViewCell.h
//  NewsReader
//
//  Created by rentit on 2015. 11. 10..
//  Copyright © 2015. rentit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsItem.h"
#import "ImageHandler.h"
#define kArticleTableViewCell @"kArticleTableViewCell"

@interface ArticleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *newsTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsBodyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
@property (weak, nonatomic) ImageHandler* imageHandler;

-(void)update:(NewsItem*) item;

@end
