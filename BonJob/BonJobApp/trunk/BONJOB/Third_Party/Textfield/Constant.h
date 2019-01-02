
@class AppDelegate;

//#define selectedColor [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1.0]
#define APPDELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define IS_IPAD()(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE ([[[UIDevice currentDevice] model] hasPrefix:@"iPhone"] )
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"] )
#define NetworkError @"Quelque chose ne va pas avec la connexion internet"
#define NetworkSuccess  @"Vous êtes en ligne maintenant"

#define BlueColor  [UIColor colorWithRed:98.0/255.0 green:166.0/255.0 blue:216.0/255.0 alpha:1.0]
#define GrayColor  [UIColor colorWithRed:82.0/255.0 green:82.0/255.0 blue:82.0/255.0 alpha:1.0]
#define WhiteColor  [UIColor whiteColor]






#define textFieldColor [UIColor colorWithRed:214/255.0 green:214/255.0 blue:214/255.0 alpha:1.0].CGColor;

#define fontMacro(_size_) ((UIFont *)[UIFont fontWithName:@"HelveticaNeue-Light" size:(CGFloat)(_size_)])

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 67))/214 green:((float)((rgbValue & 0xFF00) >> 214))/255.0 blue:((float)((rgbValue & 0xFF00) >> 214))/255.0 alpha:1.0]

#define IS_HEIGHT_GTE_480 [[UIScreen mainScreen ] bounds].size.height == 480.0f

#define IS_HEIGHT_GTE_568 [[UIScreen mainScreen ] bounds].size.height == 568.0f

#define IS_HEIGHT_GTE_667 [[UIScreen mainScreen ] bounds].size.height == 667.0f

#define IS_HEIGHT_GTE_736 [[UIScreen mainScreen ] bounds].size.height == 736.0f

#define IS_IPHONE_4 ( IS_IPHONE && IS_HEIGHT_GTE_480)

#define IS_IPHONE_5 ( IS_IPHONE && IS_HEIGHT_GTE_568)

#define IS_IPHONE_6 ( IS_IPHONE && IS_HEIGHT_GTE_667)

#define IS_IPHONE_6Plus ( IS_IPHONE && IS_HEIGHT_GTE_736)

#define Normal 5.0

#define Short 3.0

#define Long 15.0

