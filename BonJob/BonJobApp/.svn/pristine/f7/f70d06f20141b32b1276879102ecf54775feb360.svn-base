//
//  PositionHeldViewController.m
//  BONJOB
//
//  Created by VISHAL-SETH on 6/6/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "PositionHeldViewController.h"

@interface PositionHeldViewController ()

@end

@implementation PositionHeldViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)closePositionHeldView:(id)sender
{
    [self.delegate removeCurrentView:self];
    //[[[UIApplication sharedApplication] keyWindow].rootViewController dismissViewControllerAnimated:YES completion:nil];
    //[[UIApplication sharedApplication] keyWindow].rootViewController = newController;
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
