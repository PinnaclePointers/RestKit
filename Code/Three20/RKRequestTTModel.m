//
//  RKRequestTTModel.m
//  RestKit
//
//  Created by Blake Watters on 2/9/10.
//  Copyright 2010 Two Toasters. All rights reserved.
//

#import "RKRequestTTModel.h"

@implementation RKRequestTTModel

@synthesize model = _model;

+ (id)modelWithResourcePath:(NSString*)resourcePath {
	return [[[self alloc] initWithResourcePath:resourcePath] autorelease];
}

+ (id)modelWithResourcePath:(NSString*)resourcePath params:(NSDictionary*)params {
	return [[[self alloc] initWithResourcePath:resourcePath params:params] autorelease];
}

- (id)initWithResourcePath:(NSString*)resourcePath {
	if (self = [self init]) {
		_model = [[RKRequestModel modelWithResourcePath:resourcePath delegate:self] retain];
	}
	return self;
}

- (id)initWithResourcePath:(NSString*)resourcePath params:(NSDictionary*)params {
	if (self = [self init]) {
		_model = [[RKRequestModel modelWithResourcePath:resourcePath params:params delegate:self] retain];
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)init {
	if (self = [super init]) {
		_model = nil;
	}
	return self;
}

- (void)dealloc {
	[_model release];
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// TTModel

- (BOOL)isLoaded {
	return _model.loaded;
}

- (BOOL)isLoading {
	return nil != _model.loadingRequest;
}

- (BOOL)isLoadingMore {
	return NO;
}

- (BOOL)isOutdated {
	return NO;
}

- (void)cancel {
	if (_model) {
		[_model.loadingRequest cancel];
	}
}

- (void)invalidate:(BOOL)erase {
	// TODO: Note sure how to handle erase...
	[_model clearLoadedTime];
}

- (void)reset {
	[_model reset];
}

- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	[_model load];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// RKRequestModelDelegate

- (void)rkModelDidStartLoad {
	[self didStartLoad];
}

- (void)rkModelDidFailLoadWithError:(NSError*)error {
	[self didFailLoadWithError:error];
}

- (void)rkModelDidCancelLoad {
	[self didCancelLoad];
}

- (void)rkModelDidLoad {
	[self didFinishLoad];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// public

- (NSArray*)objects {
	return _model.objects;
}

@end
