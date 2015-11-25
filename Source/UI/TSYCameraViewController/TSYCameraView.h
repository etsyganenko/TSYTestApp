//
//  TSYCameraView.h
//  TSYTestApp
//
//  Created by Yevgen on 11/23/15.
//  Copyright © 2015 Yevgen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSYCameraView : UIView
@property (nonatomic, strong)   IBOutlet UIImageView    *photoImageView;

@property (nonatomic, strong)   IBOutlet UIButton       *makePhotoButton;
@property (nonatomic, strong)   IBOutlet UIButton       *selectPhotoButton;

@end
