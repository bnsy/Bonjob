//
//  WebserviceHelper.m
//  Icelolly


#import "WebserviceHelper.h"
#import "AppDelegate.h"
#import "Reachability.h"
#import "iToast.h"
#import "Constant.h"

//#import "AFNetworking.h"
@implementation NSString (URLEncoding)
-(NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding)));
}
@end

@implementation WebserviceHelper
@synthesize responseData;
@synthesize delegate;
@synthesize methodName;
@synthesize indicatorView;

-(void)hideProcess
{
    [SVProgressHUD dismiss];
}
- (void)processComplete
{
    //[self stopLoading:indicatorView];
    [SVProgressHUD dismiss];
    [[self delegate] processSuccessful:responseDict methodName:methodName];
    
    return;
}
    
-(void) progressHUD:(NSString *)msg
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleLight];
    [SVProgressHUD setBackgroundColor:TitleColor];
    [SVProgressHUD showWithStatus:NSLocalizedString(@"Please wait...", @"")];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
}



-(void) setDelegate:(id) val
{
    delegate=val;
}

-(id) delegate
{
    return delegate;
}

-(void)webserviceHelper:(NSDictionary*)jsonRequest webServiceUrl:(NSString *)webServiceUrl methodName:(NSString *)methodName showHud:(BOOL)B inWhichViewController:(UIViewController *)vc
{
    viewController = vc;
    if (B)
    {
        [self progressHUD:@"Please wait...."];
    }
    NSError *error;
    NSString *url=[NSString stringWithFormat:@"%@",webServiceUrl];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    
    NSData *requestData1 = [NSJSONSerialization dataWithJSONObject:jsonRequest options:0 error:&error];
    NSString *dataString=[[NSString alloc] initWithData:requestData1 encoding:NSUTF8StringEncoding];
    NSLog(@"URL:=========:========%@",url);
    NSLog(@"Request:=========:========%@",dataString);

    
    NSData *requestData=[dataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: requestData];
    NSString *str=[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"]valueForKey:@"authKey"];
    if (str==nil || str.length==0)
    {
        }
    else
    {
       [request setValue:str forHTTPHeaderField:@"authKey"];
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"userData"] valueForKey:@"user_id"]==nil)
        {
            
        }
        else
        {
            NSString *uid=[NSString stringWithFormat:@"%@",[[[NSUserDefaults standardUserDefaults]valueForKey:@"userData"]valueForKey:@"user_id"]];
            [request setValue:uid forHTTPHeaderField:@"login_user_id"];
        }
       
    }
    [request setValue:@"2" forHTTPHeaderField:@"language_id"];
    [request setValue:@"1" forHTTPHeaderField:@"version_id"];
//    [request setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"language_id"] forHTTPHeaderField:@"language_id"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"en-US" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error)
            {
                [_myTimer invalidate];
                responseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                responseString=[responseString stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
                responseString=[responseString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
                responseString=[responseString stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                responseString=[responseString stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];
                responseString=[responseString stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
                responseString=[responseString stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
                responseString=[responseString stringByReplacingOccurrencesOfString:@"\\r" withString:@" "];
                responseString=[responseString stringByReplacingOccurrencesOfString:@"\\n" withString:@" "];
                
                NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
                responseDict =[NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error:nil];
                NSLog(@"Response:=========:=====%@",responseDict);
                [self processComplete];
            }
            else
            {
                [_myTimer invalidate];
                self.responseData=nil;
                responseString=[NSString stringWithFormat:@"%@",error];
                NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
                responseDict =[NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error:nil];
                [self processComplete];
            }
        });
    }];
    [postDataTask resume];
}
    
    // Get API Format
    
    -(void)webserviceHelper:(NSString *)webServiceUrl showHud:(BOOL)B
    {
        if (B)
        {
            [self progressHUD:@"Please wait...."];
        }
        NSError *error;
        NSString *url=[NSString stringWithFormat:@"%@",webServiceUrl];
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                           timeoutInterval:60.0];
        
        
       
        NSLog(@"URL:=========:========%@",url);
        
        
        [request setHTTPMethod:@"GET"];
       
        NSString *strAuth=[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"]valueForKey:@"authKey"];
        if (strAuth==nil || strAuth.length==0)
        {
            
        }
        else
        {
            if (![webServiceUrl containsString:@"https://itunes.apple.com/lookup"]) {
                [request setValue:strAuth forHTTPHeaderField:@"authKey"];
                [request setValue:@"2" forHTTPHeaderField:@"language_id"];
                 [request setValue:@"1" forHTTPHeaderField:@"version_id"];
                [request setValue:[[[NSUserDefaults standardUserDefaults]valueForKey:@"userData"]valueForKey:@"user_id"] forHTTPHeaderField:@"login_user_id"];
            }
            
        }
       
       [request setValue:@"2" forHTTPHeaderField:@"language_id"];
      [request setValue:@"1" forHTTPHeaderField:@"version_id"];
        [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept-Encoding"];
        [request setValue:@"en-US" forHTTPHeaderField:@"Accept-Language"];
        
        NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!error)
                {
                  
                    responseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    responseString=[responseString stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
                    responseString=[responseString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
                    responseString=[responseString stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                    responseString=[responseString stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];
                    responseString=[responseString stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
                    responseString=[responseString stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
                    responseString=[responseString stringByReplacingOccurrencesOfString:@"\\r" withString:@" "];
                    responseString=[responseString stringByReplacingOccurrencesOfString:@"\\n" withString:@" "];
                    
                    NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
                    responseDict =[NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error:nil];
                    NSLog(@"Response:=========:=====%@",responseDict);
                    [self processComplete];
                }
                else
                {
                    self.responseData=nil;
                    responseString=[NSString stringWithFormat:@"%@",error];
                    NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
                    responseDict =[NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error:nil];
                    [self processComplete];
                }
            });
        }];
        [postDataTask resume];
    }
    

//-----------------For Chat Hisytory-----------------

-(void)webserviceHelperForChatHistory:(NSDictionary*)jsonRequest webServiceUrl:(NSString *)webServiceUrl methodName:(NSString *)methodName showHud:(BOOL)B inWhichViewController:(UIViewController *)vc
{
    viewController = vc;
    if (B)
    {
        [self progressHUD:@"Please wait...."];
    }
    NSError *error;
    NSString *url=[NSString stringWithFormat:@"%@",webServiceUrl];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    
    NSData *requestData1 = [NSJSONSerialization dataWithJSONObject:jsonRequest options:0 error:&error];
    NSString *dataString=[[NSString alloc] initWithData:requestData1 encoding:NSUTF8StringEncoding];
    
    NSLog(@"URL:=========:========%@",url);
    NSLog(@"Request:=========:========%@",dataString);
    //    dataString= [NSString stringWithFormat:@"json_data=%@", dataString];
    //    dataString=[dataString stringByReplacingOccurrencesOfString:@">" withString:@"%3E"];
    //    dataString=[dataString stringByReplacingOccurrencesOfString:@"<" withString:@"%3C"];
    //    dataString=[dataString stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
    //    dataString=[dataString stringByReplacingOccurrencesOfString:@"'" withString:@"%E2%80%98"];
    //    dataString=[dataString stringByReplacingOccurrencesOfString:@"£" withString:@"%C2%A3"];
    //    dataString=[dataString stringByReplacingOccurrencesOfString:@"€" withString:@"%u20AC"];
    //    dataString=[dataString stringByReplacingOccurrencesOfString:@"¥" withString:@"%C2%A5"];
    //    dataString=[dataString stringByReplacingOccurrencesOfString:@"₹" withString:@"%u20B9"];
    //    dataString=[dataString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    //    dataString=[dataString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    NSData *requestData=[dataString dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody: requestData];

    
    
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"en-US" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    
    [request setValue:@"tSTYI6C4GPKKJZdVOKSOxT2YycHDYt001MgEs3Dz" forHTTPHeaderField:@"Authorization"];
    [request setValue:@"bonjob" forHTTPHeaderField:@"Project-Key"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSString *str=[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"]valueForKey:@"authKey"];
    if (str==nil || str.length==0)
    {
        
    }
    else
    {
        [request setValue:str forHTTPHeaderField:@"authKey"];
        [request setValue:[[[NSUserDefaults standardUserDefaults]valueForKey:@"userData"]valueForKey:@"user_id"] forHTTPHeaderField:@"login_user_id"];
    }
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error)
            {
                [_myTimer invalidate];
                responseString=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                responseString=[responseString stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
                responseString=[responseString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
                responseString=[responseString stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                responseString=[responseString stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];
                responseString=[responseString stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
                responseString=[responseString stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
                responseString=[responseString stringByReplacingOccurrencesOfString:@"\\r" withString:@" "];
                responseString=[responseString stringByReplacingOccurrencesOfString:@"\\n" withString:@" "];
                
                NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
                responseDict =[NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error:nil];
                NSLog(@"Response:=========:=====%@",responseDict);
                [self processComplete];
            }
            else
            {
                [_myTimer invalidate];
                self.responseData=nil;
                responseString=[NSString stringWithFormat:@"%@",error];
                NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
                responseDict =[NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error:nil];
                [self processComplete];
            }
        });
    }];
    [postDataTask resume];
}


//---------------------------------------------------

-(void)webserviceHelper:(NSDictionary*)jsonRequest uploadData:(NSData *)attachmentData ImageParam:(NSString *)imageParam andVideoData:(NSData *)videoData withVideoThumbnail:(NSData *)thumbNail type:(NSString *)type webServiceUrl:(NSString *)webServiceUrl methodName:(NSString *)methodName showHud:(BOOL)B inWhichViewController:(UIViewController *)vc
{
    viewController = vc;
    [self progressHUD:@"Uploading...."];
        NSError *error;
  
        NSData *requestData1 = [NSJSONSerialization dataWithJSONObject:jsonRequest options:0 error:&error];
        NSString *dataString=[[NSString alloc] initWithData:requestData1 encoding:NSUTF8StringEncoding];
        dataString= [NSString stringWithFormat:@"%@", dataString];
        NSLog(@"Request%@",dataString);
        dataString=[dataString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    NSString *str   = webServiceUrl;
    NSString *urlString = [NSString stringWithFormat:@"%@",str];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    NSString *strAuth=[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"]valueForKey:@"authKey"];
    if (strAuth==nil || strAuth.length==0)
    {
        
    }
    else
    {
        [request setValue:strAuth forHTTPHeaderField:@"authKey"];
    }
    [request setValue:@"2" forHTTPHeaderField:@"language_id"];
     [request setValue:@"1" forHTTPHeaderField:@"version_id"];
    //    [request setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"language_id"] forHTTPHeaderField:@"language_id"];
    [request setValue:[[[NSUserDefaults standardUserDefaults]valueForKey:@"userData"]valueForKey:@"user_id"] forHTTPHeaderField:@"login_user_id"];
    NSMutableData *body = [NSMutableData data];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    if (attachmentData)
    {
        //  parameter Image
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *imageName=[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"IMG%@.png\"\r\n",imageParam,[SharedClass getCurrentTimestamp]];
        [body appendData:[imageName dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:attachmentData]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    
    if (videoData)
    {
//        // for video
//        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        NSString *videoName=[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"patch_video\"; filename=\"Patchvideo%@.mp4\"\r\n",[SharedClass getCurrentTimestamp]];
//        [body appendData:[videoName dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[NSData dataWithData:videoData]];
//        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//
//        // for thumbnail
//        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        NSString *enterPriseImageName=[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"patch_video_thumbnail\"; filename=\"Thumbnail%@.png\"\r\n",[SharedClass getCurrentTimestamp]];
//        [body appendData:[enterPriseImageName dataUsingEncoding:NSUTF8StringEncoding]];
//
//        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[NSData dataWithData:thumbNail]];
//        UIImage *testImage=[UIImage imageWithData:thumbNail];
//        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        // for video
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *videoName=[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"patch_video\"; filename=\"Patchvideo%@.mp4\"\r\n",[SharedClass getCurrentTimestamp]];
        [body appendData:[videoName dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:videoData]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        // for thumbnail
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *enterPriseImageName=[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"patch_video_thumbnail\"; filename=\"thumbnail%@.png\"\r\n",[SharedClass getCurrentTimestamp]];
        [body appendData:[enterPriseImageName dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:thumbNail]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];

    }
    
    //-----------------
    
    //  parameter post String
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"data\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[dataString dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];

    
    
    
    //Close Form
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    
    NSLog(@"attachmentData=====File size is : %.2f MB",(float)attachmentData.length/1024.0f);

    

    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (conn )
    {
        _responseData=[NSMutableData new];
    }
    
}

// FOR GALLERY IMAGE

// for recruiter Registration
-(void)webserviceHelper:(NSDictionary*)jsonRequest uploadData:(NSData *)attachmentData ImageParam:(NSString *)imageParam EnterPriseImage:(NSData *)enterpriseData andVideoData:(NSData *)videoData withVideoThumbnail:(NSData *)thumbNail type:(NSString *)type webServiceUrl:(NSString *)webServiceUrl methodName:(NSString *)methodName showHud:(BOOL)B inWhichViewController:(UIViewController *)vc
{
    viewController = vc;
    [self progressHUD:@"Uploading...."];
    NSError *error;
    NSData *requestData1 = [NSJSONSerialization dataWithJSONObject:jsonRequest options:0 error:&error];
    NSString *dataString=[[NSString alloc] initWithData:requestData1 encoding:NSUTF8StringEncoding];
    dataString= [NSString stringWithFormat:@"%@", dataString];
    NSLog(@"Request%@",dataString);
    dataString=[dataString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    NSString *str   = webServiceUrl;
    NSString *urlString = [NSString stringWithFormat:@"%@",str];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    NSString *strAuth=[[[NSUserDefaults standardUserDefaults] valueForKey:@"userData"]valueForKey:@"authKey"];
    if (strAuth==nil || strAuth.length==0)
    {
        
    }
    else
    {
        [request setValue:strAuth forHTTPHeaderField:@"authKey"];
    }
    [request setValue:@"2" forHTTPHeaderField:@"language_id"];
    [request setValue:@"1" forHTTPHeaderField:@"version_id"];
    //    [request setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"language_id"] forHTTPHeaderField:@"language_id"];
    [request setValue:[[[NSUserDefaults standardUserDefaults]valueForKey:@"userData"]valueForKey:@"user_id"] forHTTPHeaderField:@"login_user_id"];
    NSMutableData *body = [NSMutableData data];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    if (attachmentData)
    {
        //  parameter Image
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *imageName=[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"IMG%@.png\"\r\n",imageParam,[SharedClass getCurrentTimestamp]];
        [body appendData:[imageName dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:attachmentData]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if (enterpriseData)
    {
        //  parameter EnterPriseImage
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *enterPriseImageName=[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"enterprise_pic\"; filename=\"EnterPriseImage%@.png\"\r\n",[SharedClass getCurrentTimestamp]];
        [body appendData:[enterPriseImageName dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:enterpriseData]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    if (videoData)
    {
        // for video
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *videoName=[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"patch_video\"; filename=\"Patchvideo%@.mp4\"\r\n",[SharedClass getCurrentTimestamp]];
        [body appendData:[videoName dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:videoData]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        // for thumbnail
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        NSString *enterPriseImageName=[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"patch_video_thumbnail\"; filename=\"thumbnail%@.png\"\r\n",[SharedClass getCurrentTimestamp]];
        [body appendData:[enterPriseImageName dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:thumbNail]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    
    //-----------------
    
    //  parameter post String
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"data\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[dataString dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    //Close Form
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    
    NSLog(@"attachmentData=====File size is : %.2f MB",(float)attachmentData.length/1024.0f/1024.0f);
    
    
    
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (conn )
    {
        _responseData=[NSMutableData new];
    }
    
}


#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse
{
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
    responseString=[[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"uploaded photo response =%@",responseString);
    
    responseString=[responseString stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    
    responseString=[responseString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    
    responseString=[responseString stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    
    responseString=[responseString stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];
    
    responseString=[responseString stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    
    responseString=[responseString stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    
    responseString=[responseString stringByReplacingOccurrencesOfString:@"\\r" withString:@" "];
    
    responseString=[responseString stringByReplacingOccurrencesOfString:@"\\n" withString:@" "];
    
    
    
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
    
    
    
    
    responseDict =[NSJSONSerialization JSONObjectWithData:_responseData options: NSJSONReadingMutableContainers error:nil];
    
    
    [self processComplete];
    
    

    //[SVProgressHUD showSuccessWithStatus:[responseDict valueForKey:@"msg"]];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // The request has failed for some reason!
    // Check the error var
}

- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    float progress = [[NSNumber numberWithInteger:totalBytesWritten] floatValue];
    float total = [[NSNumber numberWithInteger: totalBytesExpectedToWrite] floatValue];
    [[self delegate] inProgress:progress/total];
    //[SVProgressHUD showProgress:(progress/total)*100];
    
    
    
//    CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle];
//    style.messageFont = [UIFont fontWithName:@"Ariel" size:14.0];
//    style.messageColor = [UIColor whiteColor];
//    style.messageAlignment = NSTextAlignmentCenter;
//    style.backgroundColor = [UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:0.9];
//    
//    
//    [viewController.navigationController.view makeToast:[NSString stringWithFormat:@"Uploading Percentage: %.2f",(progress/total)*100]
//                                   duration:0.1
//                                   position:CSToastPositionBottom
//                                      style:style];
//    [self.delegate inProgress:(progress/total)*100];
    
}
//- (void)inProgress:(float)value
//{
//    // [HUD hide:YES];
//    //[self stopLoading:indicatorView];
//    return;
//}

-(UIImage *)resizeImage:(UIImage *)image
{
    float actualHeight = image.size.height;
    float actualWidth = image.size.width;
    float maxHeight = 3*300.0;
    float maxWidth = 3*400.0;
    float imgRatio = actualWidth/actualHeight;
    float maxRatio = maxWidth/maxHeight;
    float compressionQuality = 0.5;//50 percent compression
    
    if (actualHeight > maxHeight || actualWidth > maxWidth)
    {
        if(imgRatio < maxRatio)
        {
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        }
        else if(imgRatio > maxRatio)
        {
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
        }
        else
        {
            actualHeight = maxHeight;
            actualWidth = maxWidth;
        }
    }
    
    CGRect rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    NSData *imageData = UIImageJPEGRepresentation(img, compressionQuality);
    UIGraphicsEndImageContext();
    
    return [UIImage imageWithData:imageData];
    
}

-(void)stop
{
    [con cancel];
    
}

- (NSTimer *)createTimer {
    return [NSTimer scheduledTimerWithTimeInterval:1.0
                                            target:self
                                          selector:@selector(timerTicked:)
                                          userInfo:nil
                                           repeats:YES];
}

- (void)timerTicked:(NSTimer *)timer {
    
    _currentTimeInSeconds++;
    
    [self formattedTime:_currentTimeInSeconds];
    
}

-(void)formattedTime:(int)totalSeconds
{
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    
    NSLog(@"time take %@ min %@ sec",[NSString stringWithFormat:@"%02d",minutes],[NSString stringWithFormat:@"%02d",seconds]);
    if(totalSeconds % 10 == 0)
    {
        [[[[iToast makeText:NSLocalizedString(@" Please be patient. Image uploading in progress.... ", @"")]
           setGravity:iToastGravityBottom] setDuration:iToastDurationNormal] show];
    }
}

@end

