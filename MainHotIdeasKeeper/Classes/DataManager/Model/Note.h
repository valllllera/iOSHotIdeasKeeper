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
@property (weak , nonatomic) NSNumber *idx;
@property (weak , nonatomic) NSNumber *year;
@property (weak , nonatomic) NSNumber *month;
@property (weak , nonatomic) NSNumber *day;
@property (weak , nonatomic) NSNumber *hour;
@property (weak , nonatomic) NSNumber *min;




@end
