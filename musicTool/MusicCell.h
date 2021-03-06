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


@protocol MusicDelegate <NSObject>

-(void)loadMoreMusic;
-(void)downLoadWithSong:(NSDictionary*)song cell:(_Nullable id)cell;
-(void)checkWithSong:(NSDictionary*)song state:(BOOL)checked;
-(void)playWithSong:(NSDictionary*)song cell:(id)cell;

@end
@interface MusicCell : NSTableCellView

@property (weak) IBOutlet NSImageView *icon;
@property (weak) IBOutlet NSTextField *title;
@property (weak) IBOutlet NSButton *playButton;
@property (weak) IBOutlet NSButton *downloadButton;

@property (weak) IBOutlet NSButton *loadMore;

@property (weak) IBOutlet NSButton *checkBox;
@property (strong,nonatomic)  NSDictionary *song;
@property (assign,nonatomic)  BOOL isPlaying;
@property(nonatomic,strong)id<MusicDelegate> delegate;
@property (weak) IBOutlet NSProgressIndicator *progress;
-(void)configWithSong:(NSDictionary*)dic Selected:(BOOL)select;

@end

NS_ASSUME_NONNULL_END
