//
//  NSDate+ExtDate.h
//  MainHotIdeasKeeper
//
//  Created by Alexandr Kolesnik on 19.04.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ExtDate)

-(NSString*)formatStringFromDb;
-(NSString *)saveStringToDb;
@end
