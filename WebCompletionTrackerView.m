//
//  WebCompletionTrackerView.m
//  WebTracker
//
//  Created by buza on 4/21/12.
//  Copyright (c) 2012 BuzaMoto. All rights reserved.
//

#import "WebCompletionTrackerView.h"

@interface WebCompletionTrackerView()
{
    BOOL injectedPageLoadedJS;
}
@property(nonatomic, strong) UIWebView *webView;
@property(nonatomic, retain) NSTimer *loadStatusCheckTimer;
@end

@implementation WebCompletionTrackerView

@synthesize webView;
@synthesize loadStatusCheckTimer;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        UIWebView *webViewToTrack = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.webView = webViewToTrack;
        [self addSubview:webViewToTrack];
        webViewToTrack.delegate = self;
        
        injectedPageLoadedJS = NO;
        
        self.loadStatusCheckTimer = nil;
    }
    return self;
}

-(void) dealloc
{
    self.webView = nil;
}

- (void) loadURL:(NSString*)urlString
{
    injectedPageLoadedJS = NO;
    self.loadStatusCheckTimer = nil;
    
    [self.webView stopLoading];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self.webView loadRequest:req];
    
    self.loadStatusCheckTimer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                                 target:self
                                                               selector:@selector(checkLoadStatus)
                                                               userInfo:nil
                                                                repeats:YES];
}

-(void) checkLoadStatus
{
    NSString *evalString = [self.webView stringByEvaluatingJavaScriptFromString:@"window.__myLoad5t4tu5__;"];
    if([evalString isEqualToString:@"loaded"])
    {
        //Web page has finished. Shut down the timer.
        [self.loadStatusCheckTimer invalidate];
        self.loadStatusCheckTimer = nil;
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)_webView
{
    if(!injectedPageLoadedJS)
    {
        [self.webView stringByEvaluatingJavaScriptFromString:@"window.__myLoad5t4tu5__ = 'notloaded'; window.onload=function() {window.__myLoad5t4tu5__ = 'loaded';}"];
        injectedPageLoadedJS = YES;
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
}

@end
