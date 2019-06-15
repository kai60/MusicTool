//
//  MusicCell.m
//  musicTool
//
//  Created by 祝发冬 on 2019/6/12.
//  Copyright © 2019 kai. All rights reserved.
//

#import "MusicCell.h"

@implementation MusicCell

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
   
}
-(void)configWithSong:(NSDictionary*)dic Selected:(BOOL)select
{
    NSString*title=dic[@"title"];
    NSString*author=dic[@"author"];
    NSString*lrc=dic[@"lrc"];
     NSString*url=dic[@"url"];
     NSString*pic=dic[@"pic"];
    self.title.stringValue=[NSString stringWithFormat:@"%@_%@",author,title];
   
    [self.icon setImageURL:[NSURL URLWithString:pic]];
    if (select)
    {
        self.checkBox.state=NSControlStateValueOn;
    }
    else
    {
        self.checkBox.state=NSControlStateValueOff;
    }
    if (dic)
    {
        self.song=dic;
        self.title.hidden=NO;
        self.icon.hidden=NO;
        self.checkBox.hidden=NO;
        self.playButton.hidden=NO;
        self.downloadButton.hidden=NO;
        self.loadMore.hidden=YES;
    }
    else{
        self.song=@{};
        self.title.hidden=YES;
        self.icon.hidden=YES;
        self.checkBox.hidden=YES;
        self.playButton.hidden=YES;
        self.downloadButton.hidden=YES;
        self.loadMore.hidden=NO;
    }
     NSString* directory = [NSHomeDirectory() stringByAppendingPathComponent:@"Downloads"];
    NSString *mp3 = [NSString stringWithFormat:@"%@_%@.mp3",author,title];
    NSString*mp3Path=[directory stringByAppendingPathComponent:mp3];
    BOOL isexsites=[[NSFileManager defaultManager] fileExistsAtPath:mp3Path];
    if (isexsites)
    {
        
        self.downloadButton.image=[NSImage imageNamed:@"show.png"];
    }
    else
    {
        self.downloadButton.image=[NSImage imageNamed:@"download.png"];
    }
   
    
    
}
- (IBAction)checked:(NSButton *)sender {
    if ([self.delegate respondsToSelector:@selector(checkWithSong:state:)])
    {
        [self.delegate checkWithSong:self.song state:sender.state==NSControlStateValueOn];
    }
}
- (IBAction)download:(NSButton *)sender {
    if ([self.delegate respondsToSelector:@selector(downLoadWithSong:cell:)])
    {
        [self.delegate downLoadWithSong:self.song cell:self];
    }
}
- (IBAction)play:(NSButton *)sender {
    if ([self.delegate respondsToSelector:@selector(playWithSong:cell:)])
    {
        [self.delegate playWithSong:self.song cell:self];
    }
}
- (IBAction)loadMore:(NSTextField *)sender {
    if ([self.delegate respondsToSelector:@selector(loadMoreMusic)])
    {
        [self.delegate loadMoreMusic];
    }
}

@end
