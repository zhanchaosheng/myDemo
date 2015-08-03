//
//  LocationViewController.m
//  myDmeo
//
//  Created by Eddy on 15-6-19.
//  Copyright (c) 2015年 huawei. All rights reserved.
//

#import "LocationViewController.h"
#import "myAnnotation.h"

@interface LocationViewController ()
@property (strong,nonatomic) MKMapView *map;
@property (strong,nonatomic) CLLocationManager* locationMgr;
@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.title = @"位置定位";
    
    self.map = [[MKMapView alloc] initWithFrame:self.view.bounds];
    self.map.showsUserLocation = YES;//显示用户的位置
    self.map.mapType = MKMapTypeHybrid;//设置地图显示样式为卫星视图
    self.map.delegate = self;
    //地图类型
    //MKMapTypeStandard = 0,  标准
    //MKMapTypeSatellite,  卫星
    //MKMapTypeHybrid    混合
    
    //通过设定经纬度来获得一个地理位置
    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(39.915352,116.397105);
    float zoomLevel = 0.02;
    MKCoordinateSpan span = MKCoordinateSpanMake(zoomLevel, zoomLevel);//配置地图显示区域的缩放级别
    MKCoordinateRegion region = MKCoordinateRegionMake(coords,span);
    [self.map setRegion:[self.map regionThatFits:region] animated:YES];//设置MKMapView对象的显示区域
    //添加大头针
    myAnnotation *annotation = [[myAnnotation alloc] initWithCoordinate:coords];
    annotation.title = @"北京";
    annotation.subtitle = @"故宫博物馆";
    [self.map addAnnotation:annotation];
    
    //定位
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"位置服务没有开启");
    }
    self.locationMgr = [[CLLocationManager alloc] init];
    self.locationMgr.distanceFilter = 10;//每隔10米定位一次   kCLDistanceFilterNone
    self.locationMgr.desiredAccuracy = kCLLocationAccuracyBest;//精细程度 费电
    self.locationMgr.delegate = self;
    [self.locationMgr requestAlwaysAuthorization];
    [self.locationMgr startUpdatingLocation];
    
    //长按手势 插上大头针
    UILongPressGestureRecognizer* longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [self.map addGestureRecognizer:longPressGesture];
    
    [self.view addSubview:self.map];
}

- (void)longPress:(UILongPressGestureRecognizer *)gesture
{
    //只有长按第一次响应时才插上大头针
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        CGPoint point = [gesture locationInView:self.map];
        CLLocationCoordinate2D coordinate = [self.map convertPoint:point
                                              toCoordinateFromView:self.map];
        myAnnotation *annotation = [[myAnnotation alloc] initWithCoordinate:coordinate];
        annotation.title = @"111";
        annotation.subtitle = @"111_111";
        [self.map addAnnotation:annotation];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //停止定位
    [self.locationMgr stopUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"locationManager:didChangeAuthorizationStatus:");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *currLocation = [locations lastObject];
    NSLog(@"经度=%f 纬度=%f 高度=%f", currLocation.coordinate.latitude, currLocation.coordinate.longitude, currLocation.altitude);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //得到定位后的位置
    CLLocationCoordinate2D coordinate = newLocation.coordinate;
    MKCoordinateSpan span = MKCoordinateSpanMake(0.2, 0.2);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    [self.map setRegion:region animated:YES];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"定位失败");
}

#pragma mark - MKMapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    //如果是所在地 跳过   固定写法
    if ([annotation isKindOfClass:[mapView.userLocation class]]) {
        return nil;
    }
    MKPinAnnotationView* pinView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"ID"];
    if (pinView == nil) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"ID"];
    }
    
    pinView.canShowCallout = YES;//能显示Call信息 上面那些图字
    pinView.pinColor = MKPinAnnotationColorPurple;//只有三种
    //大头针颜色
    //MKPinAnnotationColorRed = 0,
    //MKPinAnnotationColorGreen,
    //MKPinAnnotationColorPurple
    pinView.animatesDrop = YES;//显示动画  从天上落下
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    view.backgroundColor = [UIColor redColor];
    pinView.leftCalloutAccessoryView = view;
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    pinView.rightCalloutAccessoryView = button;
    
    return pinView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
