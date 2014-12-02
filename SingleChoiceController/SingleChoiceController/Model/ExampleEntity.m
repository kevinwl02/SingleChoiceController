//
//  ExampleEntity.m
//  SingleChoiceController
//
//  Created by Kevin on 02/12/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import "ExampleEntity.h"

@implementation ExampleEntity

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image content:(NSString *)content {
    
    if (self = [super init]) {
    
        self.title = title;
        self.image = image;
        self.content = content;
    }
    
    return self;
}

@end
