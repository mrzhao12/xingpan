//
//  XingPanModel.m
//  问问塔罗
//
//  Created by ttdios https://www.jianshu.com/u/fd9db3b2363b on 2020/8/24.
//

#import "XingPanModel.h"
//输出是obj对象 (过滤空对象)
#define DealWithJSONValue(obj)          (obj != [NSNull null] && obj!=nil) ? obj:nil

//输出是Sting   (如果被处理的不是Sting对象会转成String)
#define DealWithString(sting)           (![sting isKindOfClass:[NSNull class]] && sting!=nil) ? [NSString stringWithFormat:@"%@",sting]:@""

//输出是Array 或者 nil  (如果被处理的不是Array对象返回nil)
#define DealWithArray(array)            ([array isKindOfClass:[NSArray class]]) ? array:nil

//输出是Dictionary 或者 nil  (如果被处理的不是Dictionary对象返回nil)
#define DealWithDictionary(dict)        ([dict isKindOfClass:[NSDictionary class]]) ? dict:nil


@implementation TTXingPanParams
+(instancetype)objectWithDictionary:(NSDictionary *)dict{
    TTXingPanParams *model = [[TTXingPanParams alloc] init];

    
    model.date = DealWithString(dict[@"date"]);
    model.radius = DealWithString(dict[@"radius"]);
    model.maxRadius = DealWithString(dict[@"maxRadius"]);
    model.houseOutRadius = DealWithString(dict[@"houseOutRadius"]);
    model.houseInRadius = DealWithString(dict[@"houseInRadius"]);
    model.planetsRadius = DealWithString(dict[@"planetsRadius"]);
    model.planetsTextRadius = DealWithString(dict[@"planetsTextRadius"]);
    model.signRadius  = DealWithString(dict[@"signRadius"]);
    model.signTextRadius = DealWithString(dict[@"signTextRadius"]);
    model.planetsExtendRadius = DealWithString(dict[@"planetsExtendRadius"]);
    return model;
}
@end

@implementation TTXingPanPosition

+(instancetype)objectWithDictionary:(NSDictionary *)dict{
    TTXingPanPosition *model = [[TTXingPanPosition alloc] init];
    model.x = DealWithString(dict[@"x"]);
       model.y = DealWithString(dict[@"y"]);
       model.text = DealWithString(dict[@"text"]);
    model.planet_symbol = DealWithString(dict[@"planet_symbol"]);
       model.color = DealWithString(dict[@"color"]);
    
    
    return model;
    
    
}
@end

@implementation TTXingPanPlanets
+(instancetype)objectWithDictionary:(NSDictionary *)dict{
    TTXingPanPlanets *model = [[TTXingPanPlanets alloc] init];
    model.myID = DealWithString(dict[@"id"]);
    model.name = DealWithString(dict[@"name"]);
    model.sign = DealWithString(dict[@"sign"]);
    model.sign_name = DealWithString(dict[@"sign_name"]);
    model.degree = DealWithString(dict[@"degree"]);
    model.decimal = DealWithString(dict[@"decimal"]);
    model.speed = DealWithString(dict[@"speed"]);
    model.symbol = DealWithString(dict[@"symbol"]);
    model.angle = DealWithString(dict[@"angle"]);

    
    
    model.position = DealWithDictionary(dict[@"position"]);
    model.extend_position = DealWithDictionary(dict[@"extend_position"]);
    
    model.show_position = [TTXingPanPosition objectWithDictionary:DealWithDictionary(dict[@"show_position"])];

    return model;
}
@end

@implementation TTXingPanHouses
+(instancetype)objectWithDictionary:(NSDictionary *)dict{
    TTXingPanHouses *model = [[TTXingPanHouses alloc] init];
    model.myID = DealWithString(dict[@"id"]);
    model.name = DealWithString(dict[@"name"]);
    model.sign = DealWithString(dict[@"sign"]);
    model.sign_name = DealWithString(dict[@"sign_name"]);
    model.degree = DealWithString(dict[@"degree"]);
    model.decimal = DealWithString(dict[@"decimal"]);
    model.houseIn_position = DealWithDictionary(dict[@"houseIn_position"]);
    model.houseOut_position = DealWithDictionary(dict[@"houseOut_position"]);
    
    model.show_position = [TTXingPanPosition objectWithDictionary:DealWithDictionary(dict[@"show_position"])];

    return model;
    
}
@end

@implementation TTXingPanSign
+(instancetype)objectWithDictionary:(NSDictionary *)dict{
    TTXingPanSign *model = [[TTXingPanSign alloc] init];
    model.myID = DealWithString(dict[@"id"]);
    model.name = DealWithString(dict[@"name"]);
    model.symbol  = DealWithString(dict[@"symbol"]);
    model.position = DealWithDictionary(dict[@"position"]);
    
    model.position_planet = [TTXingPanPosition objectWithDictionary:DealWithDictionary(dict[@"position_planet"])];
     model.position_sign = [TTXingPanPosition objectWithDictionary:DealWithDictionary(dict[@"position_sign"])];
    
    return model;
    
}


@end


@implementation TTXingPanPlanetsLine
+(instancetype)objectWithDictionary:(NSDictionary *)dict{
    TTXingPanPlanetsLine *model = [[TTXingPanPlanetsLine alloc] init];
    model.planetA = DealWithDictionary(dict[@"planetA"]);
    model.planetB = DealWithDictionary(dict[@"planetB"]);
    model.planets_ids = DealWithDictionary(dict[@"planets_ids"]);
    model.extend = DealWithString(dict[@"extend"]);
    model.color = DealWithString(dict[@"color"]);
    model.solid = DealWithString(dict[@"solid"]);
    
    return model;
}


@end


@implementation XingPanModel
+(instancetype)objectWithDictionary:(NSDictionary *)dict{
    XingPanModel *model = [[XingPanModel alloc]init];
    model.params = [TTXingPanParams objectWithDictionary:DealWithDictionary(dict[@"params"])];
    NSMutableArray *planetsArr = [NSMutableArray array];
    for (NSDictionary * myDict in dict[@"planets"]) {
        TTXingPanPlanets *myModel = [TTXingPanPlanets objectWithDictionary:myDict];
        [planetsArr addObject:myModel];
    }
    model.planets = planetsArr;
    
    NSMutableArray *houseArr = [NSMutableArray array];
      for (NSDictionary * myDict in dict[@"houses"]) {
          TTXingPanHouses *myModel = [TTXingPanHouses objectWithDictionary:myDict];
          [houseArr addObject:myModel];
      }
      model.houses = houseArr;

    NSMutableArray *signArr = [NSMutableArray array];
         for (NSDictionary * myDict in dict[@"sign"]) {
             TTXingPanSign *myModel = [TTXingPanSign objectWithDictionary:myDict];
             [signArr addObject:myModel];
         }
         model.sign = signArr;
        
    NSMutableArray *planetsLineArr = [NSMutableArray array];
    for (NSDictionary *myDict in dict[@"planetsLine"]) {
        TTXingPanPlanetsLine *myModel = [TTXingPanPlanetsLine objectWithDictionary:myDict];
        [planetsLineArr addObject:myModel];
    }
    model.planetsLine = planetsLineArr;
    
    
    
        return model;
    
}
@end
