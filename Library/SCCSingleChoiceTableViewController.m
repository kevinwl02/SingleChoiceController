//
//  SCCSingleChoiceTableViewController.m
//  SingleChoiceController
//
//  Created by Kevin on 15/11/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import "SCCSingleChoiceTableViewController.h"

static NSString * const kSingleChoiceCellIdentifier = @"SCCSingleChoiceTableViewCell";
static CGFloat const kDefaultDismissDelay = 0.3f;
static CGFloat const kDefaultCellHeight = 55;
static CGFloat const kDefaultHeaderHeight = 45;

@interface SCCSingleChoiceTableViewController ()

@property (nonatomic, strong) NSString *(^titleForChoice)(id choice, NSInteger index);
@property (nonatomic, strong) void(^customSetup)(UITableViewCell *cell, id choice, NSInteger index, BOOL isSelected);
@property (nonatomic, assign) CGFloat cellHeight;

@end

@implementation SCCSingleChoiceTableViewController

#pragma mark - View life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
}

#pragma mark - Public methods

+ (instancetype)singleChoiceControllerWithChoices:(NSArray *)choices
                                   titleForChoice:(NSString *(^)(id choice, NSInteger index))titleForChoice {
    
    SCCSingleChoiceTableViewController *singleChoiceController = [SCCSingleChoiceTableViewController new];
    [singleChoiceController setupWithChoices:choices titleForChoice:titleForChoice];
    
    return singleChoiceController;
}

+ (instancetype)singleChoiceControllerWithChoices:(NSArray *)choices
                                          cellNib:(UINib *)cellNib
                                       cellHeight:(CGFloat)cellHeight
                                      customSetup:(void(^)(UITableViewCell *cell, id choice, NSInteger index, BOOL isSelected))customSetup {
    
    SCCSingleChoiceTableViewController *singleChoiceController = [SCCSingleChoiceTableViewController new];
    [singleChoiceController setupWithChoices:choices cellNib:cellNib cellHeight:cellHeight customSetup:customSetup];
    
    return singleChoiceController;
}

- (void)setupWithChoices:(NSArray *)choices
          titleForChoice:(NSString *(^)(id choice, NSInteger index))titleForChoice {
    
    NSParameterAssert(choices);
    NSParameterAssert(titleForChoice);
    
    self.choices = choices;
    self.titleForChoice = titleForChoice;
    self.delayForReturnAfterSelection = kDefaultDismissDelay;
    self.shouldReturnAfterSelection = YES;
    self.cellHeight = kDefaultCellHeight;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kSingleChoiceCellIdentifier];
}

- (void)setupWithChoices:(NSArray *)choices
                 cellNib:(UINib *)cellNib
              cellHeight:(CGFloat)cellHeight
             customSetup:(void(^)(UITableViewCell *cell, id choice, NSInteger index, BOOL isSelected))customSetup {
    
    NSParameterAssert(choices);
    NSParameterAssert(customSetup);
    
    self.choices = choices;
    self.customSetup = customSetup;
    self.delayForReturnAfterSelection = kDefaultDismissDelay;
    self.shouldReturnAfterSelection = YES;
    self.cellHeight = cellHeight;
    [self registerCellWithNib:cellNib];
}

#pragma mark - Private methods

- (void)registerCellWithNib:(UINib *)cellNib {
    
    [self.tableView registerNib:cellNib forCellReuseIdentifier:kSingleChoiceCellIdentifier];
}

- (void)dismissView {
    
    if (self.navigationController && self.navigationController.topViewController == self) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (BOOL)choiceObjectIsSelected:(id)choiceObject {
    
    if ([choiceObject isKindOfClass:[NSString class]] && [self.selectedChoice isKindOfClass:[NSString class]]) {
        return [choiceObject isEqualToString:self.selectedChoice];
    }
    return (choiceObject == self.selectedChoice);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.choices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:kSingleChoiceCellIdentifier];
    
    id choice = self.choices[indexPath.row];
    BOOL isSelected = [self choiceObjectIsSelected:choice];
    
    if (self.customSetup) {
        self.customSetup (cell, choice, indexPath.row, isSelected);
    }
    else if (self.titleForChoice) {
        cell.textLabel.text = self.titleForChoice (choice, indexPath.row);
        if (isSelected) {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
        else {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (self.headerTitle) {
        return self.headerTitle;
    }
    
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (self.headerView) {
        return self.headerView.frame.size.height;
    }
    else if (self.headerTitle) {
        return kDefaultHeaderHeight;
    }
    
    return 0;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id previousSelection = self.selectedChoice;
    self.selectedChoice = self.choices[indexPath.row];
    
    if (previousSelection == self.selectedChoice) {
        return;
    }
    
    NSMutableArray *indexPathsToUpdate = [NSMutableArray new];
    [indexPathsToUpdate addObject:indexPath];
    
    if (previousSelection) {
        NSInteger previousSelectionIndex = [self.choices indexOfObject:previousSelection];
        [indexPathsToUpdate addObject:[NSIndexPath indexPathForRow:previousSelectionIndex inSection:0]];
    }
    
    [self.tableView reloadRowsAtIndexPaths:[indexPathsToUpdate copy] withRowAnimation:UITableViewRowAnimationFade];
    
    if (self.singleChoiceDelegate) {
        [self.singleChoiceDelegate singleChoiceSelectedChoice:self.selectedChoice atIndex:indexPath.row];
    }
    if (self.shouldReturnAfterSelection) {
        [self performSelector:@selector(dismissView) withObject:nil afterDelay:self.delayForReturnAfterSelection];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return self.headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.01f;
}

@end
