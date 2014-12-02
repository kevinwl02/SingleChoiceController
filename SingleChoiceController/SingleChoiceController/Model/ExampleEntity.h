//
//  ExampleEntity.h
//  SingleChoiceController
//
//  Created by Kevin on 02/12/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExampleEntity : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image content:(NSString *)content;

@end
