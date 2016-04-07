//
//  ViewController.m
//  StateCityApp
//
//  Created by Yosemite on 4/5/16.
//  Copyright (c) 2016 Yosemite. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize txt_nm,txt_st,txt_ct,btn_out,tbl_vw;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    arrst=[[NSArray alloc]init];
    arrct=[[NSArray alloc]init];
    arr_main=[[NSArray alloc]init];
    
    tbl_vw.dataSource=self;
    tbl_vw.delegate=self;
    
    dbop=[[Dboperation alloc]init];
    arrst=[dbop Select2Column:@"select * from state"];
    //NSLog(@"%@",arrst);
    pkr_vw_st=[[UIPickerView alloc]init];
    pkr_vw_st.dataSource=self;
    pkr_vw_st.delegate=self;
    
    [txt_st setInputView:pkr_vw_st];
    
    txt_ct.delegate=self;
    pkr_vw_ct=[[UIPickerView alloc]init];
    pkr_vw_ct.dataSource=self;
    pkr_vw_ct.delegate=self;
    
    [txt_ct setInputView:pkr_vw_ct];
    arr_main=[dbop Select4Column:@"select s.s_id,s.s_nm,st.st_nm,ct.ct_nm from stud s inner join state st on s.s_st=st.st_id inner join city ct on s.s_ct=ct.ct_id"];
    //[tbl_vw setEditing:YES];
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==txt_ct)
    {
        NSArray *arr_st_nm=[arrst valueForKey:@"getnm"];
        //NSLog(@"%@",arr_st_nm);
        NSInteger indexst=[arr_st_nm indexOfObject:txt_st.text];
        //NSLog(@"%d",(int)indexst);
        NSString *st_id=[[arrst objectAtIndex:indexst]objectForKey:@"getid"];
        //NSLog(@"%@",st_id);
        
        NSString *query=[NSString stringWithFormat:@"select * from city where state_id='%@'",st_id];
        
        arrct=[dbop Select2Column:query];
        
        [pkr_vw_ct reloadAllComponents];
    }
}
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger index=0;
    if (pickerView==pkr_vw_st)
    {
        index=arrst.count;
    }
    if (pickerView==pkr_vw_ct)
    {
        index=arrct.count;
    }
    return index;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *index=@"";
    if (pickerView==pkr_vw_st)
    {
        index=[[arrst objectAtIndex:row]objectForKey:@"getnm"];
    }
    if (pickerView==pkr_vw_ct)
    {
        index=[[arrct objectAtIndex:row]objectForKey:@"getnm"];
    }
    return index;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView==pkr_vw_st)
    {
        txt_st.text=[[arrst objectAtIndex:row]objectForKey:@"getnm"];
    }
    if (pickerView==pkr_vw_ct)
    {
        txt_ct.text=[[arrct objectAtIndex:row]objectForKey:@"getnm"];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)ClearAll
{
    txt_nm.text=@"";
    txt_st.text=@"";
    txt_ct.text=@"";
    store_id=0;
    [btn_out setTitle:@"GO" forState:UIControlStateNormal];
    arr_main=[dbop Select4Column:@"select s.s_id,s.s_nm,st.st_nm,ct.ct_nm from stud s inner join state st on s.s_st=st.st_id inner join city ct on s.s_ct=ct.ct_id"];
    [tbl_vw reloadData];
}
- (IBAction)btn_action:(id)sender
{
    NSString *msg=@"";
    
    NSArray *arr_st_nm=[arrst valueForKey:@"getnm"];
    NSInteger indexst=[arr_st_nm indexOfObject:txt_st.text];
    NSString *st_id=[[arrst objectAtIndex:indexst]objectForKey:@"getid"];
     NSString *ct_id=@"";
   
    if ([btn_out.titleLabel.text isEqual:@"GO"])
    {
        NSArray *arr_ct_nm=[arrct valueForKey:@"getnm"];
        NSInteger indexct=[arr_ct_nm indexOfObject:txt_ct.text];
        ct_id=[[arrct objectAtIndex:indexct]objectForKey:@"getid"];
        
        NSString *query=[NSString stringWithFormat:@"insert into stud(s_nm,s_st,s_ct)values('%@','%@','%@')",txt_nm.text,st_id,ct_id];
        
        if ([dbop InsUpdDel:query])
        {
            msg=@"Inserted..";
        }
        else
        {
            msg=@"Failed..";
        }
    }
    else if ([btn_out.titleLabel.text isEqual:@"UPDATE"])
    {
        NSString *query=[NSString stringWithFormat:@"select * from city where state_id='%@'",st_id];
        
        arrct=[dbop Select2Column:query];
        
        [pkr_vw_ct reloadAllComponents];
        
        NSArray *arr_ct_nm=[arrct valueForKey:@"getnm"];
        NSInteger indexct=[arr_ct_nm indexOfObject:txt_ct.text];
        ct_id=[[arrct objectAtIndex:indexct]objectForKey:@"getid"];
        
        if (store_id!=0)
        {
            //update stud set s_nm='%@',s_st='%@',s_ct='%@' where s_id='%@'
            NSString *query=[NSString stringWithFormat:@"update stud set s_nm='%@',s_st='%@',s_ct='%@' where s_id=%d",txt_nm.text,st_id,ct_id,store_id];
            
            if ([dbop InsUpdDel:query])
            {
                msg=@"Updated..";
            }
            else
            {
                msg=@"Failed..";
            }
        }
    }
    
    UIAlertView *alrt=[[UIAlertView alloc]initWithTitle:@"Alert" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alrt show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self ClearAll];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arr_main.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    cell.textLabel.text=[[arr_main objectAtIndex:indexPath.row]objectForKey:@"s_nm"];
    cell.detailTextLabel.text=[[arr_main objectAtIndex:indexPath.row]objectForKey:@"st_nm"];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *msg=@"";
    if (editingStyle==UITableViewCellEditingStyleDelete)
    {
        NSString *query=[NSString stringWithFormat:@"delete from stud  where s_id=%d",[[[arr_main objectAtIndex:indexPath.row]objectForKey:@"s_id"]intValue]];
        
        if ([dbop InsUpdDel:query])
        {
            msg=@"Deleted..";
        }
        else
        {
            msg=@"Failed..";
        }
        UIAlertView *alrt=[[UIAlertView alloc]initWithTitle:@"Alert" message:msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alrt show];
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    txt_nm.text=[[arr_main objectAtIndex:indexPath.row]objectForKey:@"s_nm"];
    txt_st.text=[[arr_main objectAtIndex:indexPath.row]objectForKey:@"st_nm"];
    txt_ct.text=[[arr_main objectAtIndex:indexPath.row]objectForKey:@"ct_nm"];
    
    store_id=[[[arr_main objectAtIndex:indexPath.row]objectForKey:@"s_id"]intValue];
    
    [btn_out setTitle:@"UPDATE" forState:UIControlStateNormal];
}
@end
