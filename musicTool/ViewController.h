//
//  ViewController.h
//  musicTool
//
//  Created by 祝发冬 on 2019/5/20.
//  Copyright © 2019 kai. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MusicCell.h"

@interface ViewController : NSViewController<NSTableViewDataSource,NSTableViewDelegate,NSSearchFieldDelegate>

@property (weak) IBOutlet NSSearchField *searchBar;

@end

