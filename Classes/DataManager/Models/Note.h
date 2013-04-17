//
//  Note.h
//  TaskNotifier
//
//  Created by iOS - Evgeniy Lipskiy on 31.03.13.
//  Copyright (c) 2013 vexadev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject

@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * description;
@property (assign,nonatomic) NSString * prioritet;
@property (assign,nonatomic) NSNumber * idx;
@end
