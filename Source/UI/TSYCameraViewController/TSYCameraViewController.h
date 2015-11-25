//
//  TSYCameraViewController.h
//  TSYTestApp
//
//  Created by Yevgen on 11/23/15.
//  Copyright © 2015 Yevgen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSYCameraViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

- (IBAction)onMakePhoto:(id)sender;
- (IBAction)onSelectPhoto:(id)sender;

@end
