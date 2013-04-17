//
//  Note.h
//  TaskNotifier
//
//  Created by Vlad Polupan - iOS on 17.03.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Remember : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic , copy) NSString *description;
@property (copy, nonatomic) NSString *date;
@property (copy, nonatomic) NSString *hour;
@property (copy, nonatomic) NSString *min;
@property (copy, nonatomic) NSString *prioritet;
@property (copy, nonatomic) NSString *active;
@property (retain, nonatomic) NSNumber *idx;
@property (copy, nonatomic) NSString *remind;
@property (copy, nonatomic) NSString *x;
@property (copy, nonatomic) NSString *y;

@end
