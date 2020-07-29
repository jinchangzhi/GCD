//
//  ViewController.m
//  GCD_Demo
//
//  Created by apple on 2020/7/29.
//  Copyright © 2020 Hunter. All rights reserved.
//

#import "ViewController.h"
#import "Macro.h"

@interface ViewController ()<
UITableViewDelegate,
UITableViewDataSource
>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    
    UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSize.width, kSize.height) style:UITableViewStyleGrouped];
    tv.delegate = self;
    tv.dataSource = self;
    [self.view addSubview:tv];
}

-(NSArray *)examples{
    return @[
        @[@"Concurrent & Serial",@"AsyncConViewController"],
        @[@"Barrier",@"BarrierViewController"],
        @[@"GroupNotify",@"GroupNotifyViewController"],
        @[@"GroupWait",@"GroupWaitViewController"],
        @[@"Semaphore",@"SemaphoreViewController"]
    ];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = [self examples][indexPath.row][0];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self examples].count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    NSString *str = [self examples][indexPath.row][1];
    Class cls = NSClassFromString(str);
    UIViewController *vc = cls.new;
    [self.navigationController pushViewController:vc animated:true];
}

@end
