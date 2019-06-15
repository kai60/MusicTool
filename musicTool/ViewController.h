//
//  ViewController.h
//  musicTool
//
//  Created by 祝发冬 on 2019/5/20.
//  Copyright © 2019 kai. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MusicCell.h"
#import "AFNetworking.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController : NSViewController<NSTableViewDataSource,NSTableViewDelegate,NSSearchFieldDelegate,MusicDelegate,AVAudioPlayerDelegate>

@property (weak) IBOutlet NSSearchField *searchBar;
@property (weak) IBOutlet NSButton *radio;
@property (weak) IBOutlet NSTableView *tableView;

@end

