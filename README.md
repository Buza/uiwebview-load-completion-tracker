uiwebview-load-completion-tracker
=================================

This is a simple demonstration of a 'good enough' solution to the problem
of determining when a UIWebView has finished loading. I've tried multiple
ways of keeping track of the completion status of a UIWebView, and none have
worked as consistently as this version. This uses an NSTimer and tracking 
of the window load status via the Javascript window.onload method.

Note that when this version indicates that the page has completed, it does
not necessarily mean that all of the UIWebView resources have finished
loading. In other words, even this technique may report the page as being
finished, there may be a few additional webViewDidFinishLoad invocations
by the UIWebView as it finishes loading a few last requests. Typically,
these requests have no influence on the rendering of the page, and for
all intents and purposes, when this example reports the page as being
finished loading, it is.

