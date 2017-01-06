//
//  TestViewController.h
//  SWSErgodicArrayTest
//
//  Created by 天机否 on 17/1/5.
//  Copyright © 2017年 tianjifou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestViewController : UIViewController

@property(nonatomic,assign)int type;
@property(nonatomic,copy)void(^block)(NSString*str);
@property(nonatomic,strong)NSMutableArray*arrData;
@end
