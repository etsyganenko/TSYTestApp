//
//  TSYView.h
//  TSYTestApp
//
//  Created by Yevgen on 11/23/15.
//  Copyright © 2015 Yevgen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSYView : UIView
@property (nonatomic, strong)   IBOutlet UILabel    *locationLabel;

@property (nonatomic, strong)   IBOutlet UIButton   *showLocationButton;
@property (nonatomic, strong)   IBOutlet UIButton   *makePhotoButton;

@end
