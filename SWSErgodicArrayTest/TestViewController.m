//
//  TestViewController.m
//  SWSErgodicArrayTest
//
//  Created by 天机否 on 17/1/5.
//  Copyright © 2017年 tianjifou. All rights reserved.
//

#import "TestViewController.h"
#import "PersonModel.h"
#import <mach/mach_time.h>
@interface TestViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)startBtn:(UIButton *)sender {
    uint64_t begin = mach_absolute_time();
    switch (self.type) {
            case 0:
            [self test ];
            break;
            case 1:
            [self test1 ];
            break;
            case 2:
            [self test2 ];
            break;
            case 3:
            [self test3 ];
            break;
            case 4:
            [self test4 ];
            break;
            
        default:
            break;
    }
    uint64_t end = mach_absolute_time();
    _timeLabel.text = [NSString stringWithFormat:@"用时%.9fs",pow(10,-9)*(end - begin)];
}

-(void)test {
    for (int i = 0 ; i < self.arrData.count ; i ++) {
       PersonModel *model = self.arrData[i];
        NSLog(@"==========%@",model.name);
        
    }
}
-(void)test1 {
    int i = 0 ;
    for ( PersonModel * model in self.arrData) {
        i++;
         NSLog(@"==========%@",model.name);
    }
}
-(void)test2 {
    [self.arrData enumerateObjectsUsingBlock:^(PersonModel* model, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"==========%@",model.name);
    }];
}
-(void)test3 {
    
    dispatch_apply(self.arrData.count, dispatch_get_global_queue(0, 0), ^(size_t i) {
           PersonModel *model = self.arrData[i];
         NSLog(@"==========%@",model.name);
    });
}
-(void)test4 {
    NSPredicate*predicate = [NSPredicate predicateWithFormat:@"name == 'sws1000'"];
    NSMutableArray*arr = [self.arrData mutableCopy];
    [arr filterUsingPredicate:predicate];
    PersonModel*model = self.arrData[0];
    NSLog(@"===============%@",model.name);
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.block) {
        self.block(_timeLabel.text);
    }
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
