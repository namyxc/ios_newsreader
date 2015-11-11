//
//  ArticleListViewController.m
//  NewsReader
//
//  Created by rentit on 2015. 11. 10..
//  Copyright © 2015. rentit. All rights reserved.
//

#import "ArticleListViewController.h"
#import "ArticleViewController.h"
#import "ArticleTableViewCell.h"
#import <MKNetworkKit/MKNetworkKit.h>
#import "NewsItem.h"

@interface ArticleListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *articleTableView;
@property (strong, nonatomic) MKNetworkEngine* networkEngine;
@property (strong, nonatomic) NSArray* news;

@end

@implementation ArticleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //https://dl.dropboxusercontent.com/u/1986074/t360/news.json
    self.networkEngine = [[MKNetworkEngine alloc] initWithHostName:@"dl.dropboxusercontent.com" apiPath:@"u" customHeaderFields:nil];
    
    
    [self.articleTableView registerNib:[UINib nibWithNibName:@"ArticleTableViewCell" bundle:nil] forCellReuseIdentifier:kArticleTableViewCell];
    
    self.articleTableView.delegate = self;
    self.articleTableView.dataSource = self;
    
    __weak ArticleListViewController* weakSelf = self;
    [self fetchNews:^(NSArray *news) {
        weakSelf.news = news;
        [weakSelf.articleTableView reloadData];
    }];
}

typedef void(^FetchNewsOnComplete)(NSArray *news);


- (void)fetchNews:(FetchNewsOnComplete) onComplete{
    
    MKNetworkOperation* operation = [self.networkEngine operationWithPath:@"1986074/t360/news.json"];
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [completedOperation responseJSONWithCompletionHandler:^(id jsonObject) {
            NSArray* result = jsonObject;
            NSMutableArray* newsItems = [NSMutableArray new];
            for (NSDictionary* actItem in result) {
                NewsItem* item = [NewsItem new];
                item.title = actItem[@"title"];
                item.body = actItem[@"body"];
                item.imageUrl = actItem[@"image"];
                item.articleUrl = actItem[@"url"];

                [newsItems addObject:item];
            }
            
            onComplete(newsItems);
        }];
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        onComplete(nil);
        NSLog(@"error");
    }];
    
    [self.networkEngine enqueueOperation:operation];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.news count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ArticleTableViewCell* cell =[tableView dequeueReusableCellWithIdentifier:kArticleTableViewCell forIndexPath:indexPath];
    NewsItem* item = self.news[indexPath.row];
    [cell update:item];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ArticleViewController* articleVc = [ArticleViewController new];
    NewsItem* item = self.news[indexPath.row];

    [self.navigationController pushViewController:articleVc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100.0;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
