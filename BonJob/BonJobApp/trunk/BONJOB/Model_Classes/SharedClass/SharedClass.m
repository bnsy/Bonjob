//
//  SharedClass.m
//  BONJOB
//
//  Created by VISHAL-SETH on 6/9/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//
#import <MediaPlayer/MediaPlayer.h>
#import "SharedClass.h"
#import <AVFoundation/AVFoundation.h>
@implementation SharedClass
+ (id)sharedInstance
{
    static SharedClass *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


- (id)init
{
    if (self = [super init])
    {
        
    }
    return self;
}

+(NSString *)getUserId
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"userID"];
}
+ (NSString *)capitalizeFirstLetterOnlyOfString:(NSString *)string
{
    NSMutableString *result = [string lowercaseString].mutableCopy;
    [result replaceCharactersInRange:NSMakeRange(0, 1) withString:[[result substringToIndex:1] capitalizedString]];
    
    return result;
}
-(UIImage *)imageFromMovie:(NSURL *)movieURL atTime:(NSTimeInterval)time
{
    
    UIImage *thumbnail;
    // set up the movie player
    if (_counter==0)
    {
        self.counter=self.counter+1;
        MPMoviePlayerController *mp = [[MPMoviePlayerController alloc]
              initWithContentURL:movieURL];
        mp.shouldAutoplay = NO;
        mp.initialPlaybackTime = time;
        //mp.currentPlaybackTime = time;
        // get the thumbnail
        thumbnail = [mp thumbnailImageAtTime:time
                                           timeOption:MPMovieTimeOptionNearestKeyFrame];
    }
    
    
    // clean up the movie player
    //[mp stop];
    
    return(thumbnail);
}
+(void)setShadowLookView:(UIView *)view
{
    //view.layer.shadowColor = [UIColor darkGrayColor].CGColor;
   // view.layer.shadowOffset = CGSizeMake(0, 1);
   // view.layer.shadowOpacity = 2;
    //view.layer.shadowRadius = 3.0;
    //white border part
    //[view.layer setBorderColor: [[UIColor lightGrayColor] CGColor]];
    //[view.layer setBorderWidth: 0.5];
}

+(void)setShadowOnView:(UIView *)view
{
    view.layer.borderWidth=1.0;
    view.layer.borderColor=[UIColor lightGrayColor].CGColor;
    view.layer.cornerRadius=23.0;
    view.layer.masksToBounds=YES;
}
+(void)setBorderOnButton:(UIButton *)button
{
    //button.layer.masksToBounds=YES;
    button.layer.cornerRadius=23.0;
    // border
    //[button.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    //[button.layer setBorderWidth:0.3f];
    
    // drop shadow
    //[button.layer setShadowColor:[UIColor blackColor].CGColor];
    //[button.layer setShadowOpacity:0.8];
    //[button.layer setShadowRadius:3.0];
    //[button.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
}
+(void)setBorderOnImage:(UIImageView *)button
{
    //button.layer.masksToBounds=YES;
    //button.clipsToBounds=YES;
    //button.layer.cornerRadius=23.0;
    // border
//    [button.layer setBorderColor:[UIColor lightGrayColor].CGColor];
//    [button.layer setBorderWidth:0.3f];
    
    // drop shadow
    //[button.layer setShadowColor:[UIColor blackColor].CGColor];
    //[button.layer setShadowOpacity:0.8];
    //[button.layer setShadowRadius:3.0];
    //[button.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
}
+(void)setShadowOnTextField:(UITextField *)textfield
{
    textfield.layer.borderWidth=0.5;
    textfield.layer.borderColor=[UIColor lightGrayColor].CGColor;
    textfield.layer.masksToBounds=YES;
    textfield.layer.cornerRadius=6.0;
    
}
+(void)setShadowOnTextView:(UITextView *)textfield
{
    textfield.layer.borderWidth=0.5;
    textfield.layer.borderColor=[UIColor lightGrayColor].CGColor;
    textfield.layer.masksToBounds=YES;
    textfield.layer.cornerRadius=6.0;
}

+(void)addLabelInUITableViewViewBackGround:(UITableView *)tableView
{

    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height)];
    
    messageLabel.text =NSLocalizedString(@"Data not found", @"");
    messageLabel.textColor = [UIColor blackColor];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont fontWithName:@"Palatino-Italic" size:20];
    [messageLabel sizeToFit];
    
    tableView.backgroundView = messageLabel;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

+(void)setButtonShadow:(UIButton *)btn
{
    btn.backgroundColor = [UIColor colorWithRed:(200.0f/255.0f) green:0.0 blue:0.0 alpha:1.0];
    
    btn.layer.cornerRadius = 3.0;
    
    btn.layer.borderWidth = 2.0;
    btn.layer.borderColor = [[UIColor clearColor] CGColor];
    
    btn.layer.shadowColor = [UIColor colorWithRed:(100.0f/255.0f) green:0.0 blue:0.0 alpha:1.0].CGColor;
    btn.layer.shadowOpacity = 1.0f;
    btn.layer.shadowRadius = 1.0f;
    btn.layer.shadowOffset = CGSizeMake(0, 3);
}
+(void)showToast:(UIViewController *)vc toastMsg:(NSString *)msg
{
    
   // [Alerter.sharedInstance ShowSuccessWithMsg:msg];
    
    
    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
    style.messageFont = [UIFont fontWithName:@"Ariel" size:14.0];
    style.messageColor = [UIColor whiteColor];
    style.messageAlignment = NSTextAlignmentCenter;
    style.backgroundColor = [UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:0.9];
    
    
    [vc.navigationController.view makeToast:NSLocalizedString(msg,msg)
                                     duration:3.0
                                     position:CSToastPositionTop
                                        style:style];
}

+(void)MakeAlert:(UITextField *)textField
{
    
    // textField.layer.borderWidth = 0.8f;
    //textField.layer.borderColor = [[UIColor redColor] CGColor];
//    if (textField.text.length>0)
//    {
//        textField.textColor=[UIColor redColor];
//    }
    
    
    [self shakeView:textField];
    
    
}

+(void)DismissAlert:(UITextField *)textField
{
    //textField.textColor=[UIColor blackColor];
    //    textField.layer.borderWidth = 0.0f;
    //    textField.layer.borderColor = [[UIColor clearColor] CGColor];
    
}
+(void)MakeAlertTextView:(UITextView *)textView{
//    textView.layer.borderWidth = 1.5f;
//    textView.layer.borderColor = [[UIColor redColor] CGColor];
    [self shakeViewTextView:textView];
    
    
}
+(void)DismissAlertTextView:(UITextView *)textView{
//    textView.layer.borderWidth = 1.0f;
//    textView.layer.borderColor = [[UIColor blackColor] CGColor];
    
}

+(void)MakeAlertonLabel:(UILabel *)label{
    //    textView.layer.borderWidth = 1.5f;
    //    textView.layer.borderColor = [[UIColor redColor] CGColor];
    [self shakeViewLabel:label];
    
    
}

+(void)shakeView:(UITextField*)text
{
    CABasicAnimation *animation;
    animation=[CABasicAnimation animationWithKeyPath:@"position"];;
    [animation setFromValue:[NSValue valueWithCGPoint:CGPointMake(text.center.x - 10, text.center.y)]];
    [animation setToValue:[NSValue valueWithCGPoint:CGPointMake(text.center.x + 10, text.center.y)]];
    [animation setDuration:.07];
    animation.repeatCount = 4;
    animation.autoreverses = true;
    [text.layer addAnimation:animation forKey:@"position"];
}

+(void)shakeViewTextView:(UITextView*)text
{
    CABasicAnimation *animation;
    
    animation=[CABasicAnimation animationWithKeyPath:@"position"];;
    [animation setFromValue:[NSValue valueWithCGPoint:CGPointMake(text.center.x - 10, text.center.y)]];
    [animation setToValue:[NSValue valueWithCGPoint:CGPointMake(text.center.x + 10, text.center.y)]];
    [animation setDuration:.07];
    animation.repeatCount = 4;
    animation.autoreverses = true;
    [text.layer addAnimation:animation forKey:@"position"];
    
//    if([[UIDevice currentDevice].model isEqualToString:@"iPhone"])
//    {
//        AudioServicesPlaySystemSound (1352); //works ALWAYS as of this post
//    }
}

+(void)shakeViewLabel:(UILabel*)text
{
    CABasicAnimation *animation;
    
    animation=[CABasicAnimation animationWithKeyPath:@"position"];;
    [animation setFromValue:[NSValue valueWithCGPoint:CGPointMake(text.center.x - 10, text.center.y)]];
    [animation setToValue:[NSValue valueWithCGPoint:CGPointMake(text.center.x + 10, text.center.y)]];
    [animation setDuration:.07];
    animation.repeatCount = 4;
    animation.autoreverses = true;
    [text.layer addAnimation:animation forKey:@"position"];
    
    //    if([[UIDevice currentDevice].model isEqualToString:@"iPhone"])
    //    {
    //        AudioServicesPlaySystemSound (1352); //works ALWAYS as of this post
    //    }
}



// Date Management
+(NSString *)getDateStringFromFormat:(NSString *)dateString inputDateFormat:(NSString *)inputDateStr outputDateFormat:(NSString *)outPutDateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = inputDateStr;///@"HH:mm:ss";
    NSDate *date = [dateFormatter dateFromString:dateString];
    dateFormatter.dateFormat = outPutDateStr;//@"hh:mm a";
    NSString *outputTimeString = [dateFormatter stringFromDate:date];
    return outputTimeString;
}

+(NSDate *)getDateFromStringFormat:(NSString *)dateString inputDateFormat:(NSString *)inputDateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = inputDateStr;///@"HH:mm:ss";
    NSDate *date = [dateFormatter dateFromString:dateString];
    return date;
}

+(NSString*)getTimeDurationBetweenToDate:(NSDate*)startDate dateTo:(NSDate*)endDate{

    NSDateComponents *components;
    NSString *hour;
    NSString *min;
    NSString *sec;
    
    
    components = [[NSCalendar currentCalendar] components: NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond
                                                 fromDate: startDate toDate: endDate options: 0];
    
    hour = [NSString stringWithFormat:@"%ld",(long)[components hour]];
    min = [NSString stringWithFormat:@"%ld",(long)[components minute]];
    sec = [NSString stringWithFormat:@"%ld",(long)[components second]];
    if ([components hour]<10){
      
        hour = [NSString stringWithFormat:@"0%@",hour];
    }
    if ([components minute]<10){
        
        min = [NSString stringWithFormat:@"0%@",min];
    }
    if ([components second]<10){
        
        sec = [NSString stringWithFormat:@"0%@",sec];
    }
   
    NSString * time = [NSString stringWithFormat:@"%@:%@:%@",hour,min,sec];
    
    return time;
}

+ (UIColor *)colorWithHexString:(NSString *)hexString
{
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


+(NSString *)getCurrentTimestamp
{
    NSString * timestamp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
    return timestamp;
}

-(UIImage *)thumbnailFromVideoAtURL:(NSURL *)contentURL
{
    UIImage *theImage = nil;
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:contentURL options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.appliesPreferredTrackTransform = YES;
    NSError *err = NULL;
    CMTime time = CMTimeMake(1, 60);
    CGImageRef imgRef = [generator copyCGImageAtTime:time actualTime:NULL error:&err];
    
    theImage = [[UIImage alloc] initWithCGImage:imgRef];
    
    CGImageRelease(imgRef);
    
    return theImage;
    
}

+(void)showPopupView:(UIView *)v
{
    //    [self showPopUpView:viewPopBg popView:viewPop]; // For Add Popup view
    //    [self hidePopUpView:viewPopBg popView:viewPop]; // For Remove PopUp View
    v.translatesAutoresizingMaskIntoConstraints=YES;
    [[[UIApplication sharedApplication]keyWindow] addSubview:v];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:v];
    //v.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    //test=-----------
    UIView *view=[[UIView alloc]initWithFrame:v.frame];
    view=v;
    
    [[[UIApplication sharedApplication]keyWindow] addSubview:view];
    //----------------
    v.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         v.transform = CGAffineTransformIdentity;
                         
                     } completion:^(BOOL finished){
                         
                     }];
}
+(void)hidePopupView:(UIView *)v
{
    v.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         v.transform = CGAffineTransformMakeScale(0.01, 0.01);
                         
                     } completion:^(BOOL finished){
                         
                         [v  setHidden:YES];
                     }];
}

+(void)showPopupView:(UIView *)v andTabbar:(UITabBarController *)tabbar
{
    v.translatesAutoresizingMaskIntoConstraints=YES;
    
    //[tabbar.view.window bringSubviewToFront:v];
    [[UIApplication sharedApplication].keyWindow addSubview:v];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:v];
    
    // test
    
    
    //--------
    
    //[tabbar.view sendSubviewToBack:v];
    //v.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, tabbar.view.frame.size.height-49,tabbar.view.frame.size.width, 49)];
    view.backgroundColor=[UIColor darkGrayColor];
    [view setAlpha:0.7];
    [view setTag:1200];
    
    v.transform = CGAffineTransformMakeScale(0.01, 0.01);
    view.transform=CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         v.transform = CGAffineTransformIdentity;
                         view.transform = CGAffineTransformIdentity;
                         
                         [tabbar.view addSubview:view];
                         
                     } completion:^(BOOL finished){
                         
                     }];

}
+(void)hidePopupView:(UIView *)v andTabbar:(UITabBarController *)tabbar
{
    v.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         v.transform = CGAffineTransformMakeScale(0.01, 0.01);
                         UIView *view=[tabbar.view viewWithTag:1200];
                         [view removeFromSuperview];
                         
                     } completion:^(BOOL finished){
                         
                         [v  setHidden:YES];
                     }];

}

+(void)showPopupViewforPreview:(UIView *)v andTabbar:(UITabBarController *)tabbar
{
    v.translatesAutoresizingMaskIntoConstraints=YES;
    
    //[tabbar.view.window bringSubviewToFront:v];
    [[UIApplication sharedApplication].keyWindow addSubview:v];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:v];
    
    // test
    
    
    //--------
    
    //[tabbar.view sendSubviewToBack:v];
    //v.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, tabbar.view.frame.size.height-49,tabbar.view.frame.size.width, 49)];
    view.backgroundColor=[UIColor darkGrayColor];
    [view setAlpha:0.7];
    [view setTag:1200];
    
    //v.transform = CGAffineTransformMakeScale(0.01, 0.01);
   // view.transform=CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                        // v.transform = CGAffineTransformIdentity;
                       //  view.transform = CGAffineTransformIdentity;
                         
                         [tabbar.view addSubview:view];
                         
                     } completion:^(BOOL finished){
                         
                     }];
    
}
+(void)hidePopupViewforPreview:(UIView *)v andTabbar:(UITabBarController *)tabbar
{
 //   v.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                      //   v.transform = CGAffineTransformMakeScale(0.01, 0.01);
                         UIView *view=[tabbar.view viewWithTag:1200];
                         [view removeFromSuperview];
                         
                     } completion:^(BOOL finished){
                         
                         [v  setHidden:YES];
                     }];
    
}

+(void)showPopupViewforPreview:(UIView *)v
{
    //    [self showPopUpView:viewPopBg popView:viewPop]; // For Add Popup view
    //    [self hidePopUpView:viewPopBg popView:viewPop]; // For Remove PopUp View
    v.translatesAutoresizingMaskIntoConstraints=YES;
    [[[UIApplication sharedApplication]keyWindow] addSubview:v];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:v];
    //v.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    //test=-----------
    UIView *view=[[UIView alloc]initWithFrame:v.frame];
    view=v;
    
    [[[UIApplication sharedApplication]keyWindow] addSubview:view];
    //----------------
   // v.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                     //    v.transform = CGAffineTransformIdentity;
                         
                     } completion:^(BOOL finished){
                         
                     }];
}
+(void)hidePopupViewforPreview:(UIView *)v
{
    //v.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                    //     v.transform = CGAffineTransformMakeScale(0.01, 0.01);
                         
                     } completion:^(BOOL finished){
                         
                         [v  setHidden:YES];
                     }];
}


+(NSMutableArray *)getJobOffer
{
    NSString *currentLang;
    currentLang = [[NSLocale preferredLanguages] objectAtIndex:0]; // code for get language code from device
    NSArray* foo = [currentLang componentsSeparatedByString: @"-"];
    currentLang = [foo objectAtIndex: 0];
    NSMutableArray *arrJobOffer=[[NSMutableArray alloc]init];
    if (([currentLang isEqualToString:@"fr"]))
    {
        [arrJobOffer addObject:@"Adjoint(e) de direction"];
        [arrJobOffer addObject:@"Agent de réservation"];
        [arrJobOffer addObject:@"Attaché(e) commercial(e)"];
        [arrJobOffer addObject:@"Bagagiste"];
        [arrJobOffer addObject:@"Barman"];
        [arrJobOffer addObject:@"Boucher"];
        [arrJobOffer addObject:@"Boulanger"];
        [arrJobOffer addObject:@"Charcutier"];
        [arrJobOffer addObject:@"Chargé(e) de projets événementiel"];
        [arrJobOffer addObject:@"Chasseur"];
        [arrJobOffer addObject:@"Chef cuisinier"];
        [arrJobOffer addObject:@"Chef cuisinier en restauration collective"];
        [arrJobOffer addObject:@"Chef d'équipe en restauration collective"];
        [arrJobOffer addObject:@"Chef d'équipe en restauration rapide"];
        [arrJobOffer addObject:@"Chef de cuisine"];
        [arrJobOffer addObject:@"Chef de maintenance"];
        [arrJobOffer addObject:@"Chef de partie"];
        [arrJobOffer addObject:@"Chef de production en restauration collective"];
        [arrJobOffer addObject:@"Chef de rang"];
        [arrJobOffer addObject:@"Chef de rang room service"];
        [arrJobOffer addObject:@"Chef de réception"];
        [arrJobOffer addObject:@"Chef gérant"];
        [arrJobOffer addObject:@"Chef sommelier"];
        [arrJobOffer addObject:@"Chocolatier / Confiseur"];
        [arrJobOffer addObject:@"Commis de cuisine"];
        [arrJobOffer addObject:@"Commis de salle"];
        [arrJobOffer addObject:@"Concierge de grand hôtel"];
        [arrJobOffer addObject:@"Crêpier"];
        [arrJobOffer addObject:@"Cuisinier"];
        [arrJobOffer addObject:@"Cuisinier dans la fonction publique"];
        [arrJobOffer addObject:@"Diététicien(ne)"];
        [arrJobOffer addObject:@"Diététicien(ne) d'exploitation"];
        [arrJobOffer addObject:@"Directeur adjoint en restauration rapide"];
        [arrJobOffer addObject:@"Directeur commercial"];
        [arrJobOffer addObject:@"Directeur d’hôtel"];
        [arrJobOffer addObject:@"Directeur de l'hébergement"];
        [arrJobOffer addObject:@"Directeur de la restauration"];
        [arrJobOffer addObject:@"Directeur de restaurant"];
        [arrJobOffer addObject:@"Directeur en restauration rapide"];
        [arrJobOffer addObject:@"Ecailler"];
        [arrJobOffer addObject:@"Économe"];
        [arrJobOffer addObject:@"Employé(e) d’étage"];
        [arrJobOffer addObject:@"Employé(e) de café"];
        [arrJobOffer addObject:@"Employé(e) de restauration"];
        [arrJobOffer addObject:@"Employé(e) de restauration secteur Cuisine"];
        [arrJobOffer addObject:@"Employé(e) de restauration secteur Service"];
        [arrJobOffer addObject:@"Employé(e) polyvalent(e) en restauration collective"];
        [arrJobOffer addObject:@"Équipier en restauration rapide"];
        [arrJobOffer addObject:@"Exploitant de café, bar, brasserie"];
        [arrJobOffer addObject:@"Exploitant en restauration"];
        [arrJobOffer addObject:@"Femme de chambre"];
        [arrJobOffer addObject:@"Fromager"];
        [arrJobOffer addObject:@"Garçon de café"];
        [arrJobOffer addObject:@"Gérant / Chef-gérant en restauration collective"];
        [arrJobOffer addObject:@"Gouvernante"];
        [arrJobOffer addObject:@"Gouvernante générale"];
        [arrJobOffer addObject:@"Groom"];
        [arrJobOffer addObject:@"Guest relation manager"];
        [arrJobOffer addObject:@"Hôte / Hôtesse d'accueil"];

        [arrJobOffer addObject:@"Liftier"];
        [arrJobOffer addObject:@"Limonadier"];
        [arrJobOffer addObject:@"Lingère"];
        [arrJobOffer addObject:@"Maître d’hôtel"];
        [arrJobOffer addObject:@"Majordome"];
        [arrJobOffer addObject:@"Manager dans la restauration"];
        [arrJobOffer addObject:@"Manager en restauration rapide"];
        [arrJobOffer addObject:@"Manager spécialisé dans le luxe"];
        [arrJobOffer addObject:@"Night Auditor"];
        [arrJobOffer addObject:@"Pâtissier"];
        [arrJobOffer addObject:@"Pizzaïolo"];
        [arrJobOffer addObject:@"Plongeur"];
        [arrJobOffer addObject:@"Poissonnier"];
        [arrJobOffer addObject:@"Portier"];
        [arrJobOffer addObject:@"Préparateur / Vendeur en restauration rapide"];
        [arrJobOffer addObject:@"Réceptionniste"];
        [arrJobOffer addObject:@"Réceptionniste de nuit"];
        [arrJobOffer addObject:@"Responsable de salle"];
        [arrJobOffer addObject:@"Responsable room service"];
        [arrJobOffer addObject:@"Revenue ou Yield Manager"];
        [arrJobOffer addObject:@"Second de cuisine"];
        [arrJobOffer addObject:@"Serveur"];
        [arrJobOffer addObject:@"Sommelier"];
        [arrJobOffer addObject:@"Sous-chef"];
        [arrJobOffer addObject:@"Spa manager"];
        [arrJobOffer addObject:@"Technicien de maintenance"];
        [arrJobOffer addObject:@"Traiteur"];
        [arrJobOffer addObject:@"Traiteur / Organisateur de réception"];
        [arrJobOffer addObject:@"Valet de chambre"];
        [arrJobOffer addObject:@"Veilleur de nuit"];
        [arrJobOffer addObject:@"Vendeur"];
        [arrJobOffer addObject:@"Voiturier"];
    }
    else
    {
        [arrJobOffer addObject:@"Apprentice Bartender"];
        [arrJobOffer addObject:@"Area Director"];
        [arrJobOffer addObject:@"Assistant Chef"];
        [arrJobOffer addObject:@"Assistant General Manager"];
        [arrJobOffer addObject:@"Assistant Kitchen Manager"];
        [arrJobOffer addObject:@"Associate Creative Director"];
        [arrJobOffer addObject:@"Back Office Assistant"];
        [arrJobOffer addObject:@"Back Office Supervisor"];
        [arrJobOffer addObject:@"Backwaiter"];
        [arrJobOffer addObject:@"Baker"];
        [arrJobOffer addObject:@"Bakery-Cafe Associate"];
        [arrJobOffer addObject:@"Banquet Manager"];
        [arrJobOffer addObject:@"Banquet Server"];
        [arrJobOffer addObject:@"Bar Manager"];
        [arrJobOffer addObject:@"Bar Staff"];
        [arrJobOffer addObject:@"Barback"];
        [arrJobOffer addObject:@"Barista"];
        [arrJobOffer addObject:@"Bartender"];
        [arrJobOffer addObject:@"Bartender"];
        [arrJobOffer addObject:@"Bell Attendant"];
        [arrJobOffer addObject:@"Bellhop"];
        [arrJobOffer addObject:@"Bellman"];
        [arrJobOffer addObject:@"Bellperson"];
        [arrJobOffer addObject:@"Brand Manager"];
        [arrJobOffer addObject:@"Bus Person"];
        [arrJobOffer addObject:@"Busser"];
        [arrJobOffer addObject:@"Cafe Manager"];
        [arrJobOffer addObject:@"Cashier"];
        [arrJobOffer addObject:@"Casual Restaurant Manager"];
        [arrJobOffer addObject:@"Catering Manager"];
        [arrJobOffer addObject:@"Catering Sales Manager"];
        [arrJobOffer addObject:@"Chef"];
        [arrJobOffer addObject:@"Chef"];
        [arrJobOffer addObject:@"Chef Manager"];
        [arrJobOffer addObject:@"Coffee Tasting Room Assistant"];
        [arrJobOffer addObject:@"Communications Manager"];
        [arrJobOffer addObject:@"Concierge"];
        [arrJobOffer addObject:@"Concierge Agent"];
        [arrJobOffer addObject:@"Cook"];
        [arrJobOffer addObject:@"Corporate Sales Manager"];
        [arrJobOffer addObject:@"Crew Member"];
        [arrJobOffer addObject:@"Culinary Services Supervisor"];
        [arrJobOffer addObject:@"Culinary Trainee"];
        [arrJobOffer addObject:@"Dessert Finisher"];
        [arrJobOffer addObject:@"Digital Marketing Manager"];
        [arrJobOffer addObject:@"Dining Room Manager"];
        [arrJobOffer addObject:@"Director of Hotel Operations"];
        [arrJobOffer addObject:@"Director of Hotel Sales"];
        [arrJobOffer addObject:@"Director of Human Resources"];
        [arrJobOffer addObject:@"Director of Maintenance"];
        [arrJobOffer addObject:@"Director of Marketing"];
        [arrJobOffer addObject:@"Director of Operations"];
        [arrJobOffer addObject:@"Director of Sales"];
        [arrJobOffer addObject:@"Dishwasher"];
        [arrJobOffer addObject:@"Dishwasher"];
        [arrJobOffer addObject:@"District Manager"];
        [arrJobOffer addObject:@"Driver"];
        [arrJobOffer addObject:@"Espresso Beverage Maker"];
        [arrJobOffer addObject:@"Event Planner"];
        [arrJobOffer addObject:@"Events Manager"];
        [arrJobOffer addObject:@"Executive Chef"];
        [arrJobOffer addObject:@"Executive Conference Manager"];
        [arrJobOffer addObject:@"Executive Housekeeper"];
        [arrJobOffer addObject:@"Executive Meeting Manager"];
        [arrJobOffer addObject:@"Expeditor"];
        [arrJobOffer addObject:@"Field Recruiting Manager"];
        [arrJobOffer addObject:@"Fine Dining Restaurant Manager"];
        [arrJobOffer addObject:@"Food and Beverage Manager"];
        [arrJobOffer addObject:@"Food Runner"];
        [arrJobOffer addObject:@"Food Server"];
        [arrJobOffer addObject:@"Front Desk Agent"];
        [arrJobOffer addObject:@"Front Desk Associate"];
        [arrJobOffer addObject:@"Front Desk Clerk"];
        [arrJobOffer addObject:@"Front Desk Sales and Service Associate"];
        [arrJobOffer addObject:@"Front Desk Supervisor"];
        [arrJobOffer addObject:@"Front Manager"];
        [arrJobOffer addObject:@"Front Office Associate"];
        [arrJobOffer addObject:@"Front Office Associate"];
        [arrJobOffer addObject:@"Front Office Attendant"];
        [arrJobOffer addObject:@"Gardener"];
        [arrJobOffer addObject:@"General Manager"];
        [arrJobOffer addObject:@"Greeter"];
        [arrJobOffer addObject:@"Grill Cook"];
        [arrJobOffer addObject:@"Groundskeeper"];
        [arrJobOffer addObject:@"Group Sales Coordinator"];
        [arrJobOffer addObject:@"Group Sales Manager"];
        [arrJobOffer addObject:@"Guest Room Sales Manager"];
        [arrJobOffer addObject:@"Guest Service Representative"];
        [arrJobOffer addObject:@"Guest Services Associate"];
        [arrJobOffer addObject:@"Guest Services Coordinator"];
        [arrJobOffer addObject:@"Guest Services Manager"];
        [arrJobOffer addObject:@"Guest Services Supervisor"];
        [arrJobOffer addObject:@"Hibachi Chef"];
        [arrJobOffer addObject:@"Host"];
        [arrJobOffer addObject:@"Host"];
        [arrJobOffer addObject:@"Hostess"];
        [arrJobOffer addObject:@"Hotel Deposit Clerk"];
        [arrJobOffer addObject:@"Hotel Group Sales Manager"];
        [arrJobOffer addObject:@"Housekeeper"];
        [arrJobOffer addObject:@"Housekeeper Aide"];
        [arrJobOffer addObject:@"Housekeeping Supervisor"];
        [arrJobOffer addObject:@"Human Resources Manager"];
        [arrJobOffer addObject:@"Inventory Analyst"];
        [arrJobOffer addObject:@"Kitchen Manager"];
        [arrJobOffer addObject:@"Kitchen Manager"];
        [arrJobOffer addObject:@"Kitchen Team Member"];
        [arrJobOffer addObject:@"Kitchen Worker"];
        [arrJobOffer addObject:@"Lead Cook"];
        [arrJobOffer addObject:@"Lead Housekeeper"];
        [arrJobOffer addObject:@"Line Cook"];
        [arrJobOffer addObject:@"Maintenance Supervisor"];
        [arrJobOffer addObject:@"Maintenance Worker"];
        [arrJobOffer addObject:@"Manager, Research and Development"];
        [arrJobOffer addObject:@"Manager, Special Events"];
        [arrJobOffer addObject:@"Marketing Coordinator"];
        [arrJobOffer addObject:@"Meeting Concierge"];
        [arrJobOffer addObject:@"Meeting Coordinator"];
        [arrJobOffer addObject:@"Meeting Manager"];
        [arrJobOffer addObject:@"Meeting Planner"];
        [arrJobOffer addObject:@"Meeting Specialist"];
        [arrJobOffer addObject:@"Mini-Bar Attendant"];
        [arrJobOffer addObject:@"National Training Manager"];
        [arrJobOffer addObject:@"Night Auditor"];
        [arrJobOffer addObject:@"Night Clerk"];
        [arrJobOffer addObject:@"Operations Analyst"];
        [arrJobOffer addObject:@"Pantry Worker"];
        [arrJobOffer addObject:@"Porter"];
        [arrJobOffer addObject:@"Prep Cook"];
        [arrJobOffer addObject:@"Product Manager"];
        [arrJobOffer addObject:@"Public Relations Coordinator"];
        [arrJobOffer addObject:@"Public Relations Manager"];
         [arrJobOffer addObject:@"Regional Brand Development Manager"];
         [arrJobOffer addObject:@"Regional Facilities Manager"];
         [arrJobOffer addObject:@"Regional Manager"];
         [arrJobOffer addObject:@"Regional Operations Specialist"];
         [arrJobOffer addObject:@"Reservations Agent"];
         [arrJobOffer addObject:@"Restaurant General Manager"];
         [arrJobOffer addObject:@"Restaurant Manager"];
         [arrJobOffer addObject:@"Room Attendant"];
         [arrJobOffer addObject:@"Room Service Manager"];
         [arrJobOffer addObject:@"Room Service Worker"];
         [arrJobOffer addObject:@"Sales and Marketing Coordinator"];
         [arrJobOffer addObject:@"Sales Coordinator"];
         [arrJobOffer addObject:@"Sales Manager"];
         [arrJobOffer addObject:@"Server"];
         [arrJobOffer addObject:@"Server"];
         [arrJobOffer addObject:@"Shift Leader"];
         [arrJobOffer addObject:@"Shift Manager"];
         [arrJobOffer addObject:@"Shift Supervisor"];
        [arrJobOffer addObject:@"Sous Chef"];
        [arrJobOffer addObject:@"Steward"];
        [arrJobOffer addObject:@"Team Member"];
        [arrJobOffer addObject:@"Transportation Coordinator"];
        [arrJobOffer addObject:@"Valet Attendant"];
        [arrJobOffer addObject:@"Valet Parker"];
        [arrJobOffer addObject:@"Valet Parking Attendant"];
        [arrJobOffer addObject:@"Wait Staff"];
        [arrJobOffer addObject:@"Waiter"];
        [arrJobOffer addObject:@"Waitress"];
        [arrJobOffer addObject:@"Wedding Coordinator"];
        [arrJobOffer addObject:@"Wedding Sales Manager"];
     }
    return arrJobOffer;
    
}
+(NSMutableArray *)getCuisineService
{
    NSString *currentLang;
    currentLang = [[NSLocale preferredLanguages] objectAtIndex:0]; // code for get language code from device
    NSArray* foo = [currentLang componentsSeparatedByString: @"-"];
    currentLang = [foo objectAtIndex: 0];
    NSMutableArray *arrCuisineService=[[NSMutableArray alloc]init];
    if (([currentLang isEqualToString:@"fr"]))
    {
        [arrCuisineService addObject:@"Boucher"];
        [arrCuisineService addObject:@"Boulanger"];
        [arrCuisineService addObject:@"Charcutier"];
        [arrCuisineService addObject:@"Chargé(e) de projets événementiel"];
        [arrCuisineService addObject:@"Chef cuisinier"];
        [arrCuisineService addObject:@"Chef cuisinier en restauration collective"];
        [arrCuisineService addObject:@"Chef d'équipe en restauration collective"];
        [arrCuisineService addObject:@"Chef d'équipe en restauration rapide"];
        [arrCuisineService addObject:@"Chef de cuisine"];
        [arrCuisineService addObject:@"Chef de partie"];
        [arrCuisineService addObject:@"Chef de production en restauration collective"];
        [arrCuisineService addObject:@"Chef gérant"];
        [arrCuisineService addObject:@"Chocolatier / Confiseur"];
        [arrCuisineService addObject:@"Commis de cuisine"];
        [arrCuisineService addObject:@"Crêpier"];
        [arrCuisineService addObject:@"Cuisinier"];
        [arrCuisineService addObject:@"Cuisinier dans la fonction publique"];
        [arrCuisineService addObject:@"Diététicien(ne)"];
        [arrCuisineService addObject:@"Diététicien(ne) d'exploitation"];
        [arrCuisineService addObject:@"Directeur adjoint en restauration rapide"];
        [arrCuisineService addObject:@"Directeur de la restauration"];
        [arrCuisineService addObject:@"Directeur de restaurant"];
        [arrCuisineService addObject:@"Directeur en restauration rapide"];
        [arrCuisineService addObject:@"Ecailler"];
        [arrCuisineService addObject:@"Économe"];
        [arrCuisineService addObject:@"Employé(e) de restauration"];
        [arrCuisineService addObject:@"Employé(e) de restauration secteur Cuisine"];
        [arrCuisineService addObject:@"Employé(e) polyvalent(e) en restauration collective"];
        [arrCuisineService addObject:@"Exploitant en restauration"];
        [arrCuisineService addObject:@"Fromager"];
        [arrCuisineService addObject:@"Gérant / Chef-gérant en restauration collective"];
        [arrCuisineService addObject:@"Manager dans la restauration"];
        [arrCuisineService addObject:@"Manager en restauration rapide"];
        [arrCuisineService addObject:@"Pâtissier"];
        [arrCuisineService addObject:@"Pizzaïolo"];
        [arrCuisineService addObject:@"Plongeur"];
        [arrCuisineService addObject:@"Poissonnier"];
        [arrCuisineService addObject:@"Préparateur / Vendeur en restauration rapide"];
        [arrCuisineService addObject:@"Revenue ou Yield Manager"];
        [arrCuisineService addObject:@"Second de cuisine"];
        [arrCuisineService addObject:@"Sous-chef"];
        [arrCuisineService addObject:@"Traiteur"];
        [arrCuisineService addObject:@"Traiteur / Organisateur de réception"];
        
    }
    else
    {
        [arrCuisineService addObject:@"Apprentice Bartender"];
        [arrCuisineService addObject:@"Area Director"];
        [arrCuisineService addObject:@"Assistant Chef"];
        [arrCuisineService addObject:@"Assistant General Manager"];
        [arrCuisineService addObject:@"Assistant Kitchen Manager"];
        [arrCuisineService addObject:@"Associate Creative Director"];
        [arrCuisineService addObject:@"Baker"];
        [arrCuisineService addObject:@"Bakery-Cafe Associate"];
        [arrCuisineService addObject:@"Barback"];
        [arrCuisineService addObject:@"Barista"];
        [arrCuisineService addObject:@"Bar Manager"];
        [arrCuisineService addObject:@"Bartender"];
        [arrCuisineService addObject:@"Brand Manager"];
        [arrCuisineService addObject:@"Bus Person"];
        [arrCuisineService addObject:@"Cashier"];
        [arrCuisineService addObject:@"Casual Restaurant Manager"];
        [arrCuisineService addObject:@"Chef"];
        [arrCuisineService addObject:@"Chef Manager"];
        [arrCuisineService addObject:@"Coffee Tasting Room Assistant"];
        [arrCuisineService addObject:@"Communications Manager"];
        [arrCuisineService addObject:@"Cook"];
        [arrCuisineService addObject:@"Culinary Services Supervisor"];
        [arrCuisineService addObject:@"Culinary Trainee"];
        [arrCuisineService addObject:@"Dessert Finisher"];
        [arrCuisineService addObject:@"Digital Marketing Manager"];
        [arrCuisineService addObject:@"Dining Room Manager"];
        [arrCuisineService addObject:@"Director of Human Resources"];
        [arrCuisineService addObject:@"Dishwasher"];
        [arrCuisineService addObject:@"District Manager"];
        [arrCuisineService addObject:@"Espresso Beverage Maker"];
        [arrCuisineService addObject:@"Executive Chef"];
        [arrCuisineService addObject:@"Expeditor"];
        [arrCuisineService addObject:@"Field Recruiting Manager"];
        [arrCuisineService addObject:@"Fine Dining Restaurant Manager"];
        [arrCuisineService addObject:@"Food Runner"];
        [arrCuisineService addObject:@"Front Manager"];
        [arrCuisineService addObject:@"Grill Cook"];
        [arrCuisineService addObject:@"Hibachi Chef"];
        [arrCuisineService addObject:@"Host"];
        [arrCuisineService addObject:@"Human Resources Manager"];
        [arrCuisineService addObject:@"Inventory Analyst"];
        [arrCuisineService addObject:@"Kitchen Manager"];
        [arrCuisineService addObject:@"Kitchen Worker"];
        [arrCuisineService addObject:@"Lead Cook"];
        [arrCuisineService addObject:@"Line Cook"];
        [arrCuisineService addObject:@"Manager, Research and Development"];
        [arrCuisineService addObject:@"National Training Manager"];
        [arrCuisineService addObject:@"Operations Analyst"];
        [arrCuisineService addObject:@"Pantry Worker"];
        [arrCuisineService addObject:@"Prep Cook"];
        [arrCuisineService addObject:@"Product Manager"];
        [arrCuisineService addObject:@"Regional Brand Development Manager"];
        [arrCuisineService addObject:@"Regional Facilities Manager"];
        [arrCuisineService addObject:@"Regional Manager"];
        [arrCuisineService addObject:@"Regional Operations Specialist"];
        [arrCuisineService addObject:@"Restaurant General Manager"];
        [arrCuisineService addObject:@"Restaurant Manager"];
        [arrCuisineService addObject:@"Server"];
        [arrCuisineService addObject:@"Shift Supervisor"];
        [arrCuisineService addObject:@"Sous Chef"];
        [arrCuisineService addObject:@"Steward"];
    }
    return arrCuisineService;
}
+(NSMutableArray *)getSelleService
{
    NSString *currentLang;
    currentLang = [[NSLocale preferredLanguages] objectAtIndex:0]; // code for get language code from device
    NSArray* foo = [currentLang componentsSeparatedByString: @"-"];
    currentLang = [foo objectAtIndex: 0];
    NSMutableArray *arrSelleService=[[NSMutableArray alloc]init];
    if (([currentLang isEqualToString:@"en"]))
    {
        [arrSelleService addObject:@"Backwaiter"];
        [arrSelleService addObject:@"Banquet Server"];
        [arrSelleService addObject:@"Banquet Manager"];
        [arrSelleService addObject:@"Bartender"];
        [arrSelleService addObject:@"Bar Staff"];
        [arrSelleService addObject:@"Busser"];
        [arrSelleService addObject:@"Cafe Manager"];
        [arrSelleService addObject:@"Catering Manager"];
        [arrSelleService addObject:@"Catering Sales Manager"];
        [arrSelleService addObject:@"Chef"];
        [arrSelleService addObject:@"Cook"];
        [arrSelleService addObject:@"Dishwasher"];
        [arrSelleService addObject:@"Food and Beverage Manager"];
        [arrSelleService addObject:@"Food Runner"];
        [arrSelleService addObject:@"Food Server"];
        [arrSelleService addObject:@"Host"];
        [arrSelleService addObject:@"Hostess"];
        [arrSelleService addObject:@"Kitchen Team Member"];
        [arrSelleService addObject:@"Kitchen Manager"];
        [arrSelleService addObject:@"Restaurant Manager"];
        [arrSelleService addObject:@"Server"];
        [arrSelleService addObject:@"Wait Staff"];
        [arrSelleService addObject:@"Waiter"];
        [arrSelleService addObject:@"Waitress"];
    }
    else
    {
        [arrSelleService addObject:@"Agent de réservation"];
        [arrSelleService addObject:@"Barman"];
        [arrSelleService addObject:@"Chef de rang"];
        [arrSelleService addObject:@"Chef sommelier"];
        [arrSelleService addObject:@"Commis de salle"];
        [arrSelleService addObject:@"Employé(e) de café"];
        [arrSelleService addObject:@"Employé(e) de restauration secteur Service"];
        [arrSelleService addObject:@"Équipier en restauration rapide"];
        [arrSelleService addObject:@"Exploitant de café, bar, brasserie"];
        [arrSelleService addObject:@"Garçon de café"];
        [arrSelleService addObject:@"Hôte / Hôtesse d'accueil"];
        [arrSelleService addObject:@"Limonadier"];
        [arrSelleService addObject:@"Maître d’hôtel"];
        [arrSelleService addObject:@"Majordome"];
        [arrSelleService addObject:@"Responsable de salle"];
        [arrSelleService addObject:@"Serveur"];
        [arrSelleService addObject:@"Sommelier"];
        [arrSelleService addObject:@"Vendeur"];
        
    }
    return arrSelleService;
}
+(NSMutableArray *)getHotelService
{
    NSString *currentLang;
    currentLang = [[NSLocale preferredLanguages] objectAtIndex:0]; // code for get language code from device
    NSArray* foo = [currentLang componentsSeparatedByString: @"-"];
    currentLang = [foo objectAtIndex: 0];
    NSMutableArray *arrHotelService=[[NSMutableArray alloc]init];
    if (([currentLang isEqualToString:@"en"]))
    {
        [arrHotelService addObject:@"Back Office Assistant"];
        [arrHotelService addObject:@"Back Office Supervisor"];
        [arrHotelService addObject:@"Bell Attendant"];
        [arrHotelService addObject:@"Bellhop"];
        [arrHotelService addObject:@"Bellman"];
        [arrHotelService addObject:@"Bellperson"];
        [arrHotelService addObject:@"Concierge"];
        [arrHotelService addObject:@"Concierge Agent"];
        [arrHotelService addObject:@"Corporate Sales Manager"];
        [arrHotelService addObject:@"Crew Member"];
        [arrHotelService addObject:@"Director of Hotel Operations"];
        [arrHotelService addObject:@"Director of Hotel Sales"];
        [arrHotelService addObject:@"Director of Maintenance"];
        [arrHotelService addObject:@"Director of Marketing"];
        [arrHotelService addObject:@"Director of Operations"];
        [arrHotelService addObject:@"Director of Sales"];
        [arrHotelService addObject:@"Driver"];
        [arrHotelService addObject:@"Event Planner"];
        [arrHotelService addObject:@"Events Manager"];
        [arrHotelService addObject:@"Executive Conference Manager"];
        [arrHotelService addObject:@"Executive Housekeeper"];
        [arrHotelService addObject:@"Executive Meeting Manager"];
        [arrHotelService addObject:@"Front Desk Agent"];
        [arrHotelService addObject:@"Front Desk Associate"];
        [arrHotelService addObject:@"Front Desk Clerk"];
        [arrHotelService addObject:@"Front Desk Sales and Service Associate"];
        [arrHotelService addObject:@"Front Desk Supervisor"];
        [arrHotelService addObject:@"Front Office Associate"];
        [arrHotelService addObject:@"Front Office Associate"];
        [arrHotelService addObject:@"Front Office Attendant"];
        [arrHotelService addObject:@"Gardener"];
        [arrHotelService addObject:@"General Manager"];
        [arrHotelService addObject:@"Greeter"];
        [arrHotelService addObject:@"Groundskeeper"];
        [arrHotelService addObject:@"Group Sales Coordinator"];
        [arrHotelService addObject:@"Group Sales Manager"];
        [arrHotelService addObject:@"Guest Room Sales Manager"];
        [arrHotelService addObject:@"Guest Service Representative"];
        [arrHotelService addObject:@"Guest Services Associate"];
        [arrHotelService addObject:@"Guest Services Coordinator"];
        [arrHotelService addObject:@"Guest Services Manager"];
        [arrHotelService addObject:@"Guest Services Supervisor"];
        [arrHotelService addObject:@"Hotel Deposit Clerk"];
        [arrHotelService addObject:@"Hotel Group Sales Manager"];
        [arrHotelService addObject:@"Housekeeper"];
        [arrHotelService addObject:@"Housekeeper Aide"];
        [arrHotelService addObject:@"Housekeeping Supervisor"];
        [arrHotelService addObject:@"Lead Housekeeper"];
        [arrHotelService addObject:@"Maintenance Supervisor"];
        [arrHotelService addObject:@"Maintenance Worker"];
        [arrHotelService addObject:@"Manager, Special Events"];
        [arrHotelService addObject:@"Marketing Coordinator"];
        [arrHotelService addObject:@"Meeting Concierge"];
        [arrHotelService addObject:@"Meeting Coordinator"];
        [arrHotelService addObject:@"Meeting Manager"];
        [arrHotelService addObject:@"Meeting Planner"];
        [arrHotelService addObject:@"Meeting Specialist"];
        [arrHotelService addObject:@"Mini-Bar Attendant"];
        [arrHotelService addObject:@"Night Auditor"];
        [arrHotelService addObject:@"Night Clerk"];
        [arrHotelService addObject:@"Porter"];
        [arrHotelService addObject:@"Public Relations Coordinator"];
        [arrHotelService addObject:@"Public Relations Manager"];
        [arrHotelService addObject:@"Reservations Agent"];
        [arrHotelService addObject:@"Room Attendant"];
        [arrHotelService addObject:@"Room Service Manager"];
        [arrHotelService addObject:@"Room Service Worker"];
        [arrHotelService addObject:@"Sales and Marketing Coordinator"];

        [arrHotelService addObject:@"Sales Coordinator"];
        [arrHotelService addObject:@"Sales Manager"];
        [arrHotelService addObject:@"Shift Leader"];
        [arrHotelService addObject:@"Shift Manager"];

        [arrHotelService addObject:@"Team Member"];
        [arrHotelService addObject:@"Transportation Coordinator"];
        [arrHotelService addObject:@"Valet Attendant"];
        [arrHotelService addObject:@"Valet Parker"];
        [arrHotelService addObject:@"Valet Parking Attendant"];
        [arrHotelService addObject:@"Wedding Coordinator"];
        [arrHotelService addObject:@"Wedding Sales Manager"];

    }
    else
    {
        [arrHotelService addObject:@"Adjoint(e) de direction"];
        [arrHotelService addObject:@"Attaché(e) commercial(e)"];
        [arrHotelService addObject:@"Bagagiste"];
        [arrHotelService addObject:@"Chasseur"];
        [arrHotelService addObject:@"Chef de maintenance"];
        [arrHotelService addObject:@"Chef de rang room service"];
        [arrHotelService addObject:@"Chef de réception"];
        [arrHotelService addObject:@"Concierge d'hôtel"];
        [arrHotelService addObject:@"Concierge de grand hôtel"];
        [arrHotelService addObject:@"Directeur commercial"];
        [arrHotelService addObject:@"Directeur d’hôtel"];
        [arrHotelService addObject:@"Directeur de l'hébergement"];
        [arrHotelService addObject:@"Employé(e) d’étage"];
        [arrHotelService addObject:@"Femme de chambre"];
        [arrHotelService addObject:@"Gouvernante"];
        [arrHotelService addObject:@"Gouvernante générale"];
        [arrHotelService addObject:@"Groom"];
        [arrHotelService addObject:@"Guest relation manager"];
        [arrHotelService addObject:@"Liftier"];
        [arrHotelService addObject:@"Lingère"];
        [arrHotelService addObject:@"Manager spécialisé dans le luxe"];
        [arrHotelService addObject:@"Night Auditor"];
        [arrHotelService addObject:@"Portier"];
        [arrHotelService addObject:@"Réceptionniste"];
        [arrHotelService addObject:@"Réceptionniste de nuit"];
        [arrHotelService addObject:@"Responsable room service"];
        [arrHotelService addObject:@"Spa manager"];
        [arrHotelService addObject:@"Technicien de maintenance"];
        [arrHotelService addObject:@"Valet de chambre"];
        [arrHotelService addObject:@"Veilleur de nuit"];
        [arrHotelService addObject:@"Voiturier"];
        
    }
    return arrHotelService;
}
+(NSMutableArray *)getCountryList
{
    NSMutableArray *arrCounty=[[NSMutableArray alloc]init];
    NSString *currentLang;
    currentLang = [[NSLocale preferredLanguages] objectAtIndex:0]; // code for get language code from device
    NSArray* foo = [currentLang componentsSeparatedByString: @"-"];
    currentLang = [foo objectAtIndex: 0];

    if (([currentLang isEqualToString:@"fr"]))
    {
    
    // COUNTRY LIST
        [arrCounty addObject:@"Afghanistan"];
        [arrCounty addObject:@"Afrique du Sud"];
        [arrCounty addObject:@"Albanie"];
        [arrCounty addObject:@"Algérie"];
        [arrCounty addObject:@"Allemagne"];
        [arrCounty addObject:@"Andorre"];
        [arrCounty addObject:@"Angola"];
        [arrCounty addObject:@"Anguilla"];
        [arrCounty addObject:@"Antarctique"];
        [arrCounty addObject:@"Arabie Saoudite"];
        [arrCounty addObject:@"Argentine"];
        [arrCounty addObject:@"Arménie"];
        [arrCounty addObject:@"Aruba"];
        [arrCounty addObject:@"Australie"];
        [arrCounty addObject:@"Autriche"];
        [arrCounty addObject:@"Azerbaïdjan"];
        [arrCounty addObject:@"Bahamas"];
        [arrCounty addObject:@"Bahreïn"];
        [arrCounty addObject:@"Bangladesh"];
        [arrCounty addObject:@"Barbade"];
        [arrCounty addObject:@"Belgique"];
        [arrCounty addObject:@"Belize"];
        [arrCounty addObject:@"Bénin"];
        [arrCounty addObject:@"Bermudes"];
        [arrCounty addObject:@"Bhoutan"];
        [arrCounty addObject:@"Biélorussie"];
        [arrCounty addObject:@"Bolivie"];
        [arrCounty addObject:@"Bosnie Herzégovine"];
        [arrCounty addObject:@"Botswana"];
        [arrCounty addObject:@"Brésil"];
        [arrCounty addObject:@"Brunei"];
        [arrCounty addObject:@"Bulgarie"];
        [arrCounty addObject:@"Burkina Faso"];
        [arrCounty addObject:@"Burundi"];
        [arrCounty addObject:@"Cambodge"];
        [arrCounty addObject:@"Cameroun"];
        [arrCounty addObject:@"Canada"];
        [arrCounty addObject:@"Cap-Vert"];
        [arrCounty addObject:@"Chili"];
        [arrCounty addObject:@"Chine"];
        [arrCounty addObject:@"Chypre"];
        [arrCounty addObject:@"Colombie"];
        [arrCounty addObject:@"Comores"];
        [arrCounty addObject:@"Corée du Nord"];
        [arrCounty addObject:@"Corée du Sud"];
        [arrCounty addObject:@"Costa Rica"];
        [arrCounty addObject:@"Côte d'Ivoire"];
        [arrCounty addObject:@"Croatie"];
        [arrCounty addObject:@"Cuba"];
        [arrCounty addObject:@"Curacao"];
        [arrCounty addObject:@"Danemark"];
        [arrCounty addObject:@"Djibouti"];
        [arrCounty addObject:@"Dominique"];
        [arrCounty addObject:@"Egypte"];
        [arrCounty addObject:@"Emirats Arabes Unis"];
        [arrCounty addObject:@"Équateur"];
        [arrCounty addObject:@"Érythrée"];
        [arrCounty addObject:@"Espagne"];
        [arrCounty addObject:@"Estonie"];
        [arrCounty addObject:@"États-Unis"];
        [arrCounty addObject:@"Ethiopie"];
        [arrCounty addObject:@"Fidji"];
        [arrCounty addObject:@"Finlande"];
        [arrCounty addObject:@"France"];
        [arrCounty addObject:@"Gabon"];
        [arrCounty addObject:@"Gambie"];
        [arrCounty addObject:@"Géorgie"];
        [arrCounty addObject:@"Ghana"];
        [arrCounty addObject:@"Gibraltar"];
        [arrCounty addObject:@"Grèce"];
        [arrCounty addObject:@"Groenland"];
        [arrCounty addObject:@"Guadeloupe"];
        [arrCounty addObject:@"Guam"];
        [arrCounty addObject:@"Guatemala"];
        [arrCounty addObject:@"Guinée"];
        [arrCounty addObject:@"Guinée Équatoriale"];
        [arrCounty addObject:@"Guinée-Bissau"];
        [arrCounty addObject:@"Guyane"];
        [arrCounty addObject:@"Haïti"];
        [arrCounty addObject:@"Honduras"];
        [arrCounty addObject:@"Hong Kong"];
        [arrCounty addObject:@"Hongrie"];
        [arrCounty addObject:@"Île de Man"];
        [arrCounty addObject:@"Île de Norfolk"];
        [arrCounty addObject:@"Îles Caïmans"];
        [arrCounty addObject:@"Îles Cook"];
        [arrCounty addObject:@"Îles Falkland"];
        [arrCounty addObject:@"Îles Féroé"];
        [arrCounty addObject:@"Îles Mariannes du Nord"];
        [arrCounty addObject:@"Îles Marshall"];
        [arrCounty addObject:@"Îles Pitcairn"];
        [arrCounty addObject:@"Îles Salomon"];
        [arrCounty addObject:@"Îles Vierges britanniques"];
        [arrCounty addObject:@"Inde"];
        [arrCounty addObject:@"Indonésie"];
        [arrCounty addObject:@"Irak"];
        [arrCounty addObject:@"Iran"];
        [arrCounty addObject:@"Irlande"];
        [arrCounty addObject:@"Islande"];
        [arrCounty addObject:@"Israël"];
        [arrCounty addObject:@"Italie"];
        [arrCounty addObject:@"Jamaïque"];
        [arrCounty addObject:@"Japon"];
        [arrCounty addObject:@"Jordan"];
        [arrCounty addObject:@"Kazakhstan"];
        [arrCounty addObject:@"Kenya"];
        [arrCounty addObject:@"Kirghizistan"];
        [arrCounty addObject:@"Kiribati"];
        [arrCounty addObject:@"Kosovo"];
        [arrCounty addObject:@"Koweit"];
        [arrCounty addObject:@"Laos"];
        [arrCounty addObject:@"Lesotho"];
        [arrCounty addObject:@"Lettonie"];
        [arrCounty addObject:@"Liban"];
        [arrCounty addObject:@"Libéria"];
        [arrCounty addObject:@"Libye"];
        [arrCounty addObject:@"Liechtenstein"];
        [arrCounty addObject:@"Lituanie"];
        [arrCounty addObject:@"Luxembourg"];
        [arrCounty addObject:@"Macao"];
        [arrCounty addObject:@"Macédoine"];
        [arrCounty addObject:@"Madagascar"];
        [arrCounty addObject:@"Malaisie"];
        [arrCounty addObject:@"Malawi"];
        [arrCounty addObject:@"Maldives"];
        [arrCounty addObject:@"Mali"];
        [arrCounty addObject:@"Malte"];
        [arrCounty addObject:@"Maroc"];
        [arrCounty addObject:@"Maurice"];
        [arrCounty addObject:@"Mauritanie"];
        [arrCounty addObject:@"Mexique"];
        [arrCounty addObject:@"Micronésie"];
        [arrCounty addObject:@"Moldavie"];
        [arrCounty addObject:@"Monaco"];
        [arrCounty addObject:@"Mongolie"];
        [arrCounty addObject:@"Monténégro"];
        [arrCounty addObject:@"Montserrat"];
        [arrCounty addObject:@"Mozambique"];
        [arrCounty addObject:@"Myanmar (Birmanie)"];
        [arrCounty addObject:@"Namibie"];
        [arrCounty addObject:@"Nauru"];
        [arrCounty addObject:@"Népal"];
        [arrCounty addObject:@"Nicaragua"];
        [arrCounty addObject:@"Niger"];
        [arrCounty addObject:@"Nigeria"];
        [arrCounty addObject:@"Niue"];
        [arrCounty addObject:@"Norvège"];
        [arrCounty addObject:@"Nouvelle Calédonie"];
        [arrCounty addObject:@"Nouvelle-Zélande"];
        [arrCounty addObject:@"Oman"];
        [arrCounty addObject:@"Ouganda"];
        [arrCounty addObject:@"Ouzbékistan"];
        [arrCounty addObject:@"Pakistan"];
        [arrCounty addObject:@"Palau"];
        [arrCounty addObject:@"Panama"];
        [arrCounty addObject:@"Papouasie Nouvelle Guinée"];
        [arrCounty addObject:@"Paraguay"];
        [arrCounty addObject:@"Pays-Bas"];
        [arrCounty addObject:@"Pérou"];
        [arrCounty addObject:@"Philippines"];
        [arrCounty addObject:@"Pologne"];
        [arrCounty addObject:@"Polynésie française"];
        [arrCounty addObject:@"Porto Rico"];
        
        [arrCounty addObject:@"Portugal"];
        [arrCounty addObject:@"Qatar"];
        
        [arrCounty addObject:@"République centrafricaine"];
        [arrCounty addObject:@"République Démocratique du Congo"];
        [arrCounty addObject:@"République Dominicaine"];
        [arrCounty addObject:@"République du Congo"];
        [arrCounty addObject:@"République Tchèque"];
        [arrCounty addObject:@"Réunion"];
        [arrCounty addObject:@"Roumanie"];
        [arrCounty addObject:@"Royaume-Uni"];
        [arrCounty addObject:@"Russie"];
        [arrCounty addObject:@"Rwanda"];
        [arrCounty addObject:@"Sahara occidental"];
        [arrCounty addObject:@"Saint Barthélemy"];
        [arrCounty addObject:@"Saint Marin"];
        [arrCounty addObject:@"Saint Martin"];
        [arrCounty addObject:@"Saint Pierre et Miquelon"];
        [arrCounty addObject:@"Saint-Christophe-et-Niévès"];
        [arrCounty addObject:@"Saint-Vincent-et-les-Grenadines"];
        [arrCounty addObject:@"Sainte-Hélène"];
        [arrCounty addObject:@"Sainte-Lucie"];
        [arrCounty addObject:@"Salvador"];
        [arrCounty addObject:@"Samoa"];
        [arrCounty addObject:@"Samoa américaines"];
        [arrCounty addObject:@"Sao Tomé-et-Principe"];
        [arrCounty addObject:@"Sénégal"];
        [arrCounty addObject:@"Serbie"];
        [arrCounty addObject:@"Seychelles"];
        [arrCounty addObject:@"Sierra Leone"];
        [arrCounty addObject:@"Singapour"];
        [arrCounty addObject:@"Slovaquie"];
        [arrCounty addObject:@"Slovénie"];
        [arrCounty addObject:@"Somalie"];
        [arrCounty addObject:@"Soudan"];
        [arrCounty addObject:@"Soudan du sud"];
        [arrCounty addObject:@"Sri Lanka"];
        [arrCounty addObject:@"Suède"];
        [arrCounty addObject:@"Suisse"];
        [arrCounty addObject:@"Suriname"];
        [arrCounty addObject:@"Swaziland"];
        [arrCounty addObject:@"Syrie"];
        [arrCounty addObject:@"Tadjikistan"];
        [arrCounty addObject:@"Taïwan"];
        [arrCounty addObject:@"Tanzanie"];
        [arrCounty addObject:@"Thaïlande"];
        [arrCounty addObject:@"Timor oriental"];
        [arrCounty addObject:@"Togo"];
        [arrCounty addObject:@"Tokelau"];
        [arrCounty addObject:@"Trinité-et-Tobago"];
        [arrCounty addObject:@"Tunisie"];
        [arrCounty addObject:@"Turkménistan"];
        [arrCounty addObject:@"Turquie"];
        [arrCounty addObject:@"Tuvalu"];
        [arrCounty addObject:@"Ukraine"];
        [arrCounty addObject:@"Uruguay"];
        [arrCounty addObject:@"Vanuatu"];
        [arrCounty addObject:@"Vatican"];
        [arrCounty addObject:@"Venezuela"];
        [arrCounty addObject:@"Vietnam"];
        [arrCounty addObject:@"Yémen"];
        [arrCounty addObject:@"Zambie"];
        [arrCounty addObject:@"Zimbabwe"];
    }
    else
    {
        
        [arrCounty addObject:@"Afghanistan"];
        [arrCounty addObject:@"Albania"];
        [arrCounty addObject:@"Algeria"];
        [arrCounty addObject:@"American Samoa"];
        [arrCounty addObject:@"Andorra"];
        [arrCounty addObject:@"Angola"];
        [arrCounty addObject:@"Anguilla"];
        [arrCounty addObject:@"Antarctica"];
        [arrCounty addObject:@"Argentina"];
        [arrCounty addObject:@"Armenia"];
        [arrCounty addObject:@"Aruba"];
        [arrCounty addObject:@"Australia"];
        [arrCounty addObject:@"Austria"];
        [arrCounty addObject:@"Azerbaijan"];
        [arrCounty addObject:@"Bahamas"];
        [arrCounty addObject:@"Bahrain"];
        [arrCounty addObject:@"Bangladesh"];
        [arrCounty addObject:@"Barbados"];
        [arrCounty addObject:@"Belarus"];
        [arrCounty addObject:@"Belgium"];
        [arrCounty addObject:@"Belize"];
        [arrCounty addObject:@"Benin"];
        [arrCounty addObject:@"Bermuda"];
        [arrCounty addObject:@"Bhutan"];
        [arrCounty addObject:@"Bolivia"];
        [arrCounty addObject:@"Bosnia and Herzegovina"];
        [arrCounty addObject:@"Botswana"];
        [arrCounty addObject:@"Brazil"];
        [arrCounty addObject:@"British Virgin Islands"];
        [arrCounty addObject:@"Brunei"];
        [arrCounty addObject:@"Bulgaria"];
        [arrCounty addObject:@"Burkina Faso"];
        [arrCounty addObject:@"Burundi"];
        [arrCounty addObject:@"Cambodia"];
        [arrCounty addObject:@"Cameroon"];
        [arrCounty addObject:@"Canada"];
        [arrCounty addObject:@"Cape Verde"];
        [arrCounty addObject:@"Cayman Islands"];
        [arrCounty addObject:@"Central African Republic"];
        [arrCounty addObject:@"Chile"];
        [arrCounty addObject:@"China"];
        [arrCounty addObject:@"Colombia"];
        [arrCounty addObject:@"Comoros"];
        [arrCounty addObject:@"Cook Islands"];
        [arrCounty addObject:@"Costa Rica"];
        [arrCounty addObject:@"Croatia"];
        [arrCounty addObject:@"Cuba"];
        [arrCounty addObject:@"Curacao"];
        [arrCounty addObject:@"Cyprus"];
        [arrCounty addObject:@"Czech Republic"];
        [arrCounty addObject:@"Democratic Republic of Congo"];
        [arrCounty addObject:@"Denmark"];
        [arrCounty addObject:@"Djibouti"];
        [arrCounty addObject:@"Dominica"];
        [arrCounty addObject:@"Dominican Republic"];
        [arrCounty addObject:@"East Timor"];
        [arrCounty addObject:@"Ecuador"];
        [arrCounty addObject:@"Egypt"];
        [arrCounty addObject:@"El Salvador"];
        [arrCounty addObject:@"Equatorial Guinea"];
        [arrCounty addObject:@"Eritrea"];
        [arrCounty addObject:@"Estonia"];
        [arrCounty addObject:@"Ethiopia"];
        [arrCounty addObject:@"Falkland Islands"];
        [arrCounty addObject:@"Faroe Islands"];
        [arrCounty addObject:@"Fiji"];
        [arrCounty addObject:@"Finland"];
        [arrCounty addObject:@"France"];
        [arrCounty addObject:@"French Polynesia"];
        [arrCounty addObject:@"Gabon"];
        [arrCounty addObject:@"Gambia"];
        [arrCounty addObject:@"Georgia"];
        [arrCounty addObject:@"Germany"];
        [arrCounty addObject:@"Ghana"];
        [arrCounty addObject:@"Gibraltar"];
        [arrCounty addObject:@"Greece"];
        [arrCounty addObject:@"Greenland"];
        [arrCounty addObject:@"Guadeloupe"];
        [arrCounty addObject:@"Guam"];
        [arrCounty addObject:@"Guatemala"];
        [arrCounty addObject:@"Guinea"];
        [arrCounty addObject:@"Guinea-Bissau"];
        [arrCounty addObject:@"Guyana"];
        [arrCounty addObject:@"Haiti"];
        [arrCounty addObject:@"Honduras"];
        [arrCounty addObject:@"Hong Kong"];
        [arrCounty addObject:@"Hungary"];
        [arrCounty addObject:@"Iceland"];
        [arrCounty addObject:@"India"];
        [arrCounty addObject:@"Indonesia"];
        [arrCounty addObject:@"Iran"];
        [arrCounty addObject:@"Iraq"];
        [arrCounty addObject:@"Ireland"];
        [arrCounty addObject:@"Isle of Man"];
        [arrCounty addObject:@"Israel"];
        [arrCounty addObject:@"Italy"];
        [arrCounty addObject:@"Ivory Coast"];
        [arrCounty addObject:@"Jamaica"];
        [arrCounty addObject:@"Japan"];
        [arrCounty addObject:@"Jordan"];
        [arrCounty addObject:@"Kazakhstan"];
        [arrCounty addObject:@"Kenya"];
        [arrCounty addObject:@"Kiribati"];
        [arrCounty addObject:@"Kosovo"];
        [arrCounty addObject:@"Kuwait"];
        [arrCounty addObject:@"Kyrgyzstan"];
        [arrCounty addObject:@"Laos"];
        [arrCounty addObject:@"Latvia"];
        [arrCounty addObject:@"Lebanon"];
        [arrCounty addObject:@"Lesotho"];
        [arrCounty addObject:@"Liberia"];
        [arrCounty addObject:@"Libya"];
        [arrCounty addObject:@"Liechtenstein"];
        [arrCounty addObject:@"Lithuania"];
        [arrCounty addObject:@"Luxembourg"];
        [arrCounty addObject:@"Macau"];
        [arrCounty addObject:@"Macedonia"];
        [arrCounty addObject:@"Madagascar"];
        [arrCounty addObject:@"Malawi"];
        [arrCounty addObject:@"Malaysia"];
        [arrCounty addObject:@"Maldives"];
        [arrCounty addObject:@"Mali"];
        [arrCounty addObject:@"Malta"];
        [arrCounty addObject:@"Marshall Islands"];
        [arrCounty addObject:@"Mauritania"];
        [arrCounty addObject:@"Mauritius"];
        [arrCounty addObject:@"Mexico"];
        [arrCounty addObject:@"Micronesia"];
        [arrCounty addObject:@"Moldova"];
        [arrCounty addObject:@"Monaco"];
        [arrCounty addObject:@"Mongolia"];
        [arrCounty addObject:@"Montenegro"];
        [arrCounty addObject:@"Montserrat"];
        [arrCounty addObject:@"Morocco"];
        [arrCounty addObject:@"Mozambique"];
        [arrCounty addObject:@"Myanmar (Burma)"];
        [arrCounty addObject:@"Namibia"];
        [arrCounty addObject:@"Nauru"];
        [arrCounty addObject:@"Nepal"];
        [arrCounty addObject:@"Netherlands"];
        [arrCounty addObject:@"New Caledonia"];
        [arrCounty addObject:@"New Zealand"];
        [arrCounty addObject:@"Nicaragua"];
        [arrCounty addObject:@"Niger"];
        [arrCounty addObject:@"Nigeria"];
        [arrCounty addObject:@"Niue"];
        [arrCounty addObject:@"Norfolk Island"];
        [arrCounty addObject:@"North Korea"];
        [arrCounty addObject:@"Northern Mariana Islands"];
        [arrCounty addObject:@"Norway"];
        [arrCounty addObject:@"Oman"];
        [arrCounty addObject:@"Pakistan"];
        [arrCounty addObject:@"Palau"];
        [arrCounty addObject:@"Panama"];
        [arrCounty addObject:@"Papua New Guinea"];
        [arrCounty addObject:@"Paraguay"];
        [arrCounty addObject:@"Peru"];
        [arrCounty addObject:@"Philippines"];
        [arrCounty addObject:@"Pitcairn Islands"];
        [arrCounty addObject:@"Poland"];
        [arrCounty addObject:@"Portugal"];
        [arrCounty addObject:@"Puerto Rico"];
        [arrCounty addObject:@"Qatar"];
        [arrCounty addObject:@"Republic of the Congo"];
        [arrCounty addObject:@"Reunion"];
        [arrCounty addObject:@"Romania"];
        [arrCounty addObject:@"Russia"];
        [arrCounty addObject:@"Rwanda"];
        [arrCounty addObject:@"Saint Barthélemy"];
        [arrCounty addObject:@"Saint Helena"];
        [arrCounty addObject:@"Saint Kitts and Nevis"];
        [arrCounty addObject:@"Saint Lucia"];
        [arrCounty addObject:@"Saint Martin"];
        [arrCounty addObject:@"Saint Pierre and Miquelon"];
        [arrCounty addObject:@"Saint Vincent and the Grenadines"];
        [arrCounty addObject:@"Samoa"];
        [arrCounty addObject:@"San Marino"];
        [arrCounty addObject:@"Sao Tome and Principe"];
        [arrCounty addObject:@"Saudi Arabia"];
        [arrCounty addObject:@"Senegal"];
        [arrCounty addObject:@"Serbia"];
        [arrCounty addObject:@"Seychelles"];
        [arrCounty addObject:@"Sierra Leone"];
        [arrCounty addObject:@"Singapore"];
        [arrCounty addObject:@"Slovakia"];
        [arrCounty addObject:@"Slovenia"];
        [arrCounty addObject:@"Solomon Islands"];
        [arrCounty addObject:@"Somalia"];
        [arrCounty addObject:@"South Africa"];
        [arrCounty addObject:@"South Korea"];
        [arrCounty addObject:@"South Sudan"];
        [arrCounty addObject:@"Spain"];
        [arrCounty addObject:@"Sri Lanka"];
        [arrCounty addObject:@"Sudan"];
        [arrCounty addObject:@"Suriname"];
        [arrCounty addObject:@"Swaziland"];
        [arrCounty addObject:@"Sweden"];
        [arrCounty addObject:@"Switzerland"];
        [arrCounty addObject:@"Syria"];
        [arrCounty addObject:@"Taiwan"];
        [arrCounty addObject:@"Tajikistan"];
        [arrCounty addObject:@"Tanzania"];
        [arrCounty addObject:@"Thailand"];
        [arrCounty addObject:@"Togo"];
        [arrCounty addObject:@"Tokelau"];
        [arrCounty addObject:@"Trinidad and Tobago"];
        [arrCounty addObject:@"Tunisia"];
        [arrCounty addObject:@"Turkey"];
        [arrCounty addObject:@"Turkmenistan"];
        [arrCounty addObject:@"Tuvalu"];
        [arrCounty addObject:@"Uganda"];
        [arrCounty addObject:@"Ukraine"];
        [arrCounty addObject:@"United Arab Emirates"];
        [arrCounty addObject:@"United Kingdom"];
        [arrCounty addObject:@"United States"];
        [arrCounty addObject:@"Uruguay"];
        [arrCounty addObject:@"Uzbekistan"];
        [arrCounty addObject:@"Vanuatu"];
        [arrCounty addObject:@"Vatican"];
        [arrCounty addObject:@"Venezuela"];
        [arrCounty addObject:@"Vietnam"];
        [arrCounty addObject:@"Western Sahara"];
        [arrCounty addObject:@"Yemen"];
        [arrCounty addObject:@"Zambia"];
        [arrCounty addObject:@"Zimbabwe"];

    }
    return arrCounty;
}

+(NSMutableArray *)getCountryCode
{
    NSMutableArray *arrCountryCode=[[NSMutableArray alloc]init];
    NSString *currentLang;
    currentLang = [[NSLocale preferredLanguages] objectAtIndex:0]; // code for get language code from device
    NSArray* foo = [currentLang componentsSeparatedByString: @"-"];
    currentLang = [foo objectAtIndex: 0];
    
    if (([currentLang isEqualToString:@"fr"]))
    {
        
        [arrCountryCode addObject:@"+93"];
        [arrCountryCode addObject:@"+27"];
        [arrCountryCode addObject:@"+355"];
        [arrCountryCode addObject:@"+213"];
        [arrCountryCode addObject:@"+49"];
        [arrCountryCode addObject:@"+376"];
        [arrCountryCode addObject:@"+244"];
        [arrCountryCode addObject:@"+1,264"];
        [arrCountryCode addObject:@"+672"];
        [arrCountryCode addObject:@"+966"];
        [arrCountryCode addObject:@"+54"];
        [arrCountryCode addObject:@"+374"];
        [arrCountryCode addObject:@"+297"];
        [arrCountryCode addObject:@"+61"];
        [arrCountryCode addObject:@"+43"];
        [arrCountryCode addObject:@"+994"];
        [arrCountryCode addObject:@"+1"];
        [arrCountryCode addObject:@"+973"];
        [arrCountryCode addObject:@"+880"];
        [arrCountryCode addObject:@"+1"];
        [arrCountryCode addObject:@"+32"];
        [arrCountryCode addObject:@"+501"];
        [arrCountryCode addObject:@"+229"];
        [arrCountryCode addObject:@"+1"];
        [arrCountryCode addObject:@"+975"];
        [arrCountryCode addObject:@"+375"];
        [arrCountryCode addObject:@"+591"];
        [arrCountryCode addObject:@"+387"];
        [arrCountryCode addObject:@"+267"];
        [arrCountryCode addObject:@"+55"];
        [arrCountryCode addObject:@"+673"];
        [arrCountryCode addObject:@"+359"];
        [arrCountryCode addObject:@"+226"];
        [arrCountryCode addObject:@"+257"];
        [arrCountryCode addObject:@"+855"];
        [arrCountryCode addObject:@"+237"];
        [arrCountryCode addObject:@"+1"];
        [arrCountryCode addObject:@"+238"];
        [arrCountryCode addObject:@"+56"];
        [arrCountryCode addObject:@"+86"];
        [arrCountryCode addObject:@"+357"];
        [arrCountryCode addObject:@"+57"];
        [arrCountryCode addObject:@"+269"];
        [arrCountryCode addObject:@"+850"];
        [arrCountryCode addObject:@"+82"];
        [arrCountryCode addObject:@"+506"];
        [arrCountryCode addObject:@"+225"];
        [arrCountryCode addObject:@"+385"];
        [arrCountryCode addObject:@"+53"];
        [arrCountryCode addObject:@"+599"];
        [arrCountryCode addObject:@"+45"];
        [arrCountryCode addObject:@"+253"];
        [arrCountryCode addObject:@"+1"];
        [arrCountryCode addObject:@"+20"];
        [arrCountryCode addObject:@"+971"];
        [arrCountryCode addObject:@"+593"];
        [arrCountryCode addObject:@"+291"];
        [arrCountryCode addObject:@"+34"];
        [arrCountryCode addObject:@"+372"];
        [arrCountryCode addObject:@"+1"];
        [arrCountryCode addObject:@"+251"];
        [arrCountryCode addObject:@"+679"];
        [arrCountryCode addObject:@"+358"];
        [arrCountryCode addObject:@"+33"];
        [arrCountryCode addObject:@"+241"];
        [arrCountryCode addObject:@"+220"];
        [arrCountryCode addObject:@"+995"];
        [arrCountryCode addObject:@"+233"];
        [arrCountryCode addObject:@"+350"];
        [arrCountryCode addObject:@"+30"];
        [arrCountryCode addObject:@"+299"];
        [arrCountryCode addObject:@"+590"];
        [arrCountryCode addObject:@"+1,671"];
        [arrCountryCode addObject:@"+502"];
        [arrCountryCode addObject:@"+224"];
        [arrCountryCode addObject:@"+240"];
        [arrCountryCode addObject:@"+245"];
        [arrCountryCode addObject:@"+592"];
        [arrCountryCode addObject:@"+509"];
        [arrCountryCode addObject:@"+504"];
        [arrCountryCode addObject:@"+852"];
        [arrCountryCode addObject:@"+36"];
        [arrCountryCode addObject:@"+44"];
        [arrCountryCode addObject:@"+672"];
        [arrCountryCode addObject:@"+1,345"];
        [arrCountryCode addObject:@"+682"];
        [arrCountryCode addObject:@"+500"];
        [arrCountryCode addObject:@"+298"];
        [arrCountryCode addObject:@"+1,670"];
        [arrCountryCode addObject:@"+692"];
        [arrCountryCode addObject:@"+870"];
        [arrCountryCode addObject:@"+677"];
        [arrCountryCode addObject:@"+1,284"];
        [arrCountryCode addObject:@"+91"];
        [arrCountryCode addObject:@"+62"];
        [arrCountryCode addObject:@"+964"];
        [arrCountryCode addObject:@"+98"];
        [arrCountryCode addObject:@"+353"];
        [arrCountryCode addObject:@"+354"];
        [arrCountryCode addObject:@"+972"];
        [arrCountryCode addObject:@"+39"];
        [arrCountryCode addObject:@"+1"];
        [arrCountryCode addObject:@"+81"];
        [arrCountryCode addObject:@"+962"];
        [arrCountryCode addObject:@"+7"];
        [arrCountryCode addObject:@"+254"];
        [arrCountryCode addObject:@"+996"];
        [arrCountryCode addObject:@"+686"];
        [arrCountryCode addObject:@"+381"];
        [arrCountryCode addObject:@"+965"];
        [arrCountryCode addObject:@"+856"];
        [arrCountryCode addObject:@"+266"];
        [arrCountryCode addObject:@"+371"];
        [arrCountryCode addObject:@"+961"];
        [arrCountryCode addObject:@"+231"];
        [arrCountryCode addObject:@"+218"];
        [arrCountryCode addObject:@"+423"];
        [arrCountryCode addObject:@"+370"];
        [arrCountryCode addObject:@"+352"];
        [arrCountryCode addObject:@"+853"];
        [arrCountryCode addObject:@"+389"];
        [arrCountryCode addObject:@"+261"];
        [arrCountryCode addObject:@"+60"];
        [arrCountryCode addObject:@"+265"];
        [arrCountryCode addObject:@"+960"];
        [arrCountryCode addObject:@"+223"];
        [arrCountryCode addObject:@"+356"];
        [arrCountryCode addObject:@"+212"];
        [arrCountryCode addObject:@"+230"];
        [arrCountryCode addObject:@"+222"];
        [arrCountryCode addObject:@"+52"];
        [arrCountryCode addObject:@"+691"];
        [arrCountryCode addObject:@"+373"];
        [arrCountryCode addObject:@"+377"];
        [arrCountryCode addObject:@"+976"];
        [arrCountryCode addObject:@"+382"];
        [arrCountryCode addObject:@"+1,664"];
        [arrCountryCode addObject:@"+258"];
        [arrCountryCode addObject:@"+95"];
        [arrCountryCode addObject:@"+264"];
        [arrCountryCode addObject:@"+674"];
        [arrCountryCode addObject:@"+977"];
        [arrCountryCode addObject:@"+505"];
        [arrCountryCode addObject:@"+227"];
        [arrCountryCode addObject:@"+234"];
        [arrCountryCode addObject:@"+683"];
        [arrCountryCode addObject:@"+47"];
        [arrCountryCode addObject:@"+687"];
        [arrCountryCode addObject:@"+64"];
        [arrCountryCode addObject:@"+968"];
        [arrCountryCode addObject:@"+256"];
        [arrCountryCode addObject:@"+998"];
        [arrCountryCode addObject:@"+92"];
        [arrCountryCode addObject:@"+680"];
        [arrCountryCode addObject:@"+507"];
        [arrCountryCode addObject:@"+675"];
        [arrCountryCode addObject:@"+595"];
        [arrCountryCode addObject:@"+31"];
        [arrCountryCode addObject:@"+51"];
        [arrCountryCode addObject:@"+63"];
        [arrCountryCode addObject:@"+48"];
        [arrCountryCode addObject:@"+689"];
        [arrCountryCode addObject:@"+1"];
        [arrCountryCode addObject:@"+351"];
        [arrCountryCode addObject:@"+974"];
        [arrCountryCode addObject:@"+236"];
        [arrCountryCode addObject:@"+243"];
        [arrCountryCode addObject:@"+1"];
        [arrCountryCode addObject:@"+242"];
        [arrCountryCode addObject:@"+420"];
        [arrCountryCode addObject:@"+262"];
        [arrCountryCode addObject:@"+40"];
        [arrCountryCode addObject:@"+44"];
        [arrCountryCode addObject:@"+7"];
        [arrCountryCode addObject:@"+250"];
        [arrCountryCode addObject:@"+212"];
        [arrCountryCode addObject:@"+590"];
        [arrCountryCode addObject:@"+378"];
        [arrCountryCode addObject:@"+1599"];
        [arrCountryCode addObject:@"+508"];
        [arrCountryCode addObject:@"+1"];
        [arrCountryCode addObject:@"+1"];
        [arrCountryCode addObject:@"+290"];
        [arrCountryCode addObject:@"+1"];
        [arrCountryCode addObject:@"+503"];
        [arrCountryCode addObject:@"+685"];
        [arrCountryCode addObject:@"+1684"];
        [arrCountryCode addObject:@"+239"];
        [arrCountryCode addObject:@"+221"];
        [arrCountryCode addObject:@"+381"];
        [arrCountryCode addObject:@"+248"];
        [arrCountryCode addObject:@"+232"];
        [arrCountryCode addObject:@"+65"];
        [arrCountryCode addObject:@"+421"];
        [arrCountryCode addObject:@"+386"];
        [arrCountryCode addObject:@"+252"];
        [arrCountryCode addObject:@"+249"];
        [arrCountryCode addObject:@"+211"];
        [arrCountryCode addObject:@"+94"];
        [arrCountryCode addObject:@"+46"];
        [arrCountryCode addObject:@"+41"];
        [arrCountryCode addObject:@"+597"];
        [arrCountryCode addObject:@"+268"];
        [arrCountryCode addObject:@"+963"];
        [arrCountryCode addObject:@"+992"];
        [arrCountryCode addObject:@"+886"];
        [arrCountryCode addObject:@"+255"];
        [arrCountryCode addObject:@"+66"];
        [arrCountryCode addObject:@"+670"];
        [arrCountryCode addObject:@"+228"];
        [arrCountryCode addObject:@"+690"];
        [arrCountryCode addObject:@"+1"];
        [arrCountryCode addObject:@"+216"];
        [arrCountryCode addObject:@"+993"];
        [arrCountryCode addObject:@"+90"];
        [arrCountryCode addObject:@"+688"];
        [arrCountryCode addObject:@"+380"];
        [arrCountryCode addObject:@"+598"];
        [arrCountryCode addObject:@"+678"];
        [arrCountryCode addObject:@"+39"];
        [arrCountryCode addObject:@"+58"];
        [arrCountryCode addObject:@"+84"];
        [arrCountryCode addObject:@"+967"];
        [arrCountryCode addObject:@"+260"];
        [arrCountryCode addObject:@"+263"];
        
    }
    else
    {

        
        //-------
        [arrCountryCode addObject:@"+93"];
        [arrCountryCode addObject:@"+355"];
        [arrCountryCode addObject:@"+213"];
        [arrCountryCode addObject:@"+1,684"];
        [arrCountryCode addObject:@"+376"];
        [arrCountryCode addObject:@"+244"];
        [arrCountryCode addObject:@"+1264"];
        [arrCountryCode addObject:@"+672"];
        [arrCountryCode addObject:@"+54"];
        [arrCountryCode addObject:@"+374"];
        [arrCountryCode addObject:@"+297"];
        [arrCountryCode addObject:@"+61"];
        [arrCountryCode addObject:@"+43"];
        [arrCountryCode addObject:@"+994"];
        [arrCountryCode addObject:@"+1"];
        [arrCountryCode addObject:@"+973"];
        [arrCountryCode addObject:@"+880"];
        [arrCountryCode addObject:@"+1"];
        [arrCountryCode addObject:@"+375"];
        [arrCountryCode addObject:@"+32"];
        [arrCountryCode addObject:@"+501"];
        [arrCountryCode addObject:@"+229"];
        [arrCountryCode addObject:@"+1"];
        [arrCountryCode addObject:@"+975"];
        [arrCountryCode addObject:@"+591"];
        [arrCountryCode addObject:@"+387"];
        [arrCountryCode addObject:@"+267"];
        [arrCountryCode addObject:@"+55"];
        [arrCountryCode addObject:@"+1,284"];
        [arrCountryCode addObject:@"+673"];
        [arrCountryCode addObject:@"+359"];
        [arrCountryCode addObject:@"+226"];
        [arrCountryCode addObject:@"+257"];
        [arrCountryCode addObject:@"+855"];
        [arrCountryCode addObject:@"+237"];
        [arrCountryCode addObject:@"+1"];
        [arrCountryCode addObject:@"+238"];
        [arrCountryCode addObject:@"+1,345"];
        [arrCountryCode addObject:@"+236"];
        [arrCountryCode addObject:@"+56"];
        [arrCountryCode addObject:@"+86"];
        [arrCountryCode addObject:@"+57"];
        [arrCountryCode addObject:@"+269"];
        [arrCountryCode addObject:@"+682"];
        [arrCountryCode addObject:@"+506"];
        [arrCountryCode addObject:@"+385"];
        [arrCountryCode addObject:@"+53"];
        [arrCountryCode addObject:@"+599"];
        [arrCountryCode addObject:@"+357"];
        [arrCountryCode addObject:@"+420"];
        [arrCountryCode addObject:@"+243"];
        [arrCountryCode addObject:@"+45"];
        [arrCountryCode addObject:@"+253"];
        [arrCountryCode addObject:@"+1"];
        [arrCountryCode addObject:@"+1"];
        [arrCountryCode addObject:@"+670"];
        [arrCountryCode addObject:@"+593"];
        [arrCountryCode addObject:@"+20"];
        [arrCountryCode addObject:@"+503"];
        [arrCountryCode addObject:@"+240"];
        [arrCountryCode addObject:@"+291"];
        [arrCountryCode addObject:@"+372"];
        [arrCountryCode addObject:@"+251"];
        [arrCountryCode addObject:@"+500"];
        [arrCountryCode addObject:@"+298"];
        [arrCountryCode addObject:@"+679"];
        [arrCountryCode addObject:@"+358"];
        [arrCountryCode addObject:@"+33"];
        [arrCountryCode addObject:@"+689"];
        [arrCountryCode addObject:@"+241"];
        [arrCountryCode addObject:@"+220"];
        [arrCountryCode addObject:@"+995"];
        [arrCountryCode addObject:@"+49"];
        [arrCountryCode addObject:@"+233"];
        [arrCountryCode addObject:@"+350"];
        [arrCountryCode addObject:@"+30"];
        [arrCountryCode addObject:@"+299"];
        [arrCountryCode addObject:@"+590"];
        [arrCountryCode addObject:@"+1,671"];
        [arrCountryCode addObject:@"+502"];
        [arrCountryCode addObject:@"+224"];
        [arrCountryCode addObject:@"+245"];
        [arrCountryCode addObject:@"+592"];
        [arrCountryCode addObject:@"+509"];
        [arrCountryCode addObject:@"+504"];
        [arrCountryCode addObject:@"+852"];
        [arrCountryCode addObject:@"+36"];
        [arrCountryCode addObject:@"+354"];
        [arrCountryCode addObject:@"+91"];
        [arrCountryCode addObject:@"+62"];
        [arrCountryCode addObject:@"+98"];
        [arrCountryCode addObject:@"+964"];
        [arrCountryCode addObject:@"+353"];
        [arrCountryCode addObject:@"+44"];
        [arrCountryCode addObject:@"+972"];
        [arrCountryCode addObject:@"+39"];
        [arrCountryCode addObject:@"+225"];
        [arrCountryCode addObject:@"+1"];
        [arrCountryCode addObject:@"+81"];
        [arrCountryCode addObject:@"+962"];
        [arrCountryCode addObject:@"+7"];
        [arrCountryCode addObject:@"+254"];
        [arrCountryCode addObject:@"+686"];
        [arrCountryCode addObject:@"+381"];
        [arrCountryCode addObject:@"+965"];
        [arrCountryCode addObject:@"+996"];
        [arrCountryCode addObject:@"+856"];
        [arrCountryCode addObject:@"+371"];
        [arrCountryCode addObject:@"+961"];
        [arrCountryCode addObject:@"+266"];
        [arrCountryCode addObject:@"+231"];
        [arrCountryCode addObject:@"+218"];
        [arrCountryCode addObject:@"+423"];
        [arrCountryCode addObject:@"+370"];
        [arrCountryCode addObject:@"+352"];
        [arrCountryCode addObject:@"+853"];
        [arrCountryCode addObject:@"+389"];
        [arrCountryCode addObject:@"+261"];
        [arrCountryCode addObject:@"+265"];
        [arrCountryCode addObject:@"+60"];
        [arrCountryCode addObject:@"+960"];
        [arrCountryCode addObject:@"+223"];
        [arrCountryCode addObject:@"+356"];
        [arrCountryCode addObject:@"+692"];
        [arrCountryCode addObject:@"+222"];
        [arrCountryCode addObject:@"+230"];
        [arrCountryCode addObject:@"+52"];
        [arrCountryCode addObject:@"+691"];
        [arrCountryCode addObject:@"+373"];
        [arrCountryCode addObject:@"+377"];
        [arrCountryCode addObject:@"+976"];
        [arrCountryCode addObject:@"+382"];
        [arrCountryCode addObject:@"+1,664"];
        [arrCountryCode addObject:@"+212"];
        [arrCountryCode addObject:@"+258"];
        [arrCountryCode addObject:@"+95"];
        [arrCountryCode addObject:@"+264"];
        [arrCountryCode addObject:@"+674"];
        [arrCountryCode addObject:@"+977"];
        [arrCountryCode addObject:@"+31"];
        [arrCountryCode addObject:@"+687"];
        [arrCountryCode addObject:@"+64"];
        [arrCountryCode addObject:@"+64"];
        [arrCountryCode addObject:@"+505"];
        [arrCountryCode addObject:@"+227"];
        [arrCountryCode addObject:@"+234"];
        [arrCountryCode addObject:@"+683"];
        [arrCountryCode addObject:@"+672"];
        [arrCountryCode addObject:@"+850"];
        [arrCountryCode addObject:@"+1,670"];
        [arrCountryCode addObject:@"+47"];
        [arrCountryCode addObject:@"+968"];
        [arrCountryCode addObject:@"+92"];
        [arrCountryCode addObject:@"+680"];
        [arrCountryCode addObject:@"+507"];
        [arrCountryCode addObject:@"+675"];
        [arrCountryCode addObject:@"+595"];
        [arrCountryCode addObject:@"+51"];
        [arrCountryCode addObject:@"+63"];
        [arrCountryCode addObject:@"+870"];
        [arrCountryCode addObject:@"+48"];
        [arrCountryCode addObject:@"+351"];
        [arrCountryCode addObject:@"+1"];
        [arrCountryCode addObject:@"+974"];
        [arrCountryCode addObject:@"+242"];
        [arrCountryCode addObject:@"+262"];
        [arrCountryCode addObject:@"+40"];
        [arrCountryCode addObject:@"+7"];
        [arrCountryCode addObject:@"+250"];
        [arrCountryCode addObject:@"+590"];
        [arrCountryCode addObject:@"+290"];
        [arrCountryCode addObject:@"+1"];
        [arrCountryCode addObject:@"+1"];
        [arrCountryCode addObject:@"+1,599"];
        [arrCountryCode addObject:@"+508"];
        [arrCountryCode addObject:@"+1"];
        [arrCountryCode addObject:@"+685"];
        [arrCountryCode addObject:@"+378"];
        [arrCountryCode addObject:@"+239"];
        [arrCountryCode addObject:@"+966"];
        [arrCountryCode addObject:@"+221"];
        [arrCountryCode addObject:@"+381"];
        [arrCountryCode addObject:@"+248"];
        [arrCountryCode addObject:@"+232"];
        [arrCountryCode addObject:@"+65"];
        [arrCountryCode addObject:@"+421"];
        [arrCountryCode addObject:@"+386"];
        [arrCountryCode addObject:@"+677"];
        [arrCountryCode addObject:@"+252"];
        [arrCountryCode addObject:@"+27"];
        [arrCountryCode addObject:@"+82"];
        [arrCountryCode addObject:@"+211"];
        [arrCountryCode addObject:@"+34"];
        [arrCountryCode addObject:@"+94"];
        [arrCountryCode addObject:@"+249"];
        [arrCountryCode addObject:@"+597"];
        [arrCountryCode addObject:@"+268"];
        [arrCountryCode addObject:@"+46"];
        [arrCountryCode addObject:@"+41"];
        [arrCountryCode addObject:@"+963"];
        [arrCountryCode addObject:@"+886"];
        [arrCountryCode addObject:@"+992"];
        [arrCountryCode addObject:@"+255"];
        [arrCountryCode addObject:@"+66"];
        [arrCountryCode addObject:@"+228"];
        [arrCountryCode addObject:@"+690"];
        [arrCountryCode addObject:@"+1"];
        [arrCountryCode addObject:@"+216"];
        [arrCountryCode addObject:@"+90"];
        [arrCountryCode addObject:@"+993"];
        [arrCountryCode addObject:@"+688"];
        [arrCountryCode addObject:@"+256"];
        [arrCountryCode addObject:@"+380"];
        [arrCountryCode addObject:@"+971"];
        [arrCountryCode addObject:@"+44"];
        [arrCountryCode addObject:@"+1"];
        [arrCountryCode addObject:@"+598"];
        [arrCountryCode addObject:@"+998"];
        [arrCountryCode addObject:@"+678"];
        [arrCountryCode addObject:@"+39"];
        [arrCountryCode addObject:@"+58"];
        [arrCountryCode addObject:@"+84"];
        [arrCountryCode addObject:@"+212"];
        [arrCountryCode addObject:@"+967"];
        [arrCountryCode addObject:@"+260"];
        [arrCountryCode addObject:@"+263"];
        
    }
    return arrCountryCode;
}

+(void)setLabelOnTableviewBackground :(UITableView*) tblView title:(NSString*)str
{
    UILabel * noDataLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, tblView.bounds.size.width, tblView.bounds.size.height)];
    noDataLabel.text = str;
    noDataLabel.numberOfLines = 0;
    noDataLabel.lineBreakMode = NSLineBreakByWordWrapping;
    noDataLabel.textColor     = [UIColor colorWithRed:(235.0/255.0f) green:85.0/255.0 blue:119.0/255.0 alpha:1.0];
    noDataLabel.textAlignment = NSTextAlignmentCenter;
    noDataLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:30.0];
    [noDataLabel sizeToFit];
    tblView.backgroundView  = noDataLabel;
    tblView.separatorStyle = UITableViewCellSelectionStyleNone;
    
}


@end
