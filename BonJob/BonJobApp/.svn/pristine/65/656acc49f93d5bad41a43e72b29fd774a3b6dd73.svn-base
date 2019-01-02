//
//  WebserviceHelper.h
//  Icelolly



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Reachability.h"


@interface NSString (URLEncoding)
-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;
@end
@protocol ProcessDataDelegate <NSObject>
-(void)inProgress:(float)value;
@required
- (void)processSuccessful: (NSDictionary *)responseDict methodName:(NSString *)methodNameIs;

@end


@interface NSURLRequest(Private)
+(void)setAllowsAnyHTTPSCertificate:(BOOL)inAllow forHost:(NSString *)inHost;

@end

@interface WebserviceHelper : NSObject <NSURLSessionDelegate, NSURLSessionTaskDelegate, NSURLSessionDataDelegate> {
    NSString *mainString;
    
    NSMutableData *responseData;
    id delegate;
    NSString *responseString;
    NSDictionary *responseDict;
    NSURLConnection *con;
    UIViewController *viewController;

    BOOL isLaunched;
    UIView *indicatorView;

    UIWindow * window;
    NSMutableData *_responseData;
}
@property(strong,nonatomic)UIView *indicatorView;
@property(strong,nonatomic) NSString *methodName;

@property int currentTimeInSeconds;
@property (weak, nonatomic) NSTimer *myTimer;

@property (retain) id delegate;
@property (nonatomic, retain) NSMutableData *responseData;
-(void)hideProcess;
-(void)progressHUD:(NSString *)msg;

-(void)webserviceHelperForChatHistory:(NSDictionary*)jsonRequest webServiceUrl:(NSString *)webServiceUrl methodName:(NSString *)methodName showHud:(BOOL)B inWhichViewController:(UIViewController *)vc;

-(void)webserviceHelper:(NSDictionary*)jsonRequest webServiceUrl:(NSString *)webServiceUrl methodName:(NSString *)methodName showHud:(BOOL)B inWhichViewController:(UIViewController *)vc;

-(void)webserviceHelper:(NSDictionary*)jsonRequest uploadData:(NSData *)attachmentData ImageParam:(NSString *)imageParam andVideoData:(NSData *)videoData withVideoThumbnail:(NSData *)thumbNail type:(NSString *)type webServiceUrl:(NSString *)webServiceUrl methodName:(NSString *)methodName showHud:(BOOL)B inWhichViewController:(UIViewController *)vc;

-(void)webserviceHelper:(NSDictionary*)jsonRequest uploadData:(NSData *)attachmentData ImageParam:(NSString *)imageParam EnterPriseImage:(NSData *)enterpriseData andVideoData:(NSData *)videoData withVideoThumbnail:(NSData *)thumbNail type:(NSString *)type webServiceUrl:(NSString *)webServiceUrl methodName:(NSString *)methodName showHud:(BOOL)B inWhichViewController:(UIViewController *)vc;
    -(void)webserviceHelper:(NSString *)webServiceUrl showHud:(BOOL)B;
-(void)stop;

//-(BOOL)isNetWorkAvailable;
-(UIImage *)resizeImage:(UIImage *)image;
@end
