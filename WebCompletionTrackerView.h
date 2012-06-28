//
//  WebCompletionTrackerView.h
//  WebTracker
//
//  Created by buza on 4/21/12.
//  Copyright (c) 2012 BuzaMoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebCompletionTrackerView : UIView <UIWebViewDelegate>

- (void) loadURL:(NSString*)urlString;

@end
