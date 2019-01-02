//
//  SelectLocationViewController.m
//  BONJOB
//
//  Created by VISHAL-SETH on 6/5/17.
//  Copyright © 2017 Infoicon Technologies. All rights reserved.
//

#import "SelectLocationViewController.h"
#import "SPGooglePlacesAutocompletePlace.h"
#import "SPGooglePlacesAutocompleteQuery.h"
#import "SPGooglePlacesPlaceDetailQuery.h"

@interface SelectLocationViewController ()
{
    CLLocationManager *locationManager;
    CLLocation *currLocation;
    UITableView *TblAutocomplete;
    NSArray *arrAutoCompleteData;
    NSString *address;
    MKPointAnnotation *selectedPlaceAnnotation;
    double latitude , longitude;
}
@end

@implementation SelectLocationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.navigationController.navigationBar.tintColor = InternalButtonColor;
    [self setupInitialView];
    self.mapView.delegate = self;
    [self.mapView showsCompass];
    self.mapView.showsUserLocation=YES;
    self.txtSearchLocation.delegate=self;
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
    self.title=[SharedClass capitalizeFirstLetterOnlyOfString:NSLocalizedString(@"LOCATION", @"")]; //NSLocalizedString(@"LOCATION", @"");
    [_btnSaveLocation setTitle:NSLocalizedString(@"Save", @"")];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
        // Do any additional setup after loading the view.
}
    
    
    

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)increaseHeightWithAnimation:(BOOL)Increase
{
    if (Increase)
    {
        [UIView animateWithDuration:0.4
                              delay:0
                            options:UIViewAnimationCurveEaseInOut
                         animations:^ {
                             //NSLog(@"yourview : %@",customView);
                             
                             TblAutocomplete.frame = CGRectMake(_viewSearchLocation.frame.origin.x, _viewSearchLocation.frame.origin.y +_viewSearchLocation.frame.size.height, _viewSearchLocation.frame.size.width, [arrAutoCompleteData count]*40);
                             //NSLog(@"yourview : %@",customView);
                             
                         }completion:^(BOOL finished)
         {
             
         }];
    }
    else
    {
        [UIView animateWithDuration:0.4
                              delay:0
                            options:UIViewAnimationCurveEaseInOut
                         animations:^ {
                             //NSLog(@"yourview : %@",customView);
                             
                             TblAutocomplete.frame = CGRectMake(_viewSearchLocation.frame.origin.x, _viewSearchLocation.frame.origin.y +_viewSearchLocation.frame.size.height, _viewSearchLocation.frame.size.width,0);
                             //NSLog(@"yourview : %@",customView);
                             
                         }completion:^(BOOL finished)
         {
             
         }];
    }
    
}

-(void)setupInitialView
{
    _viewSearchLocation.layer.cornerRadius=25;
    _viewSearchLocation.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _viewSearchLocation.layer.borderWidth=1.0;
    
    TblAutocomplete = [[UITableView alloc] initWithFrame:
                             CGRectMake(_viewSearchLocation.frame.origin.x, _viewSearchLocation.frame.origin.y+_viewSearchLocation.frame.size.height, _viewSearchLocation.frame.size.width, 0) style:UITableViewStylePlain];
    TblAutocomplete.layer.borderColor=[UIColor lightGrayColor].CGColor;
    TblAutocomplete.layer.cornerRadius=10.0;
    TblAutocomplete.layer.borderWidth=1.0;
    TblAutocomplete.delegate = self;
    TblAutocomplete.dataSource = self;
    TblAutocomplete.scrollEnabled = YES;
    //TblAutocomplete.hidden = YES;
    [self.view addSubview:TblAutocomplete];
}
    
#pragma mark - -----Textfield Delegates--------
- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    //TblAutocomplete.hidden = NO;
    [self increaseHeightWithAnimation:YES];
    
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring
                 stringByReplacingCharactersInRange:range withString:string];
    [self searchAutocompleteEntriesWithSubstring:substring];
    return YES;
}
    
- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {
    
    // Put anything that starts with this substring into the autocompleteUrls array
    // The items in this array is what will show up in the table view
    
//    for(NSString *curString in pastUrls)
//    {
//        NSRange substringRange = [curString rangeOfString:substring];
//        if (substringRange.location == 0) {
//            [arrAutoCompleteData addObject:curString];
//        }
//    }
    
    
    SPGooglePlacesAutocompleteQuery *query; 
    if (!query)
    {
        query= [SPGooglePlacesAutocompleteQuery query];
    }
    query.input = substring;
   // query.radius = 100.0;
    query.language = @"fr";
    query.types = SPPlaceTypeGeocode; // Only return geocoding (address) results.
    query.location = CLLocationCoordinate2DMake(currLocation.coordinate.latitude,currLocation.coordinate.longitude);
    latitude = currLocation.coordinate.latitude;
    longitude = currLocation.coordinate.longitude;
    
    [query fetchPlaces:^(NSArray *places, NSError *error)
     {
        // SPGooglePlacesAutocompletePlace *place = [places firstObject];
         if (places)
         {
            
//             [place resolveToPlacemark:^(CLPlacemark *placemark, NSString *addressString, NSError *error)
//              {
//                  NSLog(@"Placemark: %@", placemark.locality);
//              }];
             arrAutoCompleteData=places;
            
             [TblAutocomplete reloadData];
         }
     }];

    
    
}

#pragma mark - -------CLLocation Manager Delegate-------
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    currLocation=newLocation;
    NSLog(@"OldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    latitude = newLocation.coordinate.latitude;
    longitude = newLocation.coordinate.longitude;
    [locationManager stopUpdatingLocation];
    
    
         CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
        [geoCoder reverseGeocodeLocation:currLocation completionHandler:^(NSArray *placemarks, NSError *error){
            CLPlacemark *placemark = placemarks[0];
            NSLog(@"Found %@", placemark.postalCode);
            if (!error)
            {
                
                //    [self addPlacemarkAnnotationToMap:placemark addressString:addressString];
                //address = addressString;
                NSString *strPlace;
                if(placemark.postalCode  == nil)
                {
                    strPlace=[NSString stringWithFormat:@"%@",placemark.locality];
                }
                else{
                    strPlace=[NSString stringWithFormat:@"%@, %@",placemark.locality,placemark.postalCode];
                }
               // strPlace = @"Maubege, 59600";
              //  CLLocation *loc =[[CLLocation alloc]initWithLatitude:50.278990 longitude:3.969226];
                address=strPlace;//[NSString stringWithFormat:@"%@",placemark.locality];
                _txtSearchLocation.text = address;
                [self addAnnotationonMap:placemark.location currentAddress:address subTitle:@""];
              //  [self addAnnotationonMap:loc currentAddress:address subTitle:@""];
                [self increaseHeightWithAnimation:NO];
            }
        }];


//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//
//
//
//    [geocoder reverseGeocodeLocation:newLocation
//                   completionHandler:^(NSArray *placemarks, NSError *error) {
//
//                       if (error) {
//                           NSLog(@"Geocode failed with error: %@", error);
//                           return;
//                       }
//
//                       if (placemarks && placemarks.count > 0)
//                       {
//                           CLPlacemark *placemark = placemarks[0];
//
//                           //address = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
//                         latitude = placemark.location.coordinate.latitude;
//                         longitude = placemark.location.coordinate.longitude;
//                           //address=placemark.locality;
//                           NSArray *lines = placemark.addressDictionary[ @"FormattedAddressLines"];
//                           NSString *addressString = [lines componentsJoinedByString:@"\n"];
//                           address = addressString;
//                         //  address=[NSString stringWithFormat:@"%@",placemark.locality];
//                         //  self.txtSearchLocation.text=address;
//                           self.txtSearchLocation.text = addressString;
//                           self.mapView.delegate=self;
//                           [self addAnnotationonMap:newLocation currentAddress:@"Current Location" subTitle:@""];
//
//
//                       }
//
//                   }];
}
    
#pragma mark - -------MapKit Delegates------------
 
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
//        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currLocation.coordinate, 800, 800);
//        [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
//
//        // Add an annotation
//        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
//        point.coordinate = currLocation.coordinate;
//        point.title = @"Where am I?";
//        point.subtitle = @"I'm here!!!";
//
//        [self.mapView addAnnotation:point];
}



#pragma mark - ------TableView Delegates------------

    
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrAutoCompleteData count];
}
    
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
         cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
   // NSString *strPlace=[NSString stringWithFormat:@"%@ %@",[self placeAtIndexPath:indexPath]
    cell.textLabel.text=[self placeAtIndexPath:indexPath].name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_txtSearchLocation resignFirstResponder];
    
  
    [self GooglePlaceDetail:indexPath];
    

}

-(void)GooglePlaceDetail:(NSIndexPath*)index
{
    SPGooglePlacesPlaceDetailQuery *query;
    if (!query)
    {
        query= [SPGooglePlacesPlaceDetailQuery query];
    }
    query.reference = [self placeAtIndexPath:index].placeId;
    query.sensor = YES;
    [query fetchPlaceDetail:^(NSDictionary *placeDictionary, NSError *error) {
        NSLog(@"%@",placeDictionary);
        double lat = [placeDictionary[@"geometry"][@"location"][@"lat"] doubleValue];
        double lng = [placeDictionary[@"geometry"][@"location"][@"lng"] doubleValue];
        CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
        CLLocation *loc = [[CLLocation alloc]initWithLatitude:lat longitude:lng];
        
        [geoCoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error){
            CLPlacemark *placemark = placemarks[0];
            NSLog(@"Found %@", placemark.postalCode);
            if (!error)
            {
                
                //    [self addPlacemarkAnnotationToMap:placemark addressString:addressString];
                //address = addressString;
                NSString *strPlace;
                if(placemark.postalCode  == nil)
                {
                    strPlace=[NSString stringWithFormat:@"%@",placemark.locality];
                }
                else{
                    strPlace=[NSString stringWithFormat:@"%@, %@",placemark.locality,placemark.postalCode];
                }
             //    strPlace = @"Maubege, 59600";
                address=strPlace;//[NSString stringWithFormat:@"%@",placemark.locality];
                _txtSearchLocation.text = address;
                //TblAutocomplete.hidden = YES;
                //[self recenterMapToPlacemark:placemark];
                [self addAnnotationonMap:placemark.location currentAddress:address subTitle:@""];
                [self increaseHeightWithAnimation:NO];
            }
        }];
    }];

}
#pragma mark - ------Custom Methods------------

-(SPGooglePlacesAutocompletePlace *)placeAtIndexPath:(NSIndexPath *)indexPath
{
    return arrAutoCompleteData[indexPath.row];
}


- (void)recenterMapToPlacemark:(CLPlacemark *)placemark
{
    //MKCoordinateRegion region;
    //MKCoordinateSpan span;
    
    //span.latitudeDelta = 0.02;
    //span.longitudeDelta = 0.02;
    
    //region.span = span;
    //region.center = placemark.location.coordinate;
    
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(placemark.location.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    //[self.mapView setRegion:region];
}

-(void)addAnnotationonMap:(CLLocation*)currentLocation currentAddress:(NSString*)address subTitle:(NSString*)subTitle
{
    [self.mapView removeAnnotations:self.mapView
     .annotations];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(currentLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = currentLocation.coordinate;
    point.title = address;
    point.subtitle = subTitle;
    
    [self.mapView addAnnotation:point];
}
- (void)addPlacemarkAnnotationToMap:(CLPlacemark *)placemark addressString:(NSString *)address
{
    [self.mapView removeAnnotation:selectedPlaceAnnotation];
    selectedPlaceAnnotation = [[MKPointAnnotation alloc] init];
    selectedPlaceAnnotation.coordinate = placemark.location.coordinate;
    latitude = placemark.location.coordinate.latitude;
    longitude = placemark.location.coordinate.longitude;
    // addressStr = address;
    CLLocationCoordinate2DMake(latitude,longitude);
}

#pragma mark - ------Register Button Actions------------

- (IBAction)btnRegisterAction:(id)sender
{
    [self.delegate locationSelected:address withLat:latitude andLong:longitude];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
