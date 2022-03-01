//
//  PhoneFontViewController.m
//  Demo
//
//  Created by ChenJie on 2018/4/24.
//  Copyright © 2018年 ChenJie. All rights reserved.
//

#import "PhoneFontViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
//#import "TXFileCache.h"

@interface PhoneFontViewController ()

@property (nonatomic, strong) UILabel *label1;
@property (nonatomic, strong) UILabel *label2;
@property (nonatomic, strong) UILabel *label3;
@property (nonatomic, strong) UILabel *label4;
@property (nonatomic, strong) UILabel *label5;
@property (nonatomic, strong) UISlider *volumeViewSlider;
@end

@implementation PhoneFontViewController

#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 90000

//字体样式
#define FONTSTYLE_PingFangSC_Light @"PingFangSC-Light"
#define FONTSTYLE_PingFangSC_Medium @"PingFangSC-Medium"
#define FONTSTYLE_PingFangSC_Regular @"PingFangSC-Regular"

#else

#define FONTSTYLE_PingFangSC_Light @"Helvetica-Light"
#define FONTSTYLE_PingFangSC_Medium @"Helvetica-Bold"
#define FONTSTYLE_PingFangSC_Regular @"Helvetica"

#endif

- (UILabel *)label1 {
    if (_label1 == nil) {
        _label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, self.view.width-40, 50)];
        _label1.text = @"凹凸租车autoyol0123456789";
        _label1.font = [UIFont fontWithName:FONTSTYLE_PingFangSC_Light size:17];
    }
    return _label1;
}

- (UILabel *)label2 {
    if (_label2 == nil) {
        _label2 = [[UILabel alloc] initWithFrame:CGRectMake(self.label1.x, self.label1.bottom + 20, self.label1.width, self.label1.height)];
        _label2.text = @"凹凸租车autoyol0123456789";
        _label2.font = [UIFont fontWithName:FONTSTYLE_PingFangSC_Medium size:17];
    }
    return _label2;
}

- (UILabel *)label3 {
    if (_label3 == nil) {
        _label3 = [[UILabel alloc] initWithFrame:CGRectMake(self.label2.x, self.label2.bottom + 20, self.label2.width, self.label2.height)];
        _label3.text = @"凹凸租车autoyol0123456789";
        _label3.font = [UIFont fontWithName:FONTSTYLE_PingFangSC_Regular size:17];
    }
    return _label3;
}

- (UILabel *)label4 {
    if (_label4 == nil) {
        _label4 = [[UILabel alloc] initWithFrame:CGRectMake(self.label3.x, self.label3.bottom + 20, SCREEN_WIDTH - 2 * self.label3.x, 60)];
        _label4.numberOfLines = 2;
        _label4.font = [UIFont fontWithName:FONTSTYLE_PingFangSC_Regular size:30];
    }
    return _label4;
}

- (UILabel *)label5 {
    if (_label5 == nil) {
        _label5 = [[UILabel alloc] initWithFrame:CGRectMake(self.label4.x, self.label4.bottom + 20, SCREEN_WIDTH - 2 * self.label4.x, 100)];
        _label5.numberOfLines = 2;
    }
    return _label5;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.label1];
    [self.view addSubview:self.label2];
    [self.view addSubview:self.label3];
    [self.view addSubview:self.label4];
    [self.view addSubview:self.label5];
    
//    [self showHUDLoading];
    
    self.label4.text = RMB(@"123.44");
    self.label4.backgroundColor = [UIColor darkGrayColor];
//    self.label4.text = @"SDCycleScrollView之前一直在OC中使用觉得很简单又熟悉了所以这次写的Demo依旧搬了过来.SDCycleScrollView之前一直在OC中使用觉得很简单又熟悉了所以这次写的Demo依旧搬了过来.";

    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self.label4.text];
    //设置行间距
//    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
//    style.headIndent = 50;                //每行的左右间距
//    [attrStr addAttributes:@{NSParagraphStyleAttributeName:style} range:NSMakeRange(0, self.label4.text.length)];
    //设置字间距
    [attrStr addAttribute:NSKernAttributeName value:@(-5) range:NSMakeRange(0, 1)];
    self.label4.attributedText = RMB_Attr(@"1.234");
    
    CGFloat height = [self.label4.text sizeWithFont:self.label4.font maxSize:CGSizeMake(self.label4.width, CGFLOAT_MAX)].height;
    NSLog(@"height = %.2f", height);
    CGFloat height2 = [self.label4 sizeThatFits:CGSizeMake(self.label4.width, MAXFLOAT)].height;
    self.label4.height = height2;
    NSLog(@"height2 = %.2f", height2);
    
    UIFont *font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    NSLog(@"当前字体。。。 %@", font);
    
    NSString *lldb = @"lldb";
    NSLog(@"lldb = %@", lldb);
    
    
    for (NSString *fontfamilyname in [UIFont familyNames])
    {
        NSLog(@"family:'%@'",fontfamilyname);
        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
        {
            NSLog(@"\tfont:'%@'",fontName);
        }
        NSLog(@"-------------");
    }
    self.label5.text = @"ABCDEFG ￥0123456789 abcdefg";
    self.label5.font = [UIFont fontWithName:@"DINAlternate-Bold" size:28];
    self.label5.font = [UIFont fontWithName:@"DIN-Alternate" size:28];
    
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    self.volumeViewSlider = nil;
    for (UIView *view in [volumeView subviews]){
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            self.volumeViewSlider = (UISlider *)view;
            break;
        }
    }
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeChange:) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
    
//    NSDictionary *testDict = @{@"key": @"value", @"name":@"chenxiaojie"};
//    [[TXFileCache globalCache] writeNetworkDict:testDict forUrlKey:@"key1"];
//
//    NSDictionary *testDict2 = @{@"key2": @"value2", @"name2":@"chenxiaojie2"};
//    [[TXFileCache globalCache] writeNetworkDict:testDict2 forUrlKey:@"key2"];
//
//
//    [[TXFileCache globalCache] writeNetworkDict:testDict2 forUrlKey:@"key1"];
//
//
//    NSDictionary *dict = [[TXFileCache globalCache] readNetworkDictForKey:@"key11"];
//    NSLog(@"dict = %@", dict);
    
    
    // AfnetWorking 处理高精度 bug
    NSString *jsonStr = @"{\"71.40\":71.40, \"9.70\":9.70, \"69.90\":69.90, \"80.40\":80.40, \"188.40\":188.40}";
    NSLog(@"json:%@", jsonStr);
    NSData *jsonData_ = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *jsonParsingError_ = nil;
    NSDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:[NSJSONSerialization JSONObjectWithData:jsonData_ options:0 error:&jsonParsingError_]];
    NSLog(@"dic:%@", dic);
    
    
    NSString *str = [dic objectForKey:@"9.70"];
    NSLog(@"str:%@", str);
    NSLog(@"str:%@", decimalNumberWithDouble(str));
    
//    double testDouble = [dic[@"Body"] double]; //有问题 90.989999999999994
//    NSString *convertString = decimalNumberWithString(testDouble);
//    NSLog(@"%@", convertString);\
    
}

NSString *decimalNumberWithDouble(NSString *str){
    double conversionValue = [str doubleValue];
    NSString *doubleString        = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber    = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}


-(NSString *)reviseString:(NSString *)str
{
    //直接传入精度丢失有问题的Double类型
    double conversionValue = [str doubleValue];
    NSString *doubleString = [NSString stringWithFormat:@"%lf", conversionValue];
    NSDecimalNumber *decNumber = [NSDecimalNumber decimalNumberWithString:doubleString];
    return [decNumber stringValue];
}

- (CGSize )numberOfAdaptiveRowsUILabel:(UILabel *)label systemFontOfSize:(UIFont *)font{
    label.textAlignment = NSTextAlignmentLeft;
    
    label.numberOfLines = 2;
    
    label.lineBreakMode = NSLineBreakByWordWrapping;
    
    CGSize size = [label sizeThatFits:CGSizeMake(label.frame.size.width, MAXFLOAT)];
    
    label.frame =CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, size.height);
    
    label.font = font;
    
    return size;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.volumeViewSlider.value   = 0;// 越小幅度越小0-1之间的数值
}

- (void)volumeChange:(NSNotification *)notification {
    NSString *volume = [notification.userInfo objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"];
    NSLog(@"FlyElephant-系统音量:%@", volume);
    self.volumeViewSlider.value = [volume floatValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
