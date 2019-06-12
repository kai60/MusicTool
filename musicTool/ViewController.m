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
}
- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)musicTypeClicked:(NSButton *)sender {
}
- (IBAction)searchTypeSegmentClicked:(NSSegmentedControl *)sender {
}
- (void)searchClicked:(NSSearchField *)sender {
    
    NSLog(@"serach=%@",sender.stringValue);
}
- (void)cancelClicked:(NSSearchField *)sender {
    
    
}

#pragma mark ---Datasource
-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return 1;
}
#pragma mark ---Delegate
-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    MusicCell*cellView=(MusicCell*)[tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
   
    //cellView.icon.image=[NSImage imageNamed:@"1.jpg"];
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
