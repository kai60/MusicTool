//
//  MusicCell.h
//  musicTool
//
//  Created by 祝发冬 on 2019/6/12.
//  Copyright © 2019 kai. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface MusicCell : NSTableCellView

@property (weak) IBOutlet NSImageView *icon;
@property (weak) IBOutlet NSTextField *title;
@property (weak) IBOutlet NSButton *playButton;
@property (weak) IBOutlet NSButton *downloadButton;

@property (unsafe_unretained) IBOutlet NSTextView *lrc;

@end

NS_ASSUME_NONNULL_END
