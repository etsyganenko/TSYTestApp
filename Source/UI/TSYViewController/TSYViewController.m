//
//  TSYViewController.m
//  TSYTestApp
//
//  Created by Yevgen on 11/23/15.
//  Copyright © 2015 Yevgen. All rights reserved.
//

#import "TSYViewController.h"

#import <CoreLocation/CoreLocation.h>
#import <Google/AdMob.h>

#import "TSYView.h"
#import "TSYCameraViewController.h"

static NSString * const kMCGoogleAnalyticsAdUnitID     = @"ca-app-pub-3940256099942544/2934735716"; // sample ID

@interface TSYViewController () <CLLocationManagerDelegate,
                                 GADInterstitialDelegate,
                                 GADBannerViewDelegate>

@property (nonatomic, strong)   TSYView                     *mainView;

@property (nonatomic, strong)   CLLocationManager           *locationManager;
@property (nonatomic, strong)   CLLocation                  *currentLocation;

@property(nonatomic, retain)    IBOutlet GADBannerView      *bannerView;
@property(nonatomic, assign)    GADInterstitial             *interstitial;

- (void)startTracking;
- (void)stopTracking;

- (GADBannerView *)createAndLoadBanner;
- (GADInterstitial *)createAndLoadInterstitial;

@end

@implementation TSYViewController

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

- (TSYView *)mainView {
    return (TSYView *)(self.view);
}

- (NSString *)screenName {
    return NSStringFromClass(self.class);
}

- (void)setCurrentLocation:(CLLocation *)currentLocation {
    self.mainView.locationLabel.text = [NSString stringWithFormat:@"%@", currentLocation];
}

#pragma mark -
#pragma mark Interface Handling

- (IBAction)onShowLocation:(id)sender {
    [self.locationManager requestLocation];
}

- (IBAction)onMakePhoto:(id)sender {
    TSYCameraViewController *cameraController = [[TSYCameraViewController alloc] initWithNibName:NSStringFromClass([TSYCameraViewController class])
                                                                                          bundle:nil];
    
    [self.navigationController pushViewController:cameraController animated:YES];
}

#pragma mark -
#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *location = [locations lastObject];
    
    NSLog(@"%@", location);
    self.currentLocation = location;
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
    TSYView *mainView = self.mainView;
    
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

@end
