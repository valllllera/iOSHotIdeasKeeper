//
//  Clock.h
//  TaskNotifier
//
//  Created by Vlad Polupan - iOS on 27.03.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Clock : NSObject


@property (nonatomic, copy) NSString *name;
@property (copy,nonatomic)NSString *description;
@property (copy,nonatomic)NSString *hour;
@property (copy,nonatomic)NSString *min;
@property (copy,nonatomic)NSString *active;
@property (copy,nonatomic)NSString *mon;
@property (copy,nonatomic)NSString *tue;
@property (copy,nonatomic)NSString *wed;
@property (copy,nonatomic)NSString *thu;
@property (copy,nonatomic)NSString *fri;
@property (copy,nonatomic)NSString *sat;
@property (copy,nonatomic)NSString *sun;
@property (copy,nonatomic)NSString *remind;
@property (copy,nonatomic)NSNumber *idx;

@end
