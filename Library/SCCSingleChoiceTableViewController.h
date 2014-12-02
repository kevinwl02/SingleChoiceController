//
//  SCCSingleChoiceTableViewController.h
//  SingleChoiceController
//
//  Created by Kevin on 15/11/14.
//  Copyright (c) 2014 Kevin Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Classes that implement this protocol are notified when an item
 *  is selected.
 */
@protocol SCCSingleChoiceDelegate <NSObject>

@required

/**
 *  This method is called when an item is selected. It sends the choice object
 *  mapped to the cell that was selected.
 *
 *  @param choice The object that was selected
 *  @param index  The index of the selected item in the choices array
 */
- (void)singleChoiceSelectedChoice:(id)choice atIndex:(NSInteger)index;

@end

/**
 *  Class that sets up the single choice view and manages the selection logic
 */
@interface SCCSingleChoiceTableViewController : UITableViewController

/**
 *  Object to be mapped to the selectable cells
 */
@property (nonatomic, strong) NSArray *choices;

/**
 *  This object is used after the view was set up. Set an object from the
 *  'choices' array so that it becomes selected when the view displays
 */
@property (nonatomic, strong) id selectedChoice;

/**
 *  Indicates wether the view controller will return after an item was 
 *  selected. The default value is YES.
 */
@property (nonatomic, assign) BOOL shouldReturnAfterSelection;

/**
 *  Optionally set a custom delay time before the view controller returns.
 *  This is only used if 'shouldReturnAfterSelection' is set to YES.
 */
@property (nonatomic, assign) CGFloat delayForReturnAfterSelection;

/**
 *  Optionally set a header title for the table view. This will use the default
 *  table view header. If this is and 'headerView' ar not set, a header won't 
 *  be shown.
 */
@property (nonatomic, strong) NSString *headerTitle;

/**
 *  Optionally set a header view for the table view. If this and 'headerTitle'
 *  are not set, a header won't be shown.
 */
@property (nonatomic, strong) UIView *headerView;

/**
 *  The delegate object that will receive method calls defined in
 *  'SCCSingleChoiceDelegate'
 */
@property (nonatomic, weak) id<SCCSingleChoiceDelegate> singleChoiceDelegate;

/**
 *  Creates a view controller with default cells.
 *
 *  @param choices        The objects to be mapped to the cells (in order)
 *  @param titleForChoice Value that will be used in the cell's text label
 *
 *  @return The single choice view controller
 */
+ (instancetype)singleChoiceControllerWithChoices:(NSArray *)choices
                                   titleForChoice:(NSString *(^)(id choice, NSInteger index))titleForChoice;

/**
 *  Creates a view controller with custom cells.
 *
 *  @param choices     The objects to be mapped to the cells (in order)
 *  @param cellNib     The Nib of the custom cell
 *  @param cellHeight  The height of the cells
 *  @param customSetup A block which is called when the cell needs to be configured
 *
 *  @return The single choice view controller
 */
+ (instancetype)singleChoiceControllerWithChoices:(NSArray *)choices
                                          cellNib:(UINib *)cellNib
                                       cellHeight:(CGFloat)cellHeight
                                      customSetup:(void(^)(UITableViewCell *cell, id choice, NSInteger index, BOOL isSelected))customSetup;

/**
 *  Sets up and populates an existing instance with choice objects.
 *  This will use the default cell.
 *
 *  @param choices        The objects to be mapped to the cells (in order)
 *  @param titleForChoice Value that will be used in the cell's text label
 */
- (void)setupWithChoices:(NSArray *)choices
          titleForChoice:(NSString *(^)(id choice, NSInteger index))titleForChoice;

/**
 *  Sets up and populate an existing instance with choice objects.
 *  This will use custom cells.
 *
 *  @param choices     The objects to be mapped to the cells (in order)
 *  @param cellNib     The Nib of the custom cell
 *  @param cellHeight  The height of the cells
 *  @param customSetup A block which is called when the cell needs to be configured
 */
- (void)setupWithChoices:(NSArray *)choices
                 cellNib:(UINib *)cellNib
              cellHeight:(CGFloat)cellHeight
             customSetup:(void(^)(UITableViewCell *cell, id choice, NSInteger index, BOOL isSelected))customSetup;

@end
