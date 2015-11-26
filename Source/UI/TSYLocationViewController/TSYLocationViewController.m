//
//  TSYLocationViewController.m
//  TSYTestApp
//
//  Created by Yevgen on 11/23/15.
//  Copyright © 2015 Yevgen. All rights reserved.
//

#import "TSYLocationViewController.h"

#import <CoreLocation/CoreLocation.h>
#import <Google/AdMob.h>

#import "TSYLocationView.h"

static NSString * const kMCGoogleAnalyticsAdUnitID     = @"ca-app-pub-3940256099942544/2934735716"; // sample ID

@interface TSYLocationViewController () <CLLocationManagerDelegate,
                                 GADInterstitialDelegate,
                                 GADBannerViewDelegate>

@property (nonatomic, strong)       TSYLocationView             *mainView;

@property (nonatomic, strong)       CLLocationManager           *locationManager;
@property (nonatomic, strong)       CLLocation                  *currentLocation;

@property (nonatomic, readonly)     CLLocationDegrees           latitude;
@property (nonatomic, readonly)     CLLocationDegrees           longitude;
@property (nonatomic, readonly)     CLLocationDistance          altitude;
@property (nonatomic, readonly)     CLLocationAccuracy          horizontalAccuracy;
@property (nonatomic, readonly)     CLLocationAccuracy          verticalAccuracy;
@property (nonatomic, readonly)     NSDate                      *timestamp;

@property(nonatomic, retain)        IBOutlet GADBannerView      *bannerView;
@property(nonatomic, assign)        GADInterstitial             *interstitial;

- (void)startTracking;
- (void)stopTracking;

- (GADBannerView *)createAndLoadBanner;
- (GADInterstitial *)createAndLoadInterstitial;

@end

@implementation TSYLocationViewController

@dynamic latitude;
@dynamic longitude;
@dynamic altitude;
@dynamic horizontalAccuracy;
@dynamic verticalAccuracy;
@dynamic timestamp;

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self startTracking];
    
#ifndef PRO
    //    self.bannerView = [self createAndLoadBanner];
    //    self.interstitial = [self createAndLoadInterstitial];
#endif
}

#pragma mark -
#pragma mark Accessors

- (TSYLocationView *)mainView {
    return (TSYLocationView *)(self.view);
}

- (NSString *)screenName {
    return NSStringFromClass(self.class);
}

- (CLLocationDegrees)latitude {
    return self.currentLocation.coordinate.latitude;
}

- (CLLocationDegrees)longitude {
    return self.currentLocation.coordinate.longitude;
}

- (CLLocationDistance)altitude {
    return self.currentLocation.altitude;
}

- (CLLocationAccuracy)horizontalAccuracy {
    return self.currentLocation.horizontalAccuracy;
}

- (CLLocationAccuracy)verticalAccuracy {
    return self.currentLocation.verticalAccuracy;
}

- (NSDate *)timestamp {
    return self.currentLocation.timestamp;
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onGetLocation:(id)sender {
    [self.locationManager requestLocation];
}

#pragma mark -
#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations lastObject];
    
    self.currentLocation = location;
    [self showCurrentLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

#pragma mark -
#pragma mark GADInterstitialDelegate

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    if ([self.interstitial isReady]) {
        [self.interstitial presentFromRootViewController:self];
    }
}

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"%@", error);
}

#pragma mark -
#pragma mark GADBannerViewDelegate

- (void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    TSYLocationView *mainView = self.mainView;
    
    [mainView addSubview:bannerView];
    [mainView bringSubviewToFront:bannerView];
}

- (void)adView:(GADBannerView *)bannerView didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"%@", error);
}

#pragma mark -
#pragma mark Private methods

- (void)startTracking {
    CLLocationManager *locationManager = [CLLocationManager new];
    self.locationManager = locationManager;
    
    [locationManager requestAlwaysAuthorization];
    //    locationManager.allowsBackgroundLocationUpdates = YES;
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //    locationManager.requestAlwaysAuthorization
    
    //    [locationManager startUpdatingLocation];
}

- (void)stopTracking {
    [self.locationManager stopUpdatingLocation];
}

- (GADBannerView *)createAndLoadBanner {
    CGFloat viewHeight = [UIScreen mainScreen].bounds.size.height;
    CGSize bannerSize = CGSizeFromGADAdSize(kGADAdSizeSmartBannerPortrait);
    CGFloat bannerHeight = bannerSize.height;
    CGPoint bannerOriginPoint = CGPointMake(0, viewHeight - bannerHeight);
    
    GADBannerView *bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait
                                                               origin:bannerOriginPoint];
    
    bannerView.adUnitID = kMCGoogleAnalyticsAdUnitID;
    bannerView.rootViewController = self;
    bannerView.delegate = self;
    
    GADRequest *request = [GADRequest request];
    request.testDevices = @[kGADSimulatorID];
    
    [bannerView loadRequest:request];
    
    return bannerView;
}

- (GADInterstitial *)createAndLoadInterstitial {
    GADInterstitial *interstitial = [[GADInterstitial alloc] initWithAdUnitID:kMCGoogleAnalyticsAdUnitID];
    
    interstitial.delegate = self;
    
    GADRequest *request = [GADRequest request];
    request.testDevices = @[kGADSimulatorID];
    
    [interstitial loadRequest:request];
    
    return interstitial;
}

- (void)showCurrentLocation {
    self.mainView.latitudeLabel.text = [NSString stringWithFormat:@"Latitude: %f", self.latitude];
    self.mainView.longitudeLabel.text = [NSString stringWithFormat:@"Longitude: %f", self.longitude];
    self.mainView.altitudeLabel.text = [NSString stringWithFormat:@"Altitude: %f", self.altitude];
    self.mainView.horizontalAccuracyLabel.text = [NSString stringWithFormat:@"Horizontal Accuracy: %f", self.horizontalAccuracy];
    self.mainView.verticalAccuracyLabel.text = [NSString stringWithFormat:@"Vertical Accuracy: %f", self.verticalAccuracy];
    self.mainView.timestampLabel.text = [NSString stringWithFormat:@"Timestamp: %@", self.timestamp];
}

@end
