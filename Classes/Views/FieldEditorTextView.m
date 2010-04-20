// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the Ruby's license or the GPL2.

#import "FieldEditorTextView.h"


@implementation FieldEditorTextView

@synthesize pasteDelegate;

- (id)initWithFrame:(NSRect)frameRect textContainer:(NSTextContainer *)aTextContainer
{
	if (self = [super initWithFrame:frameRect textContainer:aTextContainer]) {
		keyHandler = [KeyEventHandler new];
	}
	return self;
}

- (void)dealloc
{
	[keyHandler release];
	[super dealloc];
}

- (void)paste:(id)sender
{
	if (pasteDelegate) {
		BOOL result = [pasteDelegate fieldEditorTextViewPaste:self];
		if (result) {
			return;
		}
	}
	
	[super paste:sender];
}

- (void)setKeyHandlerTarget:(id)target
{
	[keyHandler setTarget:target];
}

- (void)registerKeyHandler:(SEL)selector key:(int)code modifiers:(NSUInteger)mods
{
	[keyHandler registerSelector:selector key:code modifiers:mods];
}

- (void)registerKeyHandler:(SEL)selector character:(UniChar)c modifiers:(NSUInteger)mods
{
	[keyHandler registerSelector:selector character:c modifiers:mods];
}

- (void)keyDown:(NSEvent *)e
{
	if ([keyHandler processKeyEvent:e]) {
		return;
	}
	
	[super keyDown:e];
}

@end
