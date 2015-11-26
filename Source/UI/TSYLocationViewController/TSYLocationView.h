//
//  TSYLocationView.h
//  TSYTestApp
//
//  Created by Yevgen on 11/23/15.
//  Copyright © 2015 Yevgen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSYLocationView : UIView
@property (nonatomic, strong)   IBOutlet UILabel    *latitudeLabel;
@property (nonatomic, strong)   IBOutlet UILabel    *longitudeLabel;
@property (nonatomic, strong)   IBOutlet UILabel    *altitudeLabel;
@property (nonatomic, strong)   IBOutlet UILabel    *horizontalAccuracyLabel;
@property (nonatomic, strong)   IBOutlet UILabel    *verticalAccuracyLabel;
@property (nonatomic, strong)   IBOutlet UILabel    *timestampLabel;

@property (nonatomic, strong)   IBOutlet UIButton   *locationButton;

@end
