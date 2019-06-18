//
//  ViewController.m
//  musicTool
//
//  Created by 祝发冬 on 2019/5/20.
//  Copyright © 2019 kai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)NSArray* typesArray;
@property(nonatomic,strong)NSArray* filterArray;
@property(nonatomic,strong)NSString* fliter;
@property(nonatomic,strong)NSMutableArray* dataArray;
@property(nonatomic,strong)NSString* type;
@property(nonatomic,strong)NSButton* typeButton;
@property(nonatomic,strong)AFHTTPSessionManager* manager;
@property(nonatomic,assign)NSUInteger page;
@property(nonatomic,strong)NSMutableArray* downLoadArray;
@property(nonatomic,strong)AVAudioPlayer* audioPlayer;
@property(nonatomic,strong)AVPlayer* avPlayer;
@property(nonatomic,strong)MusicCell* currentCell;
@property(nonatomic,strong)id monitor;

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
    id monitor=[NSEvent addLocalMonitorForEventsMatchingMask:NSEventMaskKeyDown handler:^NSEvent * _Nullable(NSEvent * _Nonnull event) {
        
        
        if (event.keyCode==36)
        {
            [self searchClicked:self.searchBar];
        }
        return event;
    }];
    self.monitor=monitor;
    
}
-(void)viewDidAppear
{
    [self.view.window makeFirstResponder:self];
}
-(void)initData
{
    self.filterArray=@[@"name",@"id",@"url"];
 self.typesArray=@[@{@"name":@"网易",@"value":@"netease"},@{@"name":@"QQ",@"value":@"qq"},@{@"name":@"酷狗",@"value":@"kugou"},@{@"name":@"酷我",@"value":@"kuwo"},@{@"name":@"虾米",@"value":@"xiami"},@{@"name":@"百度",@"value":@"baidu"},@{@"name":@"一听",@"value":@"1ting"},@{@"name":@"咪咕",@"value":@"migu"},@{@"name":@"荔枝",@"value":@"lizhi"},@{@"name":@"蜻蜓",@"value":@"qingting"},@{@"name":@"喜马拉雅",@"value":@"ximalaya"},@{@"name":@"全民K歌",@"value":@"kg"},@{@"name":@"5sing",@"value":@"5singyc"},@{@"name":@"5sing翻唱",@"value":@"5singfc"},];
    self.page=1;
    self.fliter=@"name";
    self.type=@"qq";
    self.radio.state=NSControlStateValueOn;
    self.typeButton=self.radio;
    self.dataArray=[NSMutableArray array];
    self.downLoadArray=[NSMutableArray array];
    self.manager=[AFHTTPSessionManager manager];
    self.manager.requestSerializer=[AFHTTPRequestSerializer serializer];
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

-(void)loadDataFormSorce
{
    NSString*host=@"http://www.zhmdy.top/music/";
    NSString*urlString=[[NSString stringWithFormat:@"%@?%@=%@&type=%@",host,self.fliter,self.searchBar.stringValue,self.type]  stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self.manager POST:host parameters:@{@"input":self.searchBar.stringValue,@"type":self.type,@"filter":self.fliter,@"page":@(self.page)} headers:@{@"Cookie":@"Hm_lvt_cee9cfa7d89bf6bf8a3133a6133646cf=1558316271,1559805667,1560325197",@"Refer":urlString,@"User-Agent":@"Mozilla/5.0 (iPhone; CPU iPhone OS 12_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.1 Mobile/15E148 Safari/604.1",@"Origin":@"http://www.zhmdy.top",@"X-Requested-With":@"XMLHttpRequest"} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary* json=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSArray*list=json[@"data"];
        NSInteger code= [json[@"code"] integerValue];
        if (code==200)
        {
            [self.dataArray addObjectsFromArray:list];
            [self.tableView reloadData];
            self.page++;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
    }];
}

- (IBAction)selectAll:(id)sender {
    
    [self.downLoadArray removeAllObjects];
    
    [self.downLoadArray addObjectsFromArray:self.dataArray];
    [self.tableView reloadData];
}
- (IBAction)downLoad:(NSButtonCell *)sender {
    
    
    for (NSInteger i=0; i<self.downLoadArray.count; i++)
    {
        NSDictionary*song=self.downLoadArray[i];
        [self downLoadWithSong:song cell:nil];
    }
}


- (IBAction)searchFilterSegmentClicked:(NSSegmentedControl *)sender {
    
    self.fliter=self.filterArray[sender.selectedSegment];
    
}
- (void)searchClicked:(NSSearchField *)sender {
    
    [self.audioPlayer stop];
    self.audioPlayer=nil;
    
    [self.avPlayer pause];
    self.avPlayer=nil;
    [self.dataArray removeAllObjects];
    self.page=1;
    NSString*host=@"http://www.zhmdy.top/music/";
    NSString*urlString=[[NSString stringWithFormat:@"%@?%@=%@&type=%@",host,self.fliter,sender.stringValue,self.type]  stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    __weak ViewController*weakSelf=self;
    [self.manager GET:urlString parameters:nil headers:@{@"Cookie":@"Hm_lvt_cee9cfa7d89bf6bf8a3133a6133646cf=1558316271,1559805667,1560325197",@"User-Agent":@"Mozilla/5.0 (iPhone; CPU iPhone OS 12_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.1 Mobile/15E148 Safari/604.1"} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [weakSelf loadDataFormSorce];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error=%@",error);
    }];
    
    
    
    
    
}
- (void)cancelClicked:(NSSearchField *)sender {
    
    sender.stringValue=@"";
    [self.dataArray removeAllObjects];
    [self.tableView reloadData];
}


#pragma mark ---Music
-(void)loadMoreMusic
{
   
    [self loadDataFormSorce];
}
-(void)downLoadWithSong:(NSDictionary*)song cell:(nullable id)cell
{
    NSString* directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Downloads"];
    
    NSString *urlString = song[@"url"];
    if (!urlString.length)
    {
        return;
    }
   
    NSString *lrc = [NSString stringWithFormat:@"%@_%@.lrc",song[@"author"],song[@"title"]];
    NSString *mp3 = [NSString stringWithFormat:@"%@_%@.mp3",song[@"author"],song[@"title"]];
    NSString*mp3Path=[directory stringByAppendingPathComponent:mp3];
    NSString*lrcPath=[directory stringByAppendingPathComponent:lrc];
    NSInteger index= [self.dataArray indexOfObject:song];
     BOOL isexsites=[[NSFileManager defaultManager] fileExistsAtPath:mp3Path];
    if (isexsites&&cell)
    {
        [[NSWorkspace sharedWorkspace] selectFile:mp3Path inFileViewerRootedAtPath:@""];
    }
    else if (isexsites)
    {
        [self.tableView reloadDataForRowIndexes:[NSIndexSet indexSetWithIndex:index] columnIndexes:[NSIndexSet indexSetWithIndex:0]];
    }
    else
    {
        
        MusicCell*currentCell ;
        if (cell)
        {
            currentCell=cell;
        }
     else if(index!=NSNotFound)
        {
            currentCell =(MusicCell*)[self.tableView viewAtColumn:0 row:index makeIfNecessary:YES];
        }
      
       
     
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        
        
        NSURLSessionDownloadTask *download = [self.manager   downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            //下载进度
            dispatch_async(dispatch_get_main_queue(), ^{
               
                if (currentCell&&downloadProgress.fractionCompleted<1.0)
                {
                    [currentCell.progress startAnimation:self];
                    currentCell.progress.hidden=NO;
                    
                    currentCell.progress.doubleValue=downloadProgress.fractionCompleted*100;
                }
                else
                {
                     [currentCell.progress stopAnimation:self];
                    currentCell.progress.hidden=YES;
                }
            });
           
            
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
            
            
            BOOL isexsites=[[NSFileManager defaultManager] fileExistsAtPath:mp3Path];
            if (isexsites)
            {
                [[NSFileManager defaultManager]removeItemAtPath:mp3Path error:nil];  ;
            }
            
            NSURL*url=[NSURL fileURLWithPath:mp3Path];
            
            return url;
        } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            
            if(!error)
            {
                NSString*lrcString=song[@"lrc"];
                
                BOOL isexsites=[[NSFileManager defaultManager] fileExistsAtPath:lrcPath];
                if (isexsites)
                {
                    [[NSFileManager defaultManager] removeItemAtPath:lrcPath error:nil];
                }
                [lrcString writeToFile:lrcPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
                
                
                
                
                
                
                
                
                
                
                
               
                [self.tableView reloadDataForRowIndexes:[NSIndexSet indexSetWithIndex:index] columnIndexes:[NSIndexSet indexSetWithIndex:0]];
                
            }
            
        }];
        
        //执行Task
        [download resume];
    }
    
}
-(void)checkWithSong:(NSDictionary*)song state:(BOOL)checked
{
    
    if (checked)
    {
        [self.downLoadArray addObject:song];
    }
    else
    {
        NSInteger index= [self.downLoadArray indexOfObject:song];
        if (index!=NSNotFound)
        {
            [self.downLoadArray removeObjectAtIndex:index];
        }
    }
}
-(void)playWithSong:(NSDictionary*)song cell:(MusicCell*)cell
{
    if (self.currentCell!=cell)
    {
        self.currentCell.isPlaying=NO;
        self.currentCell.playButton.image=[NSImage imageNamed:@"play.png"];
        
    }
    
    NSString* directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Downloads"];
    
    NSString *mp3 = [NSString stringWithFormat:@"%@_%@.mp3",song[@"author"],song[@"title"]];
    NSString*mp3Path=[directory stringByAppendingPathComponent:mp3];
    BOOL isexsites=[[NSFileManager defaultManager] fileExistsAtPath:mp3Path];
    
    cell.isPlaying=!cell.isPlaying;
    if (cell.isPlaying)
    {
        cell.playButton.image=[NSImage imageNamed:@"stop.png"];
    }
    else
    {
        cell.playButton.image=[NSImage imageNamed:@"play.png"];
        if (isexsites)
        {
            [self.audioPlayer stop];
            self.audioPlayer=nil;
        }
        else
        {
            [self.avPlayer pause];
             self.avPlayer=nil;
            
        }
        
       
    }
    
    
    
   
    if (isexsites)
    {
        NSError*error;
        AVAudioPlayer* player=[[AVAudioPlayer alloc]initWithContentsOfURL:[NSURL fileURLWithPath:mp3Path] error:&error];
        player.volume=0.8;
        self.audioPlayer=player;
        player.delegate=self;
        if (error)
        {
            NSLog(@"error=%@",error);
        }
        else
        {
            [player prepareToPlay];
            [player play];
        }
       
    }
    else
    {
        NSError*error;
        AVPlayerItem*item=[AVPlayerItem playerItemWithURL:[NSURL URLWithString:song[@"url"]]];
        AVPlayer* player=[[AVPlayer alloc]initWithPlayerItem:item];;
        player.volume=0.8;
        self.avPlayer=player;
        
        if (error)
        {
            NSLog(@"error=%@",error);
        }
        else
        {
           
            [player play];
        }
        
    }
    self.currentCell=cell;
    
}

- (void)dealloc
{
    [NSEvent removeMonitor:self.monitor];
}

#pragma mark - 播放器代理
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"播放完成");
}
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error
{
    NSLog(@"error=%@",error);
}

#pragma mark ---Datasource
-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    NSInteger count=0;
    if (self.dataArray.count)
    {
        count=self.dataArray.count+1;
    }
    return count;
}
#pragma mark ---Delegate
-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
   
    MusicCell*cellView=(MusicCell*)[tableView makeViewWithIdentifier:tableColumn.identifier owner:self];
    NSDictionary*dic;
    if (row<self.dataArray.count)
    {
        dic=self.dataArray[row];
        
    }
    else
    {
        //加载更多
    }
    cellView.delegate=self;
     [cellView configWithSong:dic Selected:[self.downLoadArray containsObject:dic]];
 
    return cellView;
}
-(BOOL)tableView:(NSTableView *)tableView shouldTrackCell:(NSCell *)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return YES;
}
-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row
{
    return 70;
}

@end
