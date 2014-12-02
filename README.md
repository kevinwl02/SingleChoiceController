SingleChoiceController
======================

![SingleChoiceController](/../github-media/media/doge.gif?raw=true)

Create single choice pickers in a table view. Much awesomness.

Ever needed to create pickers that are not constrained to the small UIPickerViews?
Save yourself all the boilerplate code and create your pickers faster.

##Features

* Create single choice pickers with default styles
* Create single choice pickers with custom cells

##Usage

You can create the picker with either default or custom cells.

For default cells:

```obj-c
SCCSingleChoiceTableViewController *singleChoiceController = [SCCSingleChoiceTableViewController singleChoiceControllerWithChoices:@[@"choice", @"choice2", @"choice3"] titleForChoice:^NSString *(id choice, NSInteger index) {
        return choice;
    }];
```

In here you specify the objects to be mapped to the cells. It can be any type of object (not just strings). Then, in the configuration block return the text to be used in the cell.

To create with custom cells:

```obj-c
SCCSingleChoiceTableViewController *singleChoiceController = [SCCSingleChoiceTableViewController singleChoiceControllerWithChoices:[self exampleData] cellNib:[UINib nibWithNibName:@"CustomCell" bundle:nil] cellHeight:80 customSetup:^(UITableViewCell *cell, id choice, NSInteger index, BOOL isSelected) {
        
        // Configure your custom cell
    }];
```

In case of custom cells, additionally to your objects source, you need to send the `UINib` object for your cell, a custom height and configure the cell inside the configuration block. In this case, the `isSelected` value is sent to the configuration block so that you can configure the cell's visual state for when a cell is currently selected.

##Author

Comments and suggestions much welcome

Kevin Wong, [@kevinwl02](https://twitter.com/kevinwl02)

##License

Code distributed under the [MIT license](LICENSE)