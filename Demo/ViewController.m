//
//  ViewController.m
//  Demo
//
//  Created by ChenJie on 2017/11/2.
//  Copyright © 2017年 ChenJie. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "Country.h"
#import <CoreLocation/CoreLocation.h>
#import "MJRefresh.h"
#import "AFNetworking.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "NNValidationCodeView.h"
#import "SecondViewController.h"

@interface ViewController ()<CLLocationManagerDelegate, MAMapViewDelegate, AMapSearchDelegate>

@property (nonatomic, copy) Person *person;
@property (nonatomic, strong) Person *person1;
@property (nonatomic, copy) NSMutableArray *dataAry;

@property (nonatomic, strong) CLLocationManager *locationManger;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self pushNextVC];
    
    //[self testGradient];
    
    //[self testAlertView];
    
    //[self testMapView];
    //[self startLocation];
    //[self test];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self presentVC];
}

- (void)presentVC {
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:secondVC];
    [self presentViewController:navi animated:YES completion:nil];
}

- (void)pushNextVC {
    SecondViewController *secondVC = [[SecondViewController alloc] init];
    [self.navigationController pushViewController:secondVC animated:NO];
}

- (void)testGradient {
    NNValidationCodeView *view = [[NNValidationCodeView alloc] initWithFrame:CGRectMake(80, 100, 300, 45) andLabelCount:6 andLabelDistance:10];
    [self.view addSubview:view];
    view.changedColor = [UIColor yellowColor];
    view.codeBlock = ^(NSString *codeString) {
        NSLog(@"验证码:%@", codeString);
    };
}

- (void)testAlertView {
    UIAlertView *alertview1 = [[UIAlertView alloc] initWithTitle:@"title1" message:@"message1" delegate:nil cancelButtonTitle:@"cancle1" otherButtonTitles:@"sure1", nil];
    UIAlertView *alertview2 = [[UIAlertView alloc] initWithTitle:@"title2" message:@"message2" delegate:nil cancelButtonTitle:@"cancle2" otherButtonTitles:@"sure2", nil];
    UIAlertView *alertview3 = [[UIAlertView alloc] initWithTitle:@"title3" message:@"message3" delegate:nil cancelButtonTitle:@"cancle3" otherButtonTitles:@"sure3", nil];
    
    [alertview3 show];
    [alertview2 show];
    [alertview1 show];
}

- (void)testMapView {
    MAMapView *_mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    ///把地图添加至view
    [self.view addSubview:_mapView];
    
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.zoomLevel = 17;
    _mapView.delegate = self;
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation {
    
    CLLocationDegrees latitude = userLocation.coordinate.latitude;
    CLLocationDegrees longitude = userLocation.coordinate.longitude;

    CLLocationCoordinate2D amapcoord = AMapCoordinateConvert(CLLocationCoordinate2DMake(latitude,longitude), AMapCoordinateTypeGoogle);

    AMapReGeocodeSearchRequest *regeoRequest = [[AMapReGeocodeSearchRequest alloc] init];
    regeoRequest.location = [AMapGeoPoint locationWithLatitude:amapcoord.latitude longitude:amapcoord.longitude];
    regeoRequest.radius = 10000;
    regeoRequest.requireExtension = YES;

    AMapSearchAPI *search = [[AMapSearchAPI alloc] init];
    search.delegate = self;
    [search AMapReGoecodeSearch:regeoRequest];
}

- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    NSLog(@"location error");
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response {
    NSLog(@"response = %@", response);
    //response.regeocode.addressComponent.streetNumber
}
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
    NSLog(@"search error");
}


- (void)startLocation {
    // 判断定位功是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManger = [[CLLocationManager alloc]init];
        _locationManger.delegate = self;
        [_locationManger requestAlwaysAuthorization];
        [_locationManger requestWhenInUseAuthorization];
        // 设置寻址经度
        _locationManger.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManger.distanceFilter = 5.0;
        [_locationManger startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    // 打印当前经纬度
    NSLog(@"%f==%f", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
    
    // 地理反编码  可以根据地理坐标确定地理位置信息 (街道门派)
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count > 0) {
            CLPlacemark *placeMark = placemarks[0];
            NSString *currentCity = placeMark.locality;
            
            if (!currentCity) {
                currentCity = @"无法定位当前城市";
            }
            NSLog(@"当前国家==%@", placeMark.country);
            NSLog(@"当前城市==%@", currentCity);
            NSLog(@"当前位置==%@", placeMark.subLocality);
            NSLog(@"当前街道==%@", placeMark.thoroughfare);
            NSLog(@"当前具体位置==%@", placeMark.name);
        } else if (error == nil && placemarks.count == 0){
            NSLog(@"no location and error return");
        } else if (error) {
            NSLog(@"location error %@", error);
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"location error");
}

#pragma mark - copy 和 strong 的区别
- (void)test {
    Country * country = [[Country alloc] init];
    country.name = @"countr2";
    
    Person *person = [[Person alloc] init];
    self.person = person;
    self.person.name = @"person";
    self.person.country = country;
    self.person.country.name =  @"country";

    NSLog(@"%@ %@", self.person.name ,self.person.country.name);
    
    self.person1 = [[Person alloc] init];
    self.person1.name = @"person 1";
    self.person1.country.name =  @"country1";

    NSLog(@"%@ %@", self.person1.name ,self.person1.country.name);


    self.person.country =  country;

    NSLog(@"%@ %@", self.person.name ,self.person.country.name);

    self.person1.country =  country;

    NSLog(@"%@ %@", self.person1.name ,self.person1.country.name);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
