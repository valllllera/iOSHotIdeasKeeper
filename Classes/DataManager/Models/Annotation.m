//
//  Annotation.m
//  iMarkeev
//
//  Created by Alximik on 11.11.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation

@synthesize coordinate;
@synthesize title;
@synthesize subtitle;

- (void)dealloc
{
    self.title = nil;
    self.subtitle = nil;
    [super dealloc];
}

@end
