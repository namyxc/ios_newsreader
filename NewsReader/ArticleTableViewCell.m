//
//  ArticleTableViewCell.m
//  NewsReader
//
//  Created by rentit on 2015. 11. 10..
//  Copyright © 2015. rentit. All rights reserved.
//

#import "ArticleTableViewCell.h"


@implementation ArticleTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)update:(NewsItem*) item{
    self.newsTitleLabel.text = item.title;
    self.newsBodyLabel.text = item.body;
    
    if (item.imageUrl != nil && item.imageUrl != (NSString*)[NSNull null]) {
        NSData* imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:item.imageUrl]];
        self.newsImageView.image = [UIImage imageWithData:imgData];
    }
}

@end
