//
//  ChatListCell.m
//  Whatsapp
//
//  Created by Rafael Castro on 7/24/15.
//  Copyright (c) 2015 HummingBird. All rights reserved.
//

#import "ChatCell.h"
#import "LocalStorage.h"

@interface ChatCell()

@property (weak, nonatomic) IBOutlet UILabel *lblName;

@property (weak, nonatomic) IBOutlet UILabel *lblJobTitle;


@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *notificationLabel;

@end



@implementation ChatCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.picture.layer.cornerRadius = self.picture.frame.size.width/2;
    self.picture.layer.masksToBounds = YES;
    self.notificationLabel.layer.cornerRadius = self.notificationLabel.frame.size.width/2;
    self.notificationLabel.layer.masksToBounds = YES;
    self.lblName.text = @"";
    self.messageLabel.text = @"";
    self.timeLabel.text = @"";
}
-(void)setChat:(Chat *)chat
{
    _chat = chat;
    self.lblName.text = [NSString stringWithFormat:@"%@ %@",chat.contact.name,chat.contact.lastName];
    self.lblJobTitle.text=chat.contact.job_Name;
    [self.picture sd_setImageWithURL:[NSURL URLWithString:chat.contact.image_id] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
    {
        if (error)
        {
            [_picture setImage:[UIImage imageNamed:@"default_photo_deactive.png"]];
        }
    }];

    
    
    //self.messageLabel.text = chat.last_message.text;
    [self updateTimeLabelWithDate:chat.last_message.date];
    [self updateUnreadMessagesIcon:chat.numberOfUnreadMessages];
    self.notificationLabel.text=chat.contact.unreadCount;
    
    
    
    
    self.timeLabel.text=[Alert getDateWithString:chat.contact.lastMesageDate getFormat:GET_FORMAT_TYPE setFormat:SET_FORMAT_TYPE4];
    
    
    //self.timeLabel.text=chat.contact.lastMesageDate;
    if ([chat.contact.unreadCount intValue]>0)
    {
        self.notificationLabel.backgroundColor=InternalButtonColor;
        self.notificationLabel.textColor=[UIColor whiteColor];
        [self.notificationLabel setHidden:NO];
    }
    else
    {
        [self.notificationLabel setHidden:YES];
        self.notificationLabel.backgroundColor=[UIColor clearColor];
    }
}
-(void)updateTimeLabelWithDate:(NSDate *)date
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.timeStyle = NSDateFormatterShortStyle;
    df.dateStyle = NSDateFormatterNoStyle;
    df.doesRelativeDateFormatting = NO;
    self.timeLabel.text = [df stringFromDate:date];
}
-(void)updateUnreadMessagesIcon:(NSInteger)numberOfUnreadMessages
{
    
    self.notificationLabel.hidden = numberOfUnreadMessages == 0;
    self.notificationLabel.text = [NSString stringWithFormat:@"%ld", (long)numberOfUnreadMessages];
}
-(UIImageView *)imageView
{
    return _picture;
}

@end
