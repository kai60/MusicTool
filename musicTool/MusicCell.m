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
-(void)configWithSong:(NSDictionary *)dic
{
    NSString*title=dic[@"title"];
    NSString*author=dic[@"author"];
    NSString*lrc=dic[@"lrc"];
     NSString*url=dic[@"url"];
     NSString*pic=dic[@"pic"];
    self.title.stringValue=[NSString stringWithFormat:@"%@-%@",title,author];
    self.lrc.string=lrc;
    [self.icon setImageURL:[NSURL URLWithString:pic]];
    self.song=dic;
    
}
- (IBAction)checked:(NSButton *)sender {
}
- (IBAction)download:(NSButton *)sender {
}
- (IBAction)play:(NSButton *)sender {
}

@end
