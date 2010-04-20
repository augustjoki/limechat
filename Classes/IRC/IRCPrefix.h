// Created by Satoshi Nakagawa.
// You can redistribute it and/or modify it under the Ruby's license or the GPL2.

#import <Foundation/Foundation.h>


@interface IRCPrefix : NSObject
{
	NSString* raw;
	NSString* nick;
	NSString* user;
	NSString* address;
	BOOL isServer;
}

@property (nonatomic, retain) NSString* raw;
@property (nonatomic, retain) NSString* nick;
@property (nonatomic, retain) NSString* user;
@property (nonatomic, retain) NSString* address;
@property (nonatomic, assign) BOOL isServer;

@end
