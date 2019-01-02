//
//  TabbarViewController.m
//  BONJOB
//
//  Created by Infoicon Technologies on 03/05/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "TabbarViewController.h"
#import "HomeViewController.h"
#import "MyOffersViewController.h"
#import "ProfileViewController.h"
@interface TabbarViewController ()

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.delegate = self;
    [self.tabBar setTintColor:[UIColor colorWithRed:234.0/255.0 green:66.0/255.0 blue:110.0/255.0 alpha:1.0]];
  
//    UISwipeGestureRecognizer *swipeLefttoRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureright:)];
//    [swipeLefttoRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
//    [self.view addGestureRecognizer:swipeLefttoRight];
//    
//    UISwipeGestureRecognizer *swiperightoleft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureleft:)];
//    [swiperightoleft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
//    [self.view addGestureRecognizer:swiperightoleft];

   }
//- (UITraitCollection *)traitCollection {
//    return [UITraitCollection traitCollectionWithHorizontalSizeClass:UIUserInterfaceSizeClassCompact];
//}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    self.tabBar.itemPositioning = UITabBarItemPositioningCentered;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self.viewControllers  objectAtIndex:0] setTitle:NSLocalizedString(@"SEARCH", nil)];
    
    [[self.viewControllers  objectAtIndex:1] setTitle:NSLocalizedString(@"MY OFFERS", nil)];
    
    [[self.viewControllers  objectAtIndex:2] setTitle:NSLocalizedString(@"CHAT", nil)];
    [[self.viewControllers  objectAtIndex:3] setTitle:NSLocalizedString(@"ACTIVITY", nil)];
    [[self.viewControllers  objectAtIndex:4] setTitle:NSLocalizedString(@"PROFILE", nil)];
 
}
-(void)handleGestureright:(UISwipeGestureRecognizer *)sender
{
    UITabBar *tabBar = self.tabBar;
    NSInteger index = [tabBar.items indexOfObject:tabBar.selectedItem];
    if (index > 0) {
        self.selectedIndex = index - 1;
    } else {
        return;
    }
    
}
-(void)handleGestureleft:(UISwipeGestureRecognizer *)sender
{
    
    UITabBar *tabBar = self.tabBar;
    NSInteger index = [tabBar.items indexOfObject:tabBar.selectedItem];
    if (index < tabBar.items.count - 1) {
        self.selectedIndex = index + 1;
    } else {
        return;
    }}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
