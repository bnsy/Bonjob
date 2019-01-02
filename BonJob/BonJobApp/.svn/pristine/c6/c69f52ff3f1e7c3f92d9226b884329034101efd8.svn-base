//
//  ChatViewController.h
//  JabberClient
//
//  Created by Sandeep Kumar on 30/10/15.
//
//

#import "JSQMessagesViewController.h"
#import "JSQMessages.h"
#import "RNGridMenu.h"
#import "Constant.h"
#import "Alert.h"
#import "SoundEffect.h"
//#import "UIImageView+AFNetworking.h"

@interface ChatViewController : JSQMessagesViewController
<UIActionSheetDelegate, UIImagePickerControllerDelegate, RNGridMenuDelegate,ProcessDataDelegate>

{
        NSString *chatWithUser;
        NSString *userImageurl;
        NSString *nameOfTheUser;
        UILabel *lblOnlineIndicator;
        UILabel *lblOnlineStatus;
       //UIImage* senderImage;
      //  UIImage* receiverImage;


}

- (id)initWithUser:(NSString *) userName andNameOfUser:(NSString *)nameOfUser andUserImage:(NSString *)userImage;
@property (strong, nonatomic) NSString* forwardMsg;
@property (strong, nonatomic) UIImage* senderImage;
@property (strong, nonatomic) UIImage* receiverImage;
@property (strong, nonatomic) NSString* jobTitle;
@property (strong, nonatomic) NSString* JobDesc;
@property (strong,nonatomic) NSString *jobImage;
@property (strong, nonatomic) NSString* identifier;
@property (strong, nonatomic) NSString* current_User_Id;

// Group chat
@property(nonatomic,assign) BOOL isGroupChat;
@property(nonatomic,strong) NSString *chat_id;


@end
