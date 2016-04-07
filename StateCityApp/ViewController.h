//
//  ViewController.h
//  StateCityApp
//
//  Created by Yosemite on 4/5/16.
//  Copyright (c) 2016 Yosemite. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dboperation.h"
@interface ViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    Dboperation *dbop;
    NSArray *arrst;
    UIPickerView *pkr_vw_st;
    
    NSArray *arrct;
    UIPickerView *pkr_vw_ct;
    
    NSArray *arr_main;
    int store_id;
}
@property (weak, nonatomic) IBOutlet UITextField *txt_nm;
@property (weak, nonatomic) IBOutlet UITextField *txt_st;
@property (weak, nonatomic) IBOutlet UITextField *txt_ct;
- (IBAction)btn_action:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_out;
@property (weak, nonatomic) IBOutlet UITableView *tbl_vw;
@end

