//
//  ViewController.m
//  musicTool
//
//  Created by 祝发冬 on 2019/5/20.
//  Copyright © 2019 kai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonnull,strong)NSArray* typesArray;
@property(nonnull,strong)NSArray* filterArray;
@property(nonnull,strong)NSString* fliter;
@property(nonnull,strong)NSMutableArray* dataArray;
@property(nonnull,strong)NSString* type;
@property(nonnull,strong)NSButton* typeButton;
@property(nonnull,strong)AFHTTPSessionManager* manager;

@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData];
    [self config];
    
    // Do any additional setup after loading the view.
}

-(void)config
{
    NSActionCell*search=[[self.searchBar cell] searchButtonCell];
    NSActionCell*cancel=[(NSSearchFieldCell*)[self.searchBar cell] cancelButtonCell];
    search.target=self;
    cancel.target=self;
    
    cancel.action=@selector(cancelClicked:);
    search.action=@selector(searchClicked:);
    
}
-(void)initData
{
    self.filterArray=@[@"name",@"id",@"url"];
 self.typesArray=@[@{@"name":@"网易",@"value":@"netease"},@{@"name":@"QQ",@"value":@"qq"},@{@"name":@"酷狗",@"value":@"kugou"},@{@"name":@"酷我",@"value":@"kuwo"},@{@"name":@"虾米",@"value":@"xiami"},@{@"name":@"百度",@"value":@"baidu"},@{@"name":@"一听",@"value":@"1ting"},@{@"name":@"咪咕",@"value":@"migu"},@{@"name":@"荔枝",@"value":@"lizhi"},@{@"name":@"蜻蜓",@"value":@"qingting"},@{@"name":@"喜马拉雅",@"value":@"ximalaya"},@{@"name":@"全民K歌",@"value":@"kg"},@{@"name":@"5sing",@"value":@"5singyc"},@{@"name":@"5sing翻唱",@"value":@"5singfc"},];
    self.fliter=@"name";
    self.type=@"qq";
    self.radio.state=NSControlStateValueOn;
    self.typeButton=self.radio;
    self.dataArray=[NSMutableArray array];
    self.manager=[AFHTTPSessionManager manager];
    self.manager.requestSerializer=[AFJSONRequestSerializer serializer];
    [self.manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    self.manager.responseSerializer =  [AFHTTPResponseSerializer serializer];
    
}
- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)musicTypeClicked:(NSButton *)sender {
    
    NSLog(@"self.typeButton=%@",self.typeButton); self.typeButton.state=NSControlStateValueOff;
    self.typeButton=sender;
    NSInteger tag=sender.tag;
    NSDictionary*dic=self.typesArray[tag];
    self.type=dic[@"value"];
    NSLog(@"type=%@",self.type);
   
    
}
- (IBAction)searchFilterSegmentClicked:(NSSegmentedControl *)sender {
    
    self.fliter=self.filterArray[sender.selectedSegment];
    NSLog(@"filer=%@",self.fliter);
}
- (void)searchClicked:(NSSearchField *)sender {
    
    NSLog(@"serach=%@",sender.stringValue);
    NSLog(@"filer=%@",self.fliter);
    NSLog(@"type=%@",self.type);
    
    [self.manager POST:@"http://www.zhmdy.top/music/?name=%E5%91%A8%E6%9D%B0%E4%BC%A6&type=qq" parameters:@{@"input":@"周杰伦",@"type":self.type,@"filter":self.fliter,@"page":@(1)} headers:@{@"Cookie":@"Hm_lpvt_cee9cfa7d89bf6bf8a3133a6133646cf=1560419251,Hm_lvt_cee9cfa7d89bf6bf8a3133a6133646cf=1560333414,1560414343",@"Refer":@"http://www.zhmdy.top/music/?name=%E5%91%A8%E6%9D%B0%E4%BC%A6&type=qq",@"User-Agent":@"Mozilla/5.0 (iPhone; CPU iPhone OS 12_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.1 Mobile/15E148 Safari/604.1",@"Origin":@"http://www.zhmdy.top"} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary* data=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"responseObject=%@,string=%@",data,[[NSString alloc]initWithData:responseObject encoding: NSUTF8StringEncoding]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
    }];

    
    
}
- (void)cancelClicked:(NSSearchField *)sender {
    
    
}

#pragma mark ---Datasource
-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.dataArray.count;
}
#pragma mark ---Delegate
-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSDictionary*dic=self.dataArray[row];
    MusicCell*cellView=(MusicCell*)[tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
   
    if (dic)
    {
        [cellView configWithSong:dic];
    }
    return cellView;
}
-(BOOL)tableView:(NSTableView *)tableView shouldTrackCell:(NSCell *)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return YES;
}
-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    return 120;
}

@end
