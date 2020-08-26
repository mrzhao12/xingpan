//
//  XingPanModel.h
//
//
//  Created by tongtong zhao on 2020/8/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



@interface TTXingPanParams : NSObject
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *radius;
@property (nonatomic, strong) NSString *maxRadius;
@property (nonatomic, strong) NSString *houseOutRadius;
@property (nonatomic, strong) NSString *houseInRadius;
@property (nonatomic, strong) NSString *planetsRadius;
@property (nonatomic, strong) NSString *planetsExtendRadius;
@property (nonatomic, strong) NSString *planetsTextRadius;
@property (nonatomic, strong) NSString *signRadius;
@property (nonatomic, strong) NSString *signTextRadius;
+(instancetype)objectWithDictionary:(NSDictionary *)dict;

@end

@interface TTXingPanPosition : NSObject

@property (nonatomic, strong) NSString *x;
@property (nonatomic, strong) NSString *y;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *planet_symbol;
@property (nonatomic, strong) NSString *color;
+(instancetype)objectWithDictionary:(NSDictionary *)dict;
@end


@interface TTXingPanPlanets : NSObject

@property (nonatomic, strong) NSString *myID; //id
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *sign;
@property (nonatomic, strong) NSString *sign_name;
@property (nonatomic, strong) NSString *degree;
@property (nonatomic, strong) NSString *decimal;
@property (nonatomic, strong) NSString *speed;
@property (nonatomic, strong) NSString *symbol; // 自定义字体颜色
@property (nonatomic, strong) NSString *angle;
//@property (nonatomic, strong) TTXingPanPosition *position;
@property (nonatomic, strong) NSDictionary *position;
@property (nonatomic, strong) NSDictionary *extend_position;
//@property (nonatomic, strong) TTXingPanPosition *extend_position;
@property (nonatomic, strong) TTXingPanPosition *show_position;

+(instancetype)objectWithDictionary:(NSDictionary *)dict;
@end

@interface TTXingPanHouses : NSObject
@property (nonatomic, strong) NSString *myID; //id
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *sign;
@property (nonatomic, strong) NSString *sign_name;
@property (nonatomic, strong) NSString *degree;
@property (nonatomic, strong) NSString *decimal;
@property (nonatomic, strong) NSDictionary *houseIn_position;
@property (nonatomic, strong) NSDictionary *houseOut_position;
@property (nonatomic, strong) TTXingPanPosition *show_position;
+(instancetype)objectWithDictionary:(NSDictionary *)dict;
@end

@interface TTXingPanSign : NSObject
@property (nonatomic, strong) NSString *myID; //id
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *symbol;
@property (nonatomic, strong) NSDictionary *position;
@property (nonatomic, strong) TTXingPanPosition *position_planet; // 行星
@property (nonatomic, strong) TTXingPanPosition *position_sign; //  星座
+(instancetype)objectWithDictionary:(NSDictionary *)dict;

@end



@interface TTXingPanPlanetsLine : NSObject

@property (nonatomic, strong) NSDictionary *planetA;
@property (nonatomic, strong) NSDictionary *planetB;
@property (nonatomic, strong) NSDictionary *planets_ids;
@property (nonatomic, strong) NSString *extend;
@property (nonatomic, strong) NSString *color;
@property (nonatomic, strong) NSString *solid;
+(instancetype)objectWithDictionary:(NSDictionary *)dict;
@end

@interface XingPanModel : NSObject

@property (nonatomic, strong) TTXingPanParams *params;
@property (nonatomic, strong) NSArray *planets;
@property (nonatomic, strong) NSArray *houses;


@property (nonatomic, strong) NSArray *sign;
@property (nonatomic, strong) NSArray *planetsLine;
+(instancetype)objectWithDictionary:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
