//
//  ZHMultiSportMode.h
//  WearHeartFunction
//
//  Created by 腾飞 on 2019/4/26.
//  Copyright © 2019 王腾飞. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN
/*
 * 运动类型
 */
typedef NS_ENUM(NSInteger, MotionType) {
    SportTypeRunning,           // 跑步  /   running
    SportTypeWalking,           // 健走  /  walking
    SportTypeClimbing,          // 爬山  / mountain climbing
    SportTypeRiding,            // 骑行  /  bike ride
    SportTypePingPong,          // 乒乓球  / table tennis
    SportTypeBasketball,        // 篮球  / basketball
    SportTypeBadminton,         // 羽毛球  / badminton
    SportTypeFootball,          // 足球  / football
    SportTypeSwimming,          // 游泳  / swimming
    SportTypeIndoor             //室内运动  / Indoor sports
};

/*
 * 运动UI展示类型(获取数据类型)  /  Motion UI presentation type (access data type)
 */
typedef NS_ENUM(NSInteger, MotionUIType) {
    SportUITypeZero,           // 开始时间 + 总时长 + 计步  /  Start time + total time + steps
    SportUITypeOne,            // 开始时间 + 总时长 + 卡路里  /  Start time + total time + calories
    SportUITypeTwo,            // 开始时间 + 总时长 + 计步 + 卡路里 + 里程  /  Start time + total time + steps + calories + mileage
    SportUITypeThree           // 开始时间 + 总时长 + 计步 + 卡路里  /  Start time + total time + steps + calories
};

@interface ZHMultiSportMode : NSObject

/*
 * 运动开始时间(格式:"YYYY-MM-dd HH:mm:ss")  /  Movement start time (format :" yyyy-mm-dd HH: MM :ss")
 */
@property (copy, nonatomic) NSString *sportDate;

/*
 * 运动时长(单位：秒)  /  Movement time (unit: second)
 */
@property (assign, nonatomic) int sportTime;

/*
 * 运动类型  /  Movement type
 */
@property (assign, nonatomic) MotionType sportType;

/*
 * 运动UI类型(获取数据类型)  /  Motion UI type (get data type)
 */
@property (assign, nonatomic) MotionUIType sportUIType;

/*
 * 运动总步数(单位：步)  /  Total number of steps in motion (unit: step)
 */
@property (assign, nonatomic) int totalStep;

/*
 * 运动距离(单位：m)  /  Movement distance (unit: m)
 */
@property (assign, nonatomic) int sportDistance;

/*
 * 运动卡路里(单位：kcal)  /  Sports calories (unit: kcal)
 */
@property (assign, nonatomic) int sportCalories;

/*
 * 运动心率(单位：bpm)  /  Exercise heart rate (unit: bpm)
 */
@property (assign, nonatomic) int sportHR;


@end

NS_ASSUME_NONNULL_END
