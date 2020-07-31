//
//  ViewController.m
//  GCD_Demo
//
//  Created by apple on 2020/7/29.
//  Copyright © 2020 Hunter. All rights reserved.
//

#import "ViewController.h"
#import "AboutViewController.h"
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
    self.title = @"GCD";
    
    UITableView *tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kSize.width, kSize.height) style:UITableViewStyleGrouped];
    tv.delegate = self;
    tv.dataSource = self;
    [self.view addSubview:tv];
    
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithTitle:@"About" style:UIBarButtonItemStylePlain target:self action:@selector(onClickAbout)];
    self.navigationItem.rightBarButtonItem = bbi;
}

-(void)onClickAbout{
    AboutViewController *vc = AboutViewController.new;
    [self.navigationController pushViewController:vc animated:true];
}

-(NSArray *)examples{
    return @[
    @[
    @[@"Concurrent & Serial",@"AsyncConViewController"],
    @[@"Barrier",@"BarrierViewController"],
    @[@"GroupNotify",@"GroupNotifyViewController"],
    @[@"GroupWait",@"GroupWaitViewController"],
    @[@"Semaphore",@"SemaphoreViewController"]
    ],
    @[
    @[@"Runtime",@"RuntimeViewController"],
    @[@"Runloop",@"RunloopViewController"]
    ]
    ];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    NSArray *array = [self examples][indexPath.section];
    cell.textLabel.text = array[indexPath.row][0];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = [self examples][section];
    return array.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self examples].count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    NSArray *array = [self examples][indexPath.section];
    NSString *str = array[indexPath.row][1];
    Class cls = NSClassFromString(str);
    UIViewController *vc = cls.new;
    [self.navigationController pushViewController:vc animated:true];
}

@end
