//
//  ImageCropperViewController.m
//  BONJOB
//
//  Created by VISHAL SETH on 19/03/18.
//  Copyright © 2018 Infoicon. All rights reserved.
//

#import "ImageCropperViewController.h"

@interface ImageCropperViewController ()

@end

@implementation ImageCropperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cropperView.cropSize = CGSizeMake(1024.0f, 720.0f);
    self.cropperView.cropsImageToCircle = NO;
    
    self.cropperView.image = self.selectedImage;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnCancelAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnCropAction:(id)sender
{
    __weak typeof(self)weakSelf = self;
    [self.cropperView renderCroppedImage:^(UIImage *croppedImage, CGRect cropRect){
        
        [weakSelf displayCroppedImage:croppedImage];
    }];
}

- (void)displayCroppedImage:(UIImage *)croppedImage {
    
    self.cropperView.hidden = YES;
    self.croppedImageView.hidden = NO;
    self.croppedImageView.image = croppedImage;
    [self.delegate rectunglarImage:croppedImage];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
