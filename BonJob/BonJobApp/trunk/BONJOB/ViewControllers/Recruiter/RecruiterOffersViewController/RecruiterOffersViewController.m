//
//  RecruiterOffersViewController.m
//  BONJOB
//
//  Created by VISHAL-SETH on 7/10/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "RecruiterOffersViewController.h"
#import "RecruiterLookCandateProfileViewController.h"
#import "PostajobViewController.h"
@interface RecruiterOffersViewController ()
{
    int currentIndex;
}
@end

@implementation RecruiterOffersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //visitSelectedCandidateProfile
    
    
    [self btnCandidateAction:nil];
    [self addGestures];
    _lblCandidate.text=NSLocalizedString(@"Candidates", @"");
    _lblCandidateSelected.text=NSLocalizedString(@"Selected", @"");
    _lblCandidateHired.text=NSLocalizedString(@"Hired", @"");
    _lblMyOffers.text=NSLocalizedString(@"My offers", @"");
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(FromPublishSuccess:) name:@"PublishSuccess" object:nil];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(availableCandidateCount:) name:@"availableCandidateCount" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(SelectedCandidateCount:) name:@"selectedCandidateCount" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(HiredCandidateCount:) name:@"hiredCandidateCount" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(availabelOffersCount:) name:@"ActiveOfferCount" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setMyOfferCount:) name:@"setrecruiteroffercount" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchToOffer:) name:@"switchtomyoffer" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchToRecOffer:) name:@"PostSuccessGotoMyOffer" object:nil];
    
    // Do any additional setup after loading the view.
}

-(void)switchToRecOffer:(id)sender
{
    [self btnMyOffersAction:nil];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"PublishSuccessLoadNewData" object:nil];
}

-(void)switchToOffer:(id)sender
{
    [self btnMyOffersAction:nil];

}

-(void)setMyOfferCount:(id)sender
{
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"Recruteroffercount"] intValue]>0)
    {
        [[self.tabBarController.tabBar.items objectAtIndex:1]setBadgeValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"Recruteroffercount"]];
    }
}

    
-(void)availableCandidateCount:(NSNotification *)notification
{
    NSDictionary *dict=notification.userInfo;
    _lblAvailabelCandidateNumber.text=[dict valueForKey:@"count"];
}
-(void)SelectedCandidateCount:(NSNotification *)notification
{
    NSDictionary *dict=notification.userInfo;
    _lblSelectedCandidateNumber.text=[dict valueForKey:@"count"];
}
-(void)HiredCandidateCount:(NSNotification *)notification
{
    NSDictionary *dict=notification.userInfo;
    _lblHiredCandidateNumber.text=[dict valueForKey:@"count"];
}
-(void)availabelOffersCount:(NSNotification *)notification
{
    NSDictionary *dict=notification.userInfo;
    _lblMyOfferNumber.text=[dict valueForKey:@"count"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(FromPublishSuccess:) name:@"PublishSuccess" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(visitThisCandidateProfile:) name:@"visitCandidateProfile" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(visitSelectedCandidateProfile:) name:@"visitSelectedCandidateProfile" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(visitPostJobViewController:) name:@"visitPostJobVIewController" object:nil];
}

-(void)viewDidDisappear:(BOOL)animated
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:@"visitCandidateProfile" object:nil];
    [center removeObserver:self name:@"visitSelectedCandidateProfile" object:nil];
    [center removeObserver:self name:@"visitPostJobVIewController" object:nil];
    
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)FromPublishSuccess:(id)sender
{
    [self btnMyOffersAction:nil];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (IBAction)btnCandidateAction:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^(void)
    {
        self.containerMyOffers.alpha=0.0;
        self.containerCandidateHired.alpha=0.0;
        self.containerCandidateSelected.alpha=0.0;
        self.containerCandidate.alpha=1.0;
        _imgCadidate.image=[UIImage imageNamed:@"contanerContact_Selected.png"];
        _imgHired.image=[UIImage imageNamed:@"contanerCheck_pink.png"];
        _imgBookMark.image=[UIImage imageNamed:@"Bookmark.png"];
        _imgMyOffer.image=[UIImage imageNamed:@"paperGrey.png"];
        _lblCandidate.textColor=TitleColor;
        _lblMyOffers.textColor=[UIColor darkGrayColor];
        _lblCandidateHired.textColor=[UIColor darkGrayColor];
        _lblCandidateSelected.textColor=[UIColor darkGrayColor];
        
        _lblAvailabelCandidateNumber.textColor=TitleColor;
        _lblSelectedCandidateNumber.textColor=[UIColor darkGrayColor];
        _lblHiredCandidateNumber.textColor=[UIColor darkGrayColor];
        _lblMyOfferNumber.textColor=[UIColor darkGrayColor];
    }];
}

- (IBAction)btnCandidateSelectedAction:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^(void)
     {
         self.containerMyOffers.alpha=0.0;
         self.containerCandidateHired.alpha=0.0;
         self.containerCandidateSelected.alpha=1.0;
         self.containerCandidate.alpha=0.0;
         
         _imgCadidate.image=[UIImage imageNamed:@"contanerContact_unSelected.png"];
         _imgHired.image=[UIImage imageNamed:@"contanerCheck_pink.png"];
         _imgBookMark.image=[UIImage imageNamed:@"Bookmark_bluee.png"];
         _imgMyOffer.image=[UIImage imageNamed:@"paperGrey.png"];

         _lblMyOffers.textColor=[UIColor darkGrayColor];
         _lblCandidateHired.textColor=[UIColor darkGrayColor];
         _lblCandidateSelected.textColor=TitleColor;
         _lblCandidate.textColor=[UIColor darkGrayColor];
         
         _lblAvailabelCandidateNumber.textColor=[UIColor darkGrayColor];
         _lblSelectedCandidateNumber.textColor=TitleColor;
         _lblHiredCandidateNumber.textColor=[UIColor darkGrayColor];
         _lblMyOfferNumber.textColor=[UIColor darkGrayColor];
         
     }];
}

- (IBAction)btnCandidateHiredAction:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^(void)
     {
         self.containerMyOffers.alpha=0.0;
         self.containerCandidateHired.alpha=1.0;
         self.containerCandidateSelected.alpha=0.0;
         self.containerCandidate.alpha=0.0;
         
         _imgCadidate.image=[UIImage imageNamed:@"contanerContact_unSelected.png"];
         _imgHired.image=[UIImage imageNamed:@"contanerCheck_blue.png"];
         _imgBookMark.image=[UIImage imageNamed:@"Bookmark.png"];
         _imgMyOffer.image=[UIImage imageNamed:@"paperGrey.png"];
         _lblMyOffers.textColor=[UIColor darkGrayColor];
         _lblCandidateHired.textColor=TitleColor;
         _lblCandidateSelected.textColor=[UIColor darkGrayColor];
         _lblCandidate.textColor=[UIColor darkGrayColor];
         
         _lblAvailabelCandidateNumber.textColor=[UIColor darkGrayColor];
         _lblSelectedCandidateNumber.textColor=[UIColor darkGrayColor];
         _lblHiredCandidateNumber.textColor=TitleColor;
         _lblMyOfferNumber.textColor=[UIColor darkGrayColor];
         
     }];
}

- (IBAction)btnMyOffersAction:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^(void)
     {
         self.containerMyOffers.alpha=1.0;
         self.containerCandidateHired.alpha=0.0;
         self.containerCandidateSelected.alpha=0.0;
         self.containerCandidate.alpha=0.0;
         
         _imgCadidate.image=[UIImage imageNamed:@"contanerContact_unSelected.png"];
         _imgHired.image=[UIImage imageNamed:@"contanerCheck_pink.png"];
         _imgBookMark.image=[UIImage imageNamed:@"Bookmark.png"];
         _imgMyOffer.image=[UIImage imageNamed:@"paperBlue.png"];
         _lblMyOffers.textColor=TitleColor;
         _lblCandidateHired.textColor=[UIColor darkGrayColor];
         _lblCandidateSelected.textColor=[UIColor darkGrayColor];
         _lblCandidate.textColor=[UIColor darkGrayColor];
         
         _lblAvailabelCandidateNumber.textColor=[UIColor darkGrayColor];
         _lblSelectedCandidateNumber.textColor=[UIColor darkGrayColor];
         _lblHiredCandidateNumber.textColor=[UIColor darkGrayColor];
         _lblMyOfferNumber.textColor=TitleColor;
         
     }];
}

#pragma mark - Protocol callback

-(void)visitPostJobViewController:(NSNotification *)notification
{
    NSDictionary* userInfo = notification.userInfo;
//    [dict setValue:[NSString stringWithFormat:@"%d",Index] forKey:@"selectedIndex"];
//    [dict setValue:@"update" forKey:@"identifier"];
        //[[dictJobData valueForKey:@"ActiveJobs"] objectAtIndex:Index]
        PostajobViewController *psb=[self.storyboard instantiateViewControllerWithIdentifier:@"PostajobViewController"];
        psb.index=[userInfo valueForKey:@"selectedIndex"];
        psb.identifier=[userInfo valueForKey:@"identifier"];
    psb.isEdit = true;
    psb.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:psb animated:YES];
    
}

-(void)visitThisCandidateProfile:(NSNotification *)notification
{
    NSDictionary* userInfo = notification.userInfo;
    RecruiterLookCandateProfileViewController *rlvc=[self.storyboard instantiateViewControllerWithIdentifier:@"RecruiterLookCandateProfileViewController"];
    rlvc.jobTitle=[userInfo valueForKey:@"job_title"];
    rlvc.userId=[userInfo valueForKey:@"user_id"];
    rlvc.apply_id=[userInfo valueForKey:@"aplied_id"];
    rlvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:rlvc animated:YES];
}
-(void)visitSelectedCandidateProfile:(NSNotification *)notification
{
    NSDictionary* userInfo = notification.userInfo;
    RecruiterLookCandateProfileViewController *rlvc=[self.storyboard instantiateViewControllerWithIdentifier:@"RecruiterLookCandateProfileViewController"];
    rlvc.jobTitle=[userInfo valueForKey:@"job_title"];
    rlvc.userId=[userInfo valueForKey:@"user_id"];
    rlvc.apply_id=[userInfo valueForKey:@"aplied_id"];
    rlvc.selectedOrAvailable=@"selected";
    rlvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:rlvc animated:YES];
}

-(void)addGestures
{
    UISwipeGestureRecognizer *swipeLefttoRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureright:)];
    [swipeLefttoRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:swipeLefttoRight];

    UISwipeGestureRecognizer *swiperightoleft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGestureleft:)];
    [swiperightoleft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:swiperightoleft];
}

-(void)handleGestureright:(UISwipeGestureRecognizer *)sender
{
    
    if (currentIndex>0)
    {
        currentIndex=currentIndex-1;
    }
    switch (currentIndex)
    {
        case 0:
            [self btnCandidateAction:nil];
            break;
        case 1:
            [self btnCandidateSelectedAction:nil];
            break;
        case 2:
            [self btnCandidateHiredAction:nil];
            break;
        case 3:
            [self btnMyOffersAction:nil];
            break;
            
        default:
            break;
    }
    
}
-(void)handleGestureleft:(UISwipeGestureRecognizer *)sender
{
    if (currentIndex<4)
    {
        currentIndex=currentIndex+1;
    }
    switch (currentIndex)
    {
        case 0:
            [self btnCandidateAction:nil];
            break;
        case 1:
            [self btnCandidateSelectedAction:nil];
            break;
        case 2:
            [self btnCandidateHiredAction:nil];
            break;
        case 3:
            [self btnMyOffersAction:nil];
            break;
            
        default:
            break;
    }
    
    

}


@end
