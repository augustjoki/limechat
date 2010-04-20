// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the Ruby's license or the GPL2.

#import "TopicSheet.h"


@interface TopicSheet (Private)
@end


@implementation TopicSheet

@synthesize uid;
@synthesize cid;

- (id)init
{
	if (self = [super init]) {
		[NSBundle loadNibNamed:@"TopicSheet" owner:self];
	}
	return self;
}

- (void)dealloc
{
	[super dealloc];
}

- (void)start:(NSString*)topic
{
	[text setStringValue:topic ?: @""];
	[self startSheet];
}

- (void)ok:(id)sender
{
	if ([delegate respondsToSelector:@selector(topicSheet:onOK:)]) {
		[delegate topicSheet:self onOK:[text stringValue]];
	}
	
	[super ok:nil];
}

#pragma mark -
#pragma mark NSWindow Delegate

- (void)windowWillClose:(NSNotification*)note
{
	if ([delegate respondsToSelector:@selector(topicSheetWillClose:)]) {
		[delegate topicSheetWillClose:self];
	}
}

@end
