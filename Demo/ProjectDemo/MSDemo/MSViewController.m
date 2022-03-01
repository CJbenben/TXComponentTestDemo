//
//  MSViewController.m
//  Demo
//
//  Created by chenxiaojie on 2021/5/25.
//  Copyright © 2021 ChenJie. All rights reserved.
//

#import "MSViewController.h"

@interface MSViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConst;
@property (nonatomic, strong) NSArray *dataAry;

@end

static NSString *kJumpTitle     = @"kJumpTitle";
static NSString *kJumpClass     = @"kJumpClass";

@implementation MSViewController

- (NSArray *)dataAry {
    if (_dataAry == nil) {
        _dataAry = @[
            @{kJumpClass: @"GCDViewController", kJumpTitle: @"dispatch_group"},
            @{kJumpClass: @"ClickActionViewController", kJumpTitle: @"点击事件穿透情况"}
        ];
        
    }
    return _dataAry;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.topConst.constant = naviHeight;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSDictionary *dict = safeObjectTxAtIndex(self.dataAry, indexPath.row);
    cell.textLabel.text = EncodeStringFromDic(dict, kJumpTitle);
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = safeObjectTxAtIndex(self.dataAry, indexPath.row);
    NSString *className = EncodeStringFromDic(dict, kJumpClass);
    if (className.length) {
        Class class = NSClassFromString(className);
        id vc = [[class alloc] init];
        for (NSString *key in dict.allKeys) {
            @try {
                [vc setValue:[dict objectForKey:key] forKey:key];
            } @catch (NSException *exception) {
                
            } @finally {
                
            }
        }
        if (vc) {
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
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
