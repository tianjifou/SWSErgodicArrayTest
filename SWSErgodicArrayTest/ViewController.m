//
//  ViewController.m
//  SWSErgodicArrayTest
//
//  Created by 天机否 on 17/1/5.
//  Copyright © 2017年 tianjifou. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"
#import "PersonModel.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray*arrData;
    NSArray*typeArr;
}

@end
static int testCount = 100000;//控制所遍历数组的大小
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITableView*table = [[UITableView alloc]initWithFrame:self.view.bounds];
    table.delegate = self;
    table.dataSource = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [ self.view addSubview:table];
    typeArr = @[@"for(;;)",@"for in",@"enumerateObjectsUsingBlock",@"dispatch_apply",@"NSPredicate"];
    
    UIActivityIndicatorView*indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.center = self.view.center;
    [self.view addSubview:indicator];
    [indicator startAnimating];
    
    arrData = [[NSMutableArray alloc]init];
    for(int i = 0 ; i < testCount ; i++) {
        PersonModel*model = [[PersonModel alloc]init];
        model.age = arc4random()%100;
        model.name = [NSString stringWithFormat:@"sws%d",i];
        [arrData addObject:model];
        
        
    }
    [indicator stopAnimating];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return typeArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString*strId = @"id";
    UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:strId];
    if(!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strId];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",typeArr[indexPath.row]];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell*cell = [tableView cellForRowAtIndexPath:indexPath];
    
    TestViewController*vc = [[TestViewController alloc]init];
    vc.type = (int) indexPath.row;
    vc.arrData = arrData;
    [vc setBlock:^(NSString *str) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@,%@",typeArr[indexPath.row],str];
    }];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
