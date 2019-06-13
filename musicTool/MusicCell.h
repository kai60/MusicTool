//
//  MusicCell.h
//  musicTool
//
//  Created by 祝发冬 on 2019/6/12.
//  Copyright © 2019 kai. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSImageView+WebCache.h"
NS_ASSUME_NONNULL_BEGIN

@interface MusicCell : NSTableCellView

@property (weak) IBOutlet NSImageView *icon;
@property (weak) IBOutlet NSTextField *title;
@property (weak) IBOutlet NSButton *playButton;
@property (weak) IBOutlet NSButton *downloadButton;

@property (unsafe_unretained) IBOutlet NSTextView *lrc;
@property (weak) IBOutlet NSButton *checkBox;
@property (assign,nonatomic)  NSDictionary *song;
-(void)configWithSong:(NSDictionary*)dic;

@end

NS_ASSUME_NONNULL_END
