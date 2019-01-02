//
//  ImageCropperViewController.h
//  BONJOB
//
//  Created by VISHAL SETH on 19/03/18.
//  Copyright © 2018 Infoicon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BABCropperView.h"

@protocol ImageCropperDelegate
-(void)rectunglarImage:(UIImage *)croppedImage;
@end


@interface ImageCropperViewController : UIViewController
@property(nonatomic,strong)UIImage *selectedImage;
@property (weak, nonatomic) IBOutlet BABCropperView *cropperView;
@property (weak, nonatomic) IBOutlet UIImageView *croppedImageView;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnCrop;
- (IBAction)btnCancelAction:(id)sender;
- (IBAction)btnCropAction:(id)sender;
@property(nonatomic,strong) id <ImageCropperDelegate>delegate;

@end
