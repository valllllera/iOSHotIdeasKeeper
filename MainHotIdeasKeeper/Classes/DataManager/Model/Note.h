//
//  Note.h
//  MainHotIdeasKeeper
//
//  Created by iOS - Evgeniy Lipskiy on 18.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject

@property(nonatomic, copy) NSString *noteText;
@property (strong , nonatomic) NSNumber *idx;
@property (strong , nonatomic) NSDate *date;
@property (strong , nonatomic) NSString *imageUrlPath;
@property (strong , nonatomic) NSNumber *x;
@property (strong , nonatomic) NSNumber *y;




@end
