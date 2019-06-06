//
//  ViewController.m
//  musicTool
//
//  Created by 祝发冬 on 2019/5/20.
//  Copyright © 2019 kai. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)musicTypeClicked:(NSButton *)sender {
}
- (IBAction)searchTypeSegmentClicked:(NSSegmentedControl *)sender {
}
- (IBAction)searchClicked:(NSSearchField *)sender {
    
    NSLog(@"string=%@",sender.stringValue);
}

#pragma mark ---
-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return 1;
}

@end
