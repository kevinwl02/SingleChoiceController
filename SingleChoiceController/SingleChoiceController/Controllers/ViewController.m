//
//  ViewController.m
//  SingleChoiceController
//
//  Created by Kevin on 02/12/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import "ViewController.h"
#import "ExampleEntity.h"
#import "SCCSingleChoiceTableViewController.h"
#import "CustomCell.h"

@interface ViewController () <SCCSingleChoiceDelegate>

@property (weak, nonatomic) IBOutlet UIButton *openListButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) NSArray *exampleData;
@property (nonatomic, strong) ExampleEntity *selectedEntity;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    
    if (self.selectedEntity) {
        [self animateSelection];
    }
}

#pragma mark - Private methods

- (void)setupView {
    
    self.title = @"Doge Selector 9000";
}

- (void)animateSelection {
    
    self.openListButton.transform = CGAffineTransformIdentity;
    self.titleLabel.transform = CGAffineTransformIdentity;
    
    [UIView animateWithDuration:0.6
                          delay:0.2
         usingSpringWithDamping:0.4
          initialSpringVelocity:1
                        options:UIViewAnimationOptionCurveEaseInOut animations:^{
                            
                            self.openListButton.transform = CGAffineTransformMakeScale(2.5, 2.5);
                            self.titleLabel.transform = CGAffineTransformMakeScale(2.5, 2.5);
        
    } completion:nil];
}

#pragma mark - Accessors

- (NSArray *)exampleData {
    
    if (!_exampleData) {
        _exampleData = @[
                         [[ExampleEntity alloc] initWithTitle:@"Doge 1" image:[UIImage imageNamed:@"doge1"] content:@"Much nice"],
                         [[ExampleEntity alloc] initWithTitle:@"Doge 2" image:[UIImage imageNamed:@"doge2"] content:@"Wow"],
                         [[ExampleEntity alloc] initWithTitle:@"Doge 3" image:[UIImage imageNamed:@"doge3"] content:@"Such cute"],
                         [[ExampleEntity alloc] initWithTitle:@"Doge 4" image:[UIImage imageNamed:@"doge4"] content:@"Very color"],
                         [[ExampleEntity alloc] initWithTitle:@"Doge 5" image:[UIImage imageNamed:@"doge5"] content:@"That gaze"],
                         [[ExampleEntity alloc] initWithTitle:@"Doge 6" image:[UIImage imageNamed:@"doge6"] content:@"Wowed"],
                         ];
    }
    
    return _exampleData;
}

#pragma mark - UI

- (IBAction)openListButtonPressed:(id)sender {
    
    SCCSingleChoiceTableViewController *singleChoiceController = [SCCSingleChoiceTableViewController singleChoiceControllerWithChoices:[self exampleData] cellNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] cellHeight:80 customSetup:^(UITableViewCell *cell, id choice, NSInteger index, BOOL isSelected) {
        
        CustomCell *customCell = (CustomCell *)cell;
        ExampleEntity *exampleEntity = (ExampleEntity *)choice;
        customCell.dogeImageView.image = exampleEntity.image;
        customCell.titleLabel.text = exampleEntity.title;
        customCell.contentLabel.text = exampleEntity.content;
        customCell.dogeApprove.hidden = !isSelected;
        
    }];
    singleChoiceController.headerTitle = @"Select your inner doge";
    singleChoiceController.singleChoiceDelegate = self;
    if (self.selectedEntity) {
        singleChoiceController.selectedChoice = self.selectedEntity;
    }
    
    [self.navigationController pushViewController:singleChoiceController animated:YES];
}

#pragma mark - SCCSingleChoiceDelegate

- (void)singleChoiceSelectedChoice:(id)choice atIndex:(NSInteger)index {
    
    ExampleEntity *exampleEntity = (ExampleEntity *)choice;
    [self.openListButton setBackgroundImage:exampleEntity.image forState:UIControlStateNormal];
    [self.openListButton setTitle:@"" forState:UIControlStateNormal];
    self.titleLabel.text = exampleEntity.content;
    self.titleLabel.hidden = NO;
    
    self.selectedEntity = exampleEntity;
}

@end
