// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the Ruby's license or the GPL2.

#import "InputHistory.h"


#define INPUT_HISTORY_MAX	50


@implementation InputHistory

- (id)init
{
	if (self = [super init]) {
		buf = [NSMutableArray new];
	}
	return self;
}

- (void)dealloc
{
	[buf release];
	[super dealloc];
}

- (void)add:(NSString*)s
{
	pos = buf.count;
	if (s.length == 0) return;
	if ([[buf lastObject] isEqualToString:s]) return;
	
	[buf addObject:s];
	
	if (buf.count > INPUT_HISTORY_MAX) {
		[buf removeObjectAtIndex:0];
	}
	pos = buf.count;
}

- (NSString*)up:(NSString*)s
{
	if (s && s.length > 0) {
		NSString* cur = nil;
		if (0 <= pos && pos < buf.count) {
			cur = [buf objectAtIndex:pos];
		}
		
		if (!cur || ![cur isEqualToString:s]) {
			// if the text was modified, add it
			[buf addObject:s];
			if (buf.count > INPUT_HISTORY_MAX) {
				[buf removeObjectAtIndex:0];
				--pos;
			}
		}
	}
	
	--pos;
	if (pos < 0) {
		pos = 0;
		return nil;
	}
	else if (0 <= pos && pos < buf.count) {
		return [buf objectAtIndex:pos];
	}
	else {
		return @"";
	}
}

- (NSString*)down:(NSString*)s
{
	if (!s || s.length == 0) {
		pos = buf.count;
		return nil;
	}
	
	NSString* cur = nil;
	if (0 <= pos && pos < buf.count) {
		cur = [buf objectAtIndex:pos];
	}

	if (!cur || ![cur isEqualToString:s]) {
		// if the text was modified, add it
		[self add:s];
		return @"";
	}
	else {
		++pos;
		if (0 <= pos && pos < buf.count) {
			return [buf objectAtIndex:pos];
		}
		return @"";
	}
}

@end
