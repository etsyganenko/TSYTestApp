//
//  TSYStartViewController.m
//  TSYTestApp
//
//  Created by Yevgen on 11/26/15.
//  Copyright © 2015 Yevgen. All rights reserved.
//

#import "TSYStartViewController.h"

#import "TSYLocationViewController.h"
#import "TSYCameraViewController.h"

@interface TSYStartViewController ()

@end

@implementation TSYStartViewController

- (IBAction)onLocation:(id)sender {
    NSString *locationViewControllerNibName = NSStringFromClass([TSYLocationViewController class]);
    TSYLocationViewController *locationViewController = [[TSYLocationViewController alloc] initWithNibName:locationViewControllerNibName
                                                                                          bundle:nil];
    
    [self.navigationController pushViewController:locationViewController animated:YES];
}

- (IBAction)onCamera:(id)sender {
    NSString *cameraViewControllerNibName = NSStringFromClass([TSYCameraViewController class]);
    TSYCameraViewController *cameraViewController = [[TSYCameraViewController alloc] initWithNibName:cameraViewControllerNibName
                                                                                                    bundle:nil];
    
    [self.navigationController pushViewController:cameraViewController animated:YES];
}

@end
