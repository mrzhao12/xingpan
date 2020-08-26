//
//  XingPanView.m
//  xingpandemo
//
//  Created by ttdios https://www.jianshu.com/u/fd9db3b2363b on 2020/8/20.
//  Copyright © 2020 ttdios https://www.jianshu.com/u/fd9db3b2363b. All rights reserved.
//    请在iphone6系列的手机上运行

#import "XingPanView.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "CommonUtil.h"

@interface XingPanView()
@property (nonatomic, strong) NSArray * xingxingArray, *xingzuoArray;

@end

@implementation XingPanView

-(instancetype) initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor lightGrayColor];
           self.xingxingArray = @[@"Q",@"W",@"E",@"R",@"K",@"T",@"Y",@"U",@"I",@"O",@"P",@"E"];
            
        //NSArray * xingzuoArray = @[@"♈",@"♉",@"♊",@"♋",@"♌",@"♍",@"♎",@"♏",@"♐",@"♑",@"♒",@"♓"];
            self.xingzuoArray = @[@"a",@"s",@"d",@"f",@"k",@"h",@"j",@"k",@"l",@"g",@"x",@"c"];
            

    }
    
    return self;
}
// 覆盖drawRect方法，你可以在此自定义绘画和动画
- (void)drawRect:(CGRect)rect{
     CGFloat myYuanXinX = self.mj_w/2; // po self.mj_w:369
        CGFloat myYuanXinY = self.mj_h/2;
        CGFloat myRadius = self.mj_w/2; // 半径：myRadius ：    184.5
        //po self.frame (origin = (x = 3, y = 188), size = (width = 369, height = 369))
//        NSLog(@":::%f",kScreenWidth); // 375      /2= 187.5
    // 画布
        CGContextRef context = UIGraphicsGetCurrentContext();
        
          //画大圆并填充颜
        CGContextSetLineWidth(context, 1);//线的宽度
        CGContextSetRGBStrokeColor(context,0.725,0.552,0,1);//画笔线的颜色
//        UIColor*tianChongColor = OIRGBA(246, 251, 186, 1);
    UIColor*tianChongColor = [UIColor colorWithRed:246 green:251 blue:186 alpha:1];
           CGContextSetFillColorWithColor(context, tianChongColor.CGColor);//填充颜色
        CGContextAddArc(context, myYuanXinX,myYuanXinY, [self.xpModel.params.maxRadius floatValue], 0, 2*M_PI, 1); //添加一个圆
     CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充
     // 外圈每个扇形
            UIFont *xingzuoFont =   [UIFont fontWithName:@"kanxingpan" size:16];
          UIFont *xingxingFont =   [UIFont fontWithName:@"kanxingpan" size:12];

        // 第二个圆 宫位
      UIColor*gongweiTianChongColor =    [UIColor colorWithRed:235 green:255 blue:255 alpha:1];
//        UIColor*gongweiTianChongColor =    OIRGBA(235, 255, 255, 1);
             CGContextSetFillColorWithColor(context, gongweiTianChongColor.CGColor);//填充颜色
    //      CGContextAddArc(context, myYuanXinX,myYuanXinY, myRadius-2-40, 0, 2*M_PI, 1); //添加一个圆
        CGContextAddArc(context, myYuanXinX,myYuanXinY, [self.xpModel.params.houseOutRadius floatValue], 0, 2*M_PI, 1);
        CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充
        // 外圈的星座和行星
        for (int i = 0; i<12; i++) {
               // 不在用圆环了，改用线
               NSDictionary *myPosition = ((TTXingPanSign *)self.xpModel.sign[i]).position;
               CGPoint aPoints[2];//坐标点
               aPoints[0] =CGPointMake([myPosition[@"x1"] floatValue], [myPosition[@"y1"] floatValue]);//坐标1
                  aPoints[1] =CGPointMake([myPosition[@"x2"] floatValue], [myPosition[@"y2"] floatValue]);//坐标2
               CGContextAddLines(context, aPoints, 2);//添加线
               CGContextSetRGBStrokeColor(context,0.568,0.576,0.482,1);//画笔线的颜色
                  CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径


               TTXingPanPosition *outCirclexingzuo = ((TTXingPanSign *)self.xpModel.sign[i]).position_sign;
              TTXingPanSign *outCirclexingzuoText = self.xpModel.sign[i];
    //             UIFont *xingzuoFont =   [UIFont systemFontOfSize:12];
               NSDictionary *xingzuoDic = @{NSFontAttributeName:xingzuoFont,NSForegroundColorAttributeName:[CommonUtil colorWithHexString:[NSString stringWithFormat:@"#%@",outCirclexingzuo.color]]};
            [outCirclexingzuoText.symbol drawAtPoint:CGPointMake([outCirclexingzuo.x floatValue], [outCirclexingzuo.y floatValue]) withAttributes:xingzuoDic];

               TTXingPanPosition *outCirclexingxing = ((TTXingPanSign *)self.xpModel.sign[i]).position_planet;
               NSDictionary *xingxingDic = @{NSFontAttributeName:xingxingFont,NSForegroundColorAttributeName:[CommonUtil colorWithHexString:[NSString stringWithFormat:@"#%@",outCirclexingxing.color]]};
            [outCirclexingxing.planet_symbol drawAtPoint:CGPointMake([outCirclexingxing.x floatValue], [outCirclexingxing.y floatValue]) withAttributes:xingxingDic];
           }


      // 宫位
        for (int i= 0; i<12; i++) {
            // 宫位的实线
            NSDictionary *myhouseOut_position = ((TTXingPanHouses *)self.xpModel.houses[i]).houseOut_position;
            NSDictionary *myhouseIn_position = ((TTXingPanHouses *)self.xpModel.houses[i]).houseIn_position;
            CGPoint aPoints[2];//坐标点
                  aPoints[1] =CGPointMake([myhouseOut_position[@"x"] floatValue], [myhouseOut_position[@"y"] floatValue]);//坐标1
                     aPoints[0] =CGPointMake([myhouseIn_position[@"x"] floatValue], [myhouseIn_position[@"y"] floatValue]);//坐标2
                  CGContextAddLines(context, aPoints, 2);//添加线
                  CGContextSetRGBStrokeColor(context,0.568,0.576,0.482,1);//画笔线的颜色
                     CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径

            //  宫位的字，1，2，3，，，，
            TTXingPanPosition *centerCircleGongWei = ((TTXingPanHouses *)self.xpModel.houses[i]).show_position;
            NSDictionary *gongweiDic = @{NSFontAttributeName:xingzuoFont,NSForegroundColorAttributeName:[CommonUtil colorWithHexString:[NSString stringWithFormat:@"#%@",centerCircleGongWei.color]]};
            [centerCircleGongWei.text drawAtPoint:CGPointMake([centerCircleGongWei.x floatValue], [centerCircleGongWei.y floatValue]) withAttributes:gongweiDic];
        }

        // 第三个圈，宫位的内圈
//        UIColor*thirdCircleTianChongColor =    OIRGBA(255, 255, 255, 1);
    UIColor*thirdCircleTianChongColor =   [UIColor colorWithRed:255 green:255 blue:255 alpha:1];
               CGContextSetFillColorWithColor(context, thirdCircleTianChongColor.CGColor);//填充颜色
    //        CGContextAddArc(context, myYuanXinX,myYuanXinY, myRadius-2-40-20, 0, 2*M_PI, 1); //添加一个圆
        CGContextAddArc(context, myYuanXinX,myYuanXinY, [self.xpModel.params.houseInRadius floatValue], 0, 2*M_PI, 1);
       CGContextSetRGBStrokeColor(context, 0.403,0.654,0.792,1);
        CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充



        //第四个圈=最内圈的：
         CGContextAddArc(context, myYuanXinX,myYuanXinY, [self.xpModel.params.planetsRadius floatValue], 0, 2*M_PI, 1);
    //      CGContextAddArc(context, myYuanXinX,myYuanXinY, myRadius-2-40-20-30, 0, 2*M_PI, 1); //添加一个圆
    //    CGContextSetRGBStrokeColor(context, 0.403,0.654,0.792,1);
        CGContextDrawPath(context, kCGPathStroke); //绘制路径 kCGPathStroke


          UIFont *intCirclexingxingFont =   [UIFont fontWithName:@"kanxingpan" size:14];
        // 最内圈上的符号/文字
        for (int i = 0; i< self.xpModel.planets.count; i++) {
            TTXingPanPlanets *xingxingText = self.xpModel.planets[i];


            TTXingPanPosition *centerCircleGongWei = ((TTXingPanPlanets *)self.xpModel.planets[i]).show_position;

            //行星延长点位置 extend_position
    //          NSDictionary *smallCircleExtend = ((TTXingPanPlanets *)self.xpModel.planets[i]).extend_position;

            NSDictionary *gongweiDic = @{NSFontAttributeName:intCirclexingxingFont,NSForegroundColorAttributeName:[CommonUtil colorWithHexString:[NSString stringWithFormat:@"#%@",centerCircleGongWei.color]]};
            [xingxingText.symbol drawAtPoint:CGPointMake([centerCircleGongWei.x floatValue], [centerCircleGongWei.y floatValue]) withAttributes:gongweiDic];


        }

          //3圈到圆点的连线
            for (int i= 0; i<12; i++) {
                NSDictionary *myhouseIn_position = ((TTXingPanHouses *)self.xpModel.houses[i]).houseIn_position;

              // 内宫位圈上的等分点到圆点的连线
                         CGPoint IntHousePoints[2];//坐标点
                         IntHousePoints[1] =CGPointMake([myhouseIn_position[@"x"] floatValue], [myhouseIn_position[@"y"] floatValue]);//坐标1
                         IntHousePoints[0] =CGPointMake(myYuanXinX, myYuanXinY);//坐标2
                         CGContextAddLines(context, IntHousePoints, 2);//添加线
                //// 虚线
    //            CGFloat lengths[] = {10,10};
    //                CGContextSetLineDash(context, 0, lengths, 2);
    //                CGContextMoveToPoint(context, myYuanXinX, myYuanXinY);
    //                CGContextAddLineToPoint(context,[myhouseIn_position[@"x"] floatValue],[myhouseIn_position[@"y"] floatValue]);
                ////

                         CGContextSetRGBStrokeColor(context,0.568,0.576,0.482,1);//画笔线的颜色
                            CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径

            }
            
    /////////////////////////////////////
        
        
    //    //  最内圈的连线
    //    for (int i= 0; i<self.xpModel.planetsLine.count; i++) {
    //
    //
    //
    //
    //
    //
    //
    //        NSDictionary *myplanetA = ((TTXingPanPlanetsLine *)self.xpModel.planetsLine[i]).planetA;
    //
    //              NSDictionary *myplanetB = ((TTXingPanPlanetsLine *)self.xpModel.planetsLine[i]).planetB;
    //
    //              CGPoint aPoints[2];//坐标点
    //                    aPoints[1] =CGPointMake([myplanetA[@"x"] floatValue], [myplanetA[@"y"] floatValue]);//坐标1
    //                       aPoints[0] =CGPointMake([myplanetB[@"x"] floatValue], [myplanetB[@"y"] floatValue]);//坐标2
    ////                    CGContextAddLines(context, aPoints, 2);//添加线
    //         CGFloat lengths[] = {10,10};
    //        CGContextSetLineDash(context, 0, lengths, 2);
    //        CGContextMoveToPoint(context, [myplanetB[@"x"] floatValue], [myplanetB[@"y"] floatValue]);
    //
    //        CGContextAddLineToPoint(context, [myplanetA[@"x"] floatValue],[myplanetA[@"y"] floatValue]);
    //                    CGContextSetRGBStrokeColor(context,0.568,0.576,0.482,1);//画笔线的颜色
    //                       CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
    //
    //
    //    }
        
    // ASC 和mc
    //    NSMutableArray *ASC_MC_list = [NSMutableArray array];
               CGFloat x1, y1,x2, y2, x3,y3, x4,y4;
        for (int i = 0; i<16; i++) {
            //TTXingPanPosition
             NSDictionary *extend_position = ((TTXingPanPlanets *)self.xpModel.planets[i]).extend_position;
            TTXingPanPosition *ASC_MC = ((TTXingPanPlanets *)self.xpModel.planets[i]).show_position;

           
            NSLog(@"ASC_MC.text::%@",ASC_MC.text);
            if ([ASC_MC.text isEqualToString:@"Asc"]) {
                x1 = [extend_position[@"x"] floatValue];
                y1 = [extend_position[@"y"] floatValue];
            }else if ([ASC_MC.text isEqualToString:@"Des"]){
                x2 = [extend_position[@"x"] floatValue];
                y2 = [extend_position[@"y"] floatValue];
                
            }else if ([ASC_MC.text isEqualToString:@"IC"]){
                x3 = [extend_position[@"x"] floatValue];
                y3 = [extend_position[@"y"] floatValue];
                
            }else if ([ASC_MC.text isEqualToString:@"MC"]){
                x4 = [extend_position[@"x"] floatValue];
                y4 = [extend_position[@"y"] floatValue];
                
            }
        }
        
      
        
                              CGPoint aPoints[2];//坐标点
                                    aPoints[1] =CGPointMake(x1, y1);//坐标1
                                       aPoints[0] =CGPointMake(x2, y2);//坐标2
                                    CGContextAddLines(context, aPoints, 2);//添加线
    //                     CGFloat lengths[] = {10,10};
    //                    CGContextSetLineDash(context, 0, lengths, 2);
    //                    CGContextMoveToPoint(context, [myplanetB[@"x"] floatValue], [myplanetB[@"y"] floatValue]);
        
    //                    CGContextAddLineToPoint(context, [myplanetA[@"x"] floatValue],[myplanetA[@"y"] floatValue]);
                                    CGContextSetRGBStrokeColor(context,0.568,0.576,0.482,1);//画笔线的颜色
                                       CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
        
        
             CGPoint aaPoints[2];//坐标点
                                        aaPoints[1] =CGPointMake(x3, y3);//坐标1
                                           aaPoints[0] =CGPointMake(x4, y4);//坐标2
                                        CGContextAddLines(context, aaPoints, 2);//添加线

                                        CGContextSetRGBStrokeColor(context,0.568,0.576,0.482,1);//画笔线的颜色
                                           CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
            
        
        
        
        
        
        for (int i = 0;i<self.xpModel.planetsLine.count;i++) {

            NSDictionary *myplanetA = ((TTXingPanPlanetsLine *)self.xpModel.planetsLine[i]).planetA;
                          NSDictionary *myplanetB = ((TTXingPanPlanetsLine *)self.xpModel.planetsLine[i]).planetB;

                          CGPoint aPoints[2];//坐标点
                                aPoints[1] =CGPointMake([myplanetA[@"x"] floatValue], [myplanetA[@"y"] floatValue]);//坐标1
                                   aPoints[0] =CGPointMake([myplanetB[@"x"] floatValue], [myplanetB[@"y"] floatValue]);//坐标2
                                CGContextAddLines(context, aPoints, 2);//添加线

            CGContextSetStrokeColorWithColor(context,[CommonUtil colorWithHexString:[NSString stringWithFormat:@"#%@",((TTXingPanPlanetsLine *)self.xpModel.planetsLine[i]).color]].CGColor);
            
    //                        CGContextSetRGBStrokeColor(context,0.568,0.576,0.482,1);//画笔线的颜色
                                   CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
        }
        
    
    
    
    
    
    
    
    
    
    
    
    return;
    
//    CGFloat myYuanXinX = self.mj_w/2;
//    CGFloat myYuanXinY = self.mj_h/2;
//    CGFloat myRadius = self.mj_w/2; // 半径：myRadius ：    184.5
//    //po self.frame (origin = (x = 3, y = 188), size = (width = 369, height = 369))
////    NSLog(@":::%f",kScreenWidth); // 375      /2= 187.5
//// 画布
//    CGContextRef context = UIGraphicsGetCurrentContext();
//
//      //画大圆并填充颜
//       CGContextSetLineWidth(context, 1);//线的宽度
//    CGContextSetRGBStrokeColor(context,0.725,0.552,0,1);//画笔线的颜色
////    UIColor*tianChongColor = OIRGBA(246, 251, 186, 1);
//      UIColor*tianChongColor = [UIColor colorWithRed:246 green:251 blue:186 alpha:1];
//       CGContextSetFillColorWithColor(context, tianChongColor.CGColor);//填充颜色
//    CGContextAddArc(context, myYuanXinX,myYuanXinY, myRadius-2, 0, 2*M_PI, 1); //添加一个圆
// CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充
// // 外圈每个扇形
////    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
////       textStyle.lineBreakMode = NSLineBreakByTruncatingTail;
////     UIColor *xingzuoColor = [UIColor blackColor];
////        UIFont *xingzuoFont =   [UIFont fontWithName:@"kanxingpan" size:26];
//
//      UIFont *xingzuoFont =   [UIFont systemFontOfSize:16];
//    NSDictionary *atDic = @{NSFontAttributeName:xingzuoFont};
//    for (int i = 0; i<12; i++) {
//        CGFloat startAngle = M_PI +i*(M_PI/6);
//        CGFloat endAngle = M_PI*5/6+i*(M_PI/6);
//        // 不在用圆环了，改用线
////        CGContextMoveToPoint(context, myYuanXinX, myYuanXinY);
////           CGContextAddArc(context, myYuanXinX, myYuanXinY,myRadius-2,  startAngle, endAngle, 1);
////        UIColor*aColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0];
////     CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色
////        CGContextSetRGBStrokeColor(context,0.568,0.576,0.482,1);//画笔线的颜色
////        CGContextClosePath(context);
////           CGContextDrawPath(context, kCGPathFillStroke); //绘制路径
////        CGPoint outCircleStart(self.xpModel.si)
//        NSDictionary *myPosition = ((TTXingPanSign *)self.xpModel.sign[i]).position;
//        CGPoint aPoints[2];//坐标点
//        aPoints[0] =CGPointMake([myPosition[@"x1"] floatValue], [myPosition[@"y1"] floatValue]);//坐标1
//           aPoints[1] =CGPointMake([myPosition[@"x2"] floatValue], [myPosition[@"y2"] floatValue]);//坐标2
//        CGContextAddLines(context, aPoints, 2);//添加线
//        CGContextSetRGBStrokeColor(context,0.568,0.576,0.482,1);//画笔线的颜色
//           CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
//
//
//        TTXingPanPosition *outCirclexingzuo = ((TTXingPanSign *)self.xpModel.sign[i]).position_sign;
////        [outCirclexingzuo.text drawAtPoint:CGPointMake([outCirclexingzuo.x floatValue], [outCirclexingzuo.y floatValue]) withAttributes:atDic];
//        UIFont *xingzuoFont =   [UIFont systemFontOfSize:16];
//        NSDictionary *xingzuoDic = @{NSFontAttributeName:xingzuoFont,NSForegroundColorAttributeName:[CommonUtil colorWithHexString:[NSString stringWithFormat:@"#%@",outCirclexingzuo.color]]};
//
//        [outCirclexingzuo.text drawInRect:CGRectMake([outCirclexingzuo.x floatValue], [outCirclexingzuo.y floatValue], 30, 20) withAttributes:xingzuoDic];
//
//        TTXingPanPosition *outCirclexingxing = ((TTXingPanSign *)self.xpModel.sign[i]).position_planet;
//        NSDictionary *xingxingDic = @{NSFontAttributeName:xingzuoFont,NSForegroundColorAttributeName:[CommonUtil colorWithHexString:[NSString stringWithFormat:@"#%@",outCirclexingxing.color]]};
//        [outCirclexingxing.text drawInRect:CGRectMake([outCirclexingxing.x floatValue], [outCirclexingxing.y floatValue], 30, 20) withAttributes:xingxingDic];
//
////        CGFloat xingzuoRadius = myRadius;
////        if (i<3) {
////            xingzuoRadius = myRadius-10;
////        }else if(3<=i && i<=6){
////            xingzuoRadius = myRadius-22;
////        }else if (6<i && i<9){
////            xingzuoRadius = myRadius-10;
////        }else if (9<=i && i<12){
////            xingzuoRadius = myRadius;
////        }
////        [self.xingzuoArray[i] drawAtPoint:CGPointMake(myRadius-(xingzuoRadius)*cos(i*(M_PI/6)),myRadius+(xingzuoRadius)*sin(i*(M_PI/6))) withAttributes:atDic];
//    }
//
////    for (int i =0; i<12; i++) {
////        TTXingPanPosition *outCirclexingxing = ((TTXingPanSign *)self.xpModel.sign[i]).position_planet;
////               NSDictionary *xingxingDic = @{NSFontAttributeName:xingzuoFont,NSForegroundColorAttributeName:[CommonUtil colorWithHexString:[NSString stringWithFormat:@"#%@",outCirclexingxing.color]]};
////              [outCirclexingxing.text drawInRect:CGRectMake([outCirclexingzuo.x floatValue], [outCirclexingzuo.y floatValue], 30, 20) withAttributes:xingxingDic];
////    }
//
//    // 第二个圆 宫位
//    UIColor*gongweiTianChongColor =   [UIColor colorWithRed:235 green:255 blue:255 alpha:1];// OIRGBA(235, 255, 255, 1);
//         CGContextSetFillColorWithColor(context, gongweiTianChongColor.CGColor);//填充颜色
////      CGContextAddArc(context, myYuanXinX,myYuanXinY, myRadius-2-40, 0, 2*M_PI, 1); //添加一个圆
//    CGContextAddArc(context, myYuanXinX,myYuanXinY, [self.xpModel.params.houseOutRadius floatValue], 0, 2*M_PI, 1);
//    CGContextDrawPath(context, kCGPathFillStroke); //绘制路径加填充
//  // 宫位的每个扇形
//    UIFont *gongWeiFont =   [UIFont systemFontOfSize:18];
//
//        CGFloat gongWeiMyRadius = self.mj_w/2-40;
////    myRadius = self.mj_w/2;
//    for (int i= 0; i<12; i++) {
//        CGFloat startAngle = M_PI +i*(M_PI/6);
//        CGFloat endAngle = M_PI*5/6+i*(M_PI/6);
////        CGContextMoveToPoint(context, myYuanXinX, myYuanXinY);
////        CGContextAddArc(context, myYuanXinX, myYuanXinY,myRadius-2-40,  startAngle, endAngle, 1);
////        UIColor*aColor = OIRGBA(235, 255, 255, 1);
////        CGContextSetFillColorWithColor(context, aColor.CGColor);//填充颜色 //OIRGBA(235, 255, 255, 1);
////        CGContextSetRGBStrokeColor(context,0.403,0.654,0.792,1);//画笔线的颜色 //OIRGBA(103, 167, 202, 1);
////        CGContextClosePath(context);
////        CGContextDrawPath(context, kCGPathFillStroke); //绘制路径
//
//
//        /*
//         model.houseIn_position = DealWithDictionary(dict[@"houseIn_position"]);
//         model.houseOut_position = DealWithDictionary(dict[@"houseOut_position"]);
//         */
//        NSDictionary *myhouseOut_position = ((TTXingPanHouses *)self.xpModel.houses[i]).houseOut_position;
//
//        NSDictionary *myhouseIn_position = ((TTXingPanHouses *)self.xpModel.houses[i]).houseIn_position;
//
//        CGPoint aPoints[2];//坐标点
//              aPoints[1] =CGPointMake([myhouseOut_position[@"x"] floatValue], [myhouseOut_position[@"y"] floatValue]);//坐标1
//                 aPoints[0] =CGPointMake([myhouseIn_position[@"x"] floatValue], [myhouseIn_position[@"y"] floatValue]);//坐标2
//              CGContextAddLines(context, aPoints, 2);//添加线
//              CGContextSetRGBStrokeColor(context,0.568,0.576,0.482,1);//画笔线的颜色
//                 CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
//
//        // show_position 宫位的字，1，2，3，，，，
//        TTXingPanPosition *centerCircleGongWei = ((TTXingPanHouses *)self.xpModel.houses[i]).show_position;
//
//               NSDictionary *gongweiDic = @{NSFontAttributeName:xingzuoFont,NSForegroundColorAttributeName:[CommonUtil colorWithHexString:[NSString stringWithFormat:@"#%@",centerCircleGongWei.color]]};
//               [centerCircleGongWei.text drawInRect:CGRectMake([centerCircleGongWei.x floatValue], [centerCircleGongWei.y floatValue], 30, 20) withAttributes:gongweiDic];
//
//
//    }
//
//    // 宫位上的数字
////    for (int i = 0; i<12; i++) {
////        CGFloat gongweiRadius = myRadius-2-40;
////               if (i<3) {
////                   gongweiRadius = myRadius-2-40-10;
////               }else if(3<=i && i<=6){
////                 gongweiRadius = myRadius-2-40-22;
////               }else if (6<i && i<9){
////                 gongweiRadius = myRadius-2-40-10;
////               }else if (9<=i && i<12){
////              gongweiRadius = myRadius-2-40;
////               }
////        NSDictionary *gongWeiDic = @{NSFontAttributeName:gongWeiFont,NSForegroundColorAttributeName:OIRandomColor};
////            [[NSString stringWithFormat:@"%ld",i+1] drawAtPoint:CGPointMake(myRadius-(gongweiRadius)*cos(i*(M_PI/6)),myRadius+(gongweiRadius)*sin(i*(M_PI/6))) withAttributes:gongWeiDic];
//
////    }
//
//    // 第三个圈，宫位的内圈
////    UIColor*gongweiTianChongColor =    OIRGBA(235, 255, 255, 1);
////           CGContextSetFillColorWithColor(context, gongweiTianChongColor.CGColor);//填充颜色
////        CGContextAddArc(context, myYuanXinX,myYuanXinY, myRadius-2-40-20, 0, 2*M_PI, 1); //添加一个圆
//    CGContextAddArc(context, myYuanXinX,myYuanXinY, [self.xpModel.params.houseInRadius floatValue], 0, 2*M_PI, 1);
//    CGContextSetRGBStrokeColor(context, 0.403,0.654,0.792,1);
//    CGContextDrawPath(context, kCGPathStroke); //绘制路径加填充
//
//
//
//
//
//
//
//
//
//    //第四个圈=最内圈的：
//     CGContextAddArc(context, myYuanXinX,myYuanXinY, [self.xpModel.params.planetsRadius floatValue], 0, 2*M_PI, 1);
////      CGContextAddArc(context, myYuanXinX,myYuanXinY, myRadius-2-40-20-30, 0, 2*M_PI, 1); //添加一个圆
//    CGContextSetRGBStrokeColor(context, 0.403,0.654,0.792,1);
//    CGContextDrawPath(context, kCGPathStroke); //绘制路径加填充
//
//    for (int i = 0; i< 12; i++) {
//        TTXingPanPosition *centerCircleGongWei = ((TTXingPanPlanets *)self.xpModel.planets[i]).position;
//        NSDictionary *gongweiDic = @{NSFontAttributeName:xingzuoFont,NSForegroundColorAttributeName:[CommonUtil colorWithHexString:[NSString stringWithFormat:@"#%@",centerCircleGongWei.color]]};
//        [centerCircleGongWei.text drawInRect:CGRectMake([centerCircleGongWei.x floatValue], [centerCircleGongWei.y floatValue], 30, 20) withAttributes:gongweiDic];
//    }
//
//

}



@end
