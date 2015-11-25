//
//  TSYCameraViewController.m
//  TSYTestApp
//
//  Created by Yevgen on 11/23/15.
//  Copyright © 2015 Yevgen. All rights reserved.
//

#import "TSYCameraViewController.h"

#import "TSYCameraView.h"

@interface TSYCameraViewController ()
@property (nonatomic, strong)   TSYCameraView   *mainView;

@end

@implementation TSYCameraViewController

#pragma mark -
#pragma mark View Lifecycle

#pragma mark -
#pragma mark Accessors

- (TSYCameraView *)mainView {
    return (TSYCameraView *)(self.view);
}

- (IBAction)onMakePhoto:(id)sender {
    UIImagePickerController *imagePickerController = [UIImagePickerController new];
    
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    
//    [self presentViewController:imagePickerController animated:YES completion:nil];
    [self addChildViewController:imagePickerController];
    [self.mainView addSubview:imagePickerController.view];
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onSelectPhoto:(id)sender {
    
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate

- (void)    imagePickerController:(UIImagePickerController *)picker
    didFinishPickingMediaWithInfo:(NSDictionary<NSString *, id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    self.mainView.photoImageView.image = image;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
