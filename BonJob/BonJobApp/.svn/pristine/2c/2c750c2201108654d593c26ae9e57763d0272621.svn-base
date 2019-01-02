//
//  SelectLocationViewController.h
//  BONJOB
//
//  Created by VISHAL-SETH on 6/5/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol locationSelectedDelegate<NSObject>

-(void)locationSelected:(NSString *)address withLat:(float)lattitute andLong:(float)Longitute;

@end




@interface SelectLocationViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIView *viewSearchLocation;
@property (weak, nonatomic) IBOutlet UITextField *txtSearchLocation;
- (IBAction)btnRegisterAction:(id)sender;
@property(nonatomic,strong)id<locationSelectedDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSaveLocation;

@end
