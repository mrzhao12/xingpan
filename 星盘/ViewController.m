//
//  ViewController.m
//  星盘
//
//  Created by ttdios https://www.jianshu.com/u/fd9db3b2363b on 2020/8/24.
//  Copyright © 2020 ttdios https://www.jianshu.com/u/fd9db3b2363b. All rights reserved.
//

#import "ViewController.h"
#import "XingPanView.h"
#import "Masonry.h"
#import "XingPanModel.h"
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@interface ViewController ()
@property (nonatomic, strong) XingPanView *XPView;
@property (nonatomic, strong) XingPanModel *xingpanModel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"swetest" ofType:@"json"];
 NSData *data = [NSData dataWithContentsOfFile:jsonPath];
 NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];

  NSLog(@"星盘数据：%@",result);
  self.xingpanModel = [XingPanModel objectWithDictionary:result];
  
  

     [self.view addSubview:self.XPView];
       
       [self.XPView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerX.mas_equalTo(self.view.mas_centerX);
           make.centerY.mas_equalTo(self.view.mas_centerY).with.offset(64);
           make.size.mas_equalTo(CGSizeMake(kScreenWidth-6, kScreenWidth-6));
       }];
       self.XPView.xpModel = self.xingpanModel;
       
       
}
-(XingPanView *)XPView{
    if (!_XPView) {
        _XPView = [[XingPanView alloc] init];
    }
    return _XPView;
}

/*
  以下是控件堆起来的，不要使用此方法
     [self.view addSubview:self.myOutCircle];
     [self.myOutCircle mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerX.mas_equalTo(self.view.mas_centerX);
         make.centerY.mas_equalTo(self.view.mas_centerY).with.offset(kNavHeight);
         make.size.mas_equalTo(CGSizeMake(kScreenWidth-6, kScreenWidth-6));
     }];
     
     
     
     
 //      // 添加外圈的刻度
 //        _scaleNumber = 12;
 //    //    _start = M_PI*5/6+M_PI/12;
 //         _start = 0;
 //         _end = 2*M_PI;
 //    //    _end = M_PI/6-M_PI/12; // 30度
 //    //    angle = M_PI*4/3-M_PI/12*2;//M_PI+M_PI/6+M_PI/6-M_PI/12*2  计算总弧度
 //         angle = 2*M_PI;
 //        perAngle = angle/(_scaleNumber-1);//根据数量计算每个刻度占的弧度
 //
 //        for (int i = 0; i<12; i++) {
 //            CGFloat startAngel = _start+perAngle*i;
 //            CGFloat endAngel = startAngel + perAngle/30;//刻度线的宽度
 //            UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.mj_centerX, self.view.mj_centerY+kNavHeight-20) radius:(kScreenWidth-12)/2 startAngle:startAngel endAngle:endAngel clockwise:YES];
 //                CAShapeLayer *layer2 = [CAShapeLayer layer];
 //              layer2.strokeColor = [UIColor redColor].CGColor;
 //         layer2.lineWidth =  30;
 //            layer2.path = path2.CGPath;
 //            layer2.fillColor = [UIColor purpleColor].CGColor;
 //            [self.view.layer addSublayer:layer2];
 //        }

     
     
     
     //☉、☽、☿、♀、⊕／♁、♂、♃、♄／ħ、♅、♆／Ψ、♇
 //NSArray * xingxingArray = @[@"☉",@"☽",@"☿",@"♀",@"♁",@"♂",@"♃",@"ħ",@"♅",@"Ψ",@"♇",@"☿"];
     self.xingxingArray = @[@"Q",@"W",@"E",@"R",@"K",@"T",@"Y",@"U",@"I",@"O",@"P",@"E"];
     
 //NSArray * xingzuoArray = @[@"♈",@"♉",@"♊",@"♋",@"♌",@"♍",@"♎",@"♏",@"♐",@"♑",@"♒",@"♓"];
     self.xingzuoArray = @[@"a",@"s",@"d",@"f",@"k",@"h",@"j",@"k",@"l",@"g",@"x",@"c"];
     
     for (int i = 0; i < 12; i ++) {
             UILabel *xingzuoBIGLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10,   M_PI*(kScreenWidth-12)/12, (kScreenWidth-12)/2)];
           xingzuoBIGLab.layer.anchorPoint = CGPointMake(0.5, 1.4); // --------
 //        xingzuoBIGLab.layer.anchorPoint = CGPointMake(0.5, 1);
           xingzuoBIGLab.center = CGPointMake((kScreenWidth-12)/2,  (kScreenWidth-12)/2);
           CGFloat angle = M_PI * 2 / 12 * i;
           xingzuoBIGLab.textAlignment = NSTextAlignmentCenter;
           xingzuoBIGLab.font = [UIFont fontWithName:@"kanxingpan" size:26];
           // xingzuoBIGLab.text = @"白";
         xingzuoBIGLab.text = [NSString stringWithFormat:@"%@", self.xingzuoArray[i]];
           xingzuoBIGLab.transform = CGAffineTransformMakeRotation(angle);
 //          if (i == 0) {
 //              xingzuoBIGLab.backgroundColor = [UIColor lightGrayColor];
 //          }
 //          if (i == 1) {
 //              xingzuoBIGLab.backgroundColor = [UIColor yellowColor];
 //          }
         xingzuoBIGLab.userInteractionEnabled = YES;
         xingzuoBIGLab.tag = 1000+i;
         UITapGestureRecognizer *xingzuoBIGTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(xingzuoBIGLabGesture:)];
             [xingzuoBIGLab addGestureRecognizer:xingzuoBIGTap];
              [self.myOutCircle addSubview:xingzuoBIGLab];
           
           UILabel *xingxingLab = [[UILabel alloc] initWithFrame:CGRectMake(M_PI*(kScreenWidth-12)/12-50,(kScreenWidth-12)/4 , 30, 30)];
           xingxingLab.font =[UIFont fontWithName:@"kanxingpan" size:18];
           xingxingLab.text = [NSString stringWithFormat:@"%@", self.xingxingArray[i]];
           xingxingLab.layer.anchorPoint = CGPointMake(0, 1);
 //          xingxingLab.backgroundColor = [UIColor grayColor];
           xingxingLab.textAlignment = NSTextAlignmentCenter;
         xingxingLab.userInteractionEnabled = YES;
         xingxingLab.tag = 2000+i;
         UITapGestureRecognizer *xingxingTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(xingxingLabGesture:)];
         [xingxingLab addGestureRecognizer:xingxingTap];
           [xingzuoBIGLab addSubview:xingxingLab];
         
         UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(M_PI*(kScreenWidth-12)/12-1, 0, 1, (kScreenWidth-12)/2)];

         lineView.backgroundColor = OIRGBA(145, 147, 123, 1);
         lineView.layer.anchorPoint = CGPointMake(0.5, 1.7);
         lineView.center = CGPointMake((kScreenWidth-12)/2,  (kScreenWidth-12)/2);

           CGFloat lineViewAngle = M_PI * 2 / 12 * i+M_PI * 2 / 24;
           lineView.transform = CGAffineTransformMakeRotation(lineViewAngle);
         [self.myOutCircle addSubview:lineView];
     }
     
     
     [self.myOutCircle addSubview:self.myCenterCircle];
            [self.myCenterCircle mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.myOutCircle.mas_centerX);
                make.centerY.mas_equalTo(self.myOutCircle.mas_centerY);
                 make.size.mas_equalTo(CGSizeMake(kScreenWidth-6-80, kScreenWidth-6-80));
            }];
     
          // 中圈的所在的label
 //            _scaleNumber = 12;
 //        //    _start = M_PI*5/6+M_PI/12;
 //             _start = 0;
 //             _end = 2*M_PI;
 //        //    _end = M_PI/6-M_PI/12; // 30度
 //        //    angle = M_PI*4/3-M_PI/12*2;//M_PI+M_PI/6+M_PI/6-M_PI/12*2  计算总弧度
 //             angle = 2*M_PI;
 //            perAngle = angle/(_scaleNumber-1);//根据数量计算每个刻度占的弧度
 //    //
 //            for (int i = 0; i<12; i++) {
 //                CGFloat startAngel = _start+perAngle*i;
 //                CGFloat endAngel = startAngel + perAngle/30;//刻度线的宽度
 //                UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.view.mj_centerX, self.view.mj_centerY+kNavHeight-20) radius:(kScreenWidth-12)/2 startAngle:startAngel endAngle:endAngel clockwise:YES];
 //                    CAShapeLayer *layer2 = [CAShapeLayer layer];
 //                  layer2.strokeColor = [UIColor redColor].CGColor;
 //             layer2.lineWidth =  30;
 //                layer2.path = path2.CGPath;
 //                layer2.fillColor = [UIColor purpleColor].CGColor;
 //                [self.view.layer addSublayer:layer2];
 //            }

     //  _myCenterCircle宽：(kScreenWidth-6-80);
     for (int i = 0; i<12; i++) {
          UILabel *gongweiLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10,   M_PI*(kScreenWidth-6-80)/12, (kScreenWidth-6-80)/2)];

         gongweiLab.layer.anchorPoint = CGPointMake(0.5, 1.42); // --------
 //                xingzuoBIGLab.layer.anchorPoint = CGPointMake(0.5, 1);
 //        gongweiLab.center = self.myCenterCircle.center;
                   gongweiLab.center = CGPointMake((kScreenWidth-6-80)/2,  (kScreenWidth-6-80)/2);
                   CGFloat angle = -M_PI * 2 / 12 * (i+4);
                   gongweiLab.textAlignment = NSTextAlignmentCenter;
         gongweiLab.font = [UIFont systemFontOfSize:18];
 //        gongweiLab.backgroundColor =  OIRGBA(235, 255, 255, 1);
                 gongweiLab.text = [NSString stringWithFormat:@"%ld", i+1];
         gongweiLab.textColor = OIRandomColor;
         gongweiLab.transform = CGAffineTransformMakeRotation(angle);
 //                  if (i == 0) {
 //                      gongweiLab.backgroundColor = [UIColor lightGrayColor];
 //                  }
 //                  if (i == 1) {
 //                      gongweiLab.backgroundColor = [UIColor yellowColor];
 //                  }
         gongweiLab.userInteractionEnabled = YES;
         gongweiLab.tag = 3000+i;
         UITapGestureRecognizer *gongweiLabTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gongweiLabGesture:)];
         [gongweiLab addGestureRecognizer:gongweiLabTap];
         [self.myCenterCircle addSubview:gongweiLab];
         UIView *gongweiLineView = [[UIView alloc] initWithFrame:CGRectMake(M_PI*(kScreenWidth-6-80)/12-1, 0, 1, (kScreenWidth-6-80)/2)];
         gongweiLineView.backgroundColor = OIRGBA(103, 167, 202, 1);
 //        gongweiLineView.layer.anchorPoint = CGPointMake(0.5, 1.7);
            gongweiLineView.layer.anchorPoint = CGPointMake(0.5, 1);
         gongweiLineView.center = CGPointMake((kScreenWidth-6-80)/2,  (kScreenWidth-6-80)/2);
         CGFloat lineViewAngle = M_PI * 2 / 12 * i+M_PI * 2 / 24;
         gongweiLineView.transform = CGAffineTransformMakeRotation(lineViewAngle);
         [self.myCenterCircle addSubview:gongweiLineView];
         [self.gongweiLineArray addObject:gongweiLineView]; // 由于下面添加内圈会覆盖住此直线，所以先添加进入数组，然后，在添加内圈后遍历此数组，重新把它bringSubviewToFront到中圈上，就呈现了

     }
          
     
     
     // 画水平线，Asc
     UIBezierPath *AscLine = [UIBezierPath bezierPath];
       CGFloat dashLineConfig[] = {8.0, 4.0};
     [AscLine setLineDash:dashLineConfig count:2 phase:0];
     [AscLine moveToPoint:CGPointMake(0, self.view.mj_centerY+kNavHeight/2+8)];
     [AscLine addLineToPoint:CGPointMake(kScreenWidth, self.view.mj_centerY+kNavHeight/2+8)];
     [AscLine stroke]; ////Draws line 根据坐标点连线
     // 渲染
     CAShapeLayer *AscShapeLayer  = [CAShapeLayer layer];
        AscShapeLayer.path  =AscLine.CGPath;
     AscShapeLayer.lineWidth = 1;
     AscShapeLayer.strokeColor = OIRGBA(0, 119, 178, 1).CGColor;
     [self.view.layer addSublayer:AscShapeLayer];
     
     // 画垂直的稍微倾斜的 MC 线
   UIBezierPath *MCLine = [UIBezierPath bezierPath];
       CGFloat MCdashLineConfig[] = {8.0, 4.0};
     [MCLine setLineDash:MCdashLineConfig count:2 phase:0];
     CGFloat startMCY = self.view.mj_centerY+kNavHeight/2-(kScreenWidth-12)/2-(self.view.mj_centerY+kNavHeight/2-(kScreenWidth-12)/2-(kScreenWidth-6)/2*cos(M_PI/12));
     [MCLine moveToPoint:CGPointMake(self.view.mj_centerX-((kScreenWidth-6)/2*sin(M_PI/12)), startMCY)];
    
     CGFloat endMCX  = self.view.mj_centerX+(kScreenWidth-6)/2*sin(M_PI/12);
     CGFloat endMCY = self.view.mj_centerY+kNavHeight/2+(kScreenWidth-12)/2+(self.view.mj_centerY+kNavHeight/2-(kScreenWidth-12)/2-(kScreenWidth-6)/2*cos(M_PI/12));
     
 //    [MCLine addLineToPoint:CGPointMake(self.view.mj_centerX, self.view.mj_centerY+kNavHeight/2+(kScreenWidth-12)/2)];
       [MCLine addLineToPoint:CGPointMake(endMCX, endMCY)];
     
     [MCLine stroke]; ////Draws line 根据坐标点连线

     // 渲染
     CAShapeLayer *MCShapeLayer  = [CAShapeLayer layer];
        MCShapeLayer.path  =MCLine.CGPath;
     MCShapeLayer.lineWidth = 1;
     MCShapeLayer.strokeColor = OIRGBA(0, 119, 178, 1).CGColor;
     [self.view.layer addSublayer:MCShapeLayer];

     // 添加内圈
     [self.myCenterCircle addSubview:self.myInternalCircle];
              [self.myInternalCircle mas_makeConstraints:^(MASConstraintMaker *make) {
                  make.centerX.mas_equalTo(self.myCenterCircle.mas_centerX);
                  make.centerY.mas_equalTo(self.myCenterCircle.mas_centerY);
                 make.size.mas_equalTo(CGSizeMake(kScreenWidth-6-80-40, kScreenWidth-6-80-40));
              }];
     
     
     for (UIView *gongweiLineView in self.gongweiLineArray) {
     [self.myCenterCircle bringSubviewToFront:gongweiLineView]; //[A bringSubviewToFront:B]; B视图在A视图上面
     }
     
     UILabel *Asc = [[UILabel alloc] init];
     Asc.text = @"Asc";
     Asc.textColor = [UIColor redColor];
     Asc.font = [UIFont systemFontOfSize:16];
     [self.view addSubview:Asc];
     [Asc mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerY.equalTo(self.view.mas_centerY).with.offset(kNavHeight/2+30);

         make.left.mas_equalTo(3+40+20+15);
 //        make.size.mas_equalTo(CGSizeMake(30, 25));
     }];

     
     ////////
 //    self.hudIsShowing = YES;
 //    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
 //    self.HUD.labelText = @"请稍候...";
 //    [self.view addSubview:self.HUD];
 //    [self.HUD show:YES];
 //
 //    [self.brQuestionAnswerGetListRequest brQuestionAnswerGetList:kLimit min_id:@"0"];
 //    [self addRefresh];
 //    [self addNotification];
 //    [self setTableHeaderViewWhenCommonUser];
 //    self.needRefreshBanner = YES;
 //    //产品子入口
 //    [self.brEntryRequest brProductEntrance:@"askTarot_ios"];
    
     NSLog(@":::☉、☽、☿、♀、⊕／♁、♂、♃、♄／ħ、♅、♆／Ψ、♇----♈ ♉ ♊ ♋ ♌ ♍ ♎ ♏ ♐ ♑ ♒ ♓");
     NSLog(@":::%@",[self getAstroWithMonth:3 day:12]);
 
 */
@end
