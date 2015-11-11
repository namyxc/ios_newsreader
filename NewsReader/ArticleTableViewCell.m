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
    
    if (item.imageUrl == nil || item.imageUrl == (NSString*)[NSNull null]) {
        item.imageUrl = [NSString stringWithFormat:@"http://www.reconregen.com/wp-content/uploads/2015/04/icon_missing_photo_detail.png"];
    }
    __weak ArticleTableViewCell* weakSelf = self;
    [self.imageHandler fetchImageWithUrlString:item.imageUrl onComplete:^(UIImage *image, NSString* urlString) {
        if ([item.imageUrl isEqualToString:urlString]){
            weakSelf.newsImageView.image = image;
        }
    }];

}

@end
