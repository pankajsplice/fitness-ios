//
//  FitnessInfo.h
//  FFit
//
//  Created by 顾国强 on 2020/8/11.
//

#import <Foundation/Foundation.h>
#import "PacketInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface FitnessInfo : NSObject

#pragma mark - 数据ID

@property(nonatomic,strong)NSData *idData;
@property(nonatomic,assign)int dataType;
@property(nonatomic,assign)int version;
@property(nonatomic,assign)int describe;
@property(nonatomic,strong)NSData *dotData;

/**
 *  时间戳(秒)
 *  Time stamp (seconds)
 */
@property(nonatomic,assign)long long timeStamp;
/**
 *  时区，原始数据 = 真实数据*8
 *  Time zone, raw data = real data * 8
 */
@property(nonatomic,assign)int timeZone;
/**
 *  运动类型，0=无，1=户外跑步，2=健走，3=室内跑步，4=登山，5=越野，6=户外骑行，7=室内骑行，8=自由训练，9=篮球，10=足球，11=乒乓球，12=羽毛球
 *  Sports type: 0 = none, 1 = outdoor running, 2 = walking, 3 = indoor running, 4 = mountaineering, 5 = cross-country, 6 = outdoor cycling, 7 = indoor cycling, 8 = free training, 9 = basketball, 10 = football, 11 = table tennis, 12 = badminton
 */
@property(nonatomic,assign)int sportType;

#pragma mark - 打点数据
/**
 *  打点数据有效性描述
 *  Effectiveness description of management data
 */
@property(nonatomic,assign)uint32_t dotDescription;
/**
 *  单次运动内存在多段运动记录
 *  There are multiple motion records in a single motion
 */
@property(nonatomic,strong)NSArray<__kindof PacketInfo *> *dotArray;

#pragma mark - 报告数据
/**
 *  报告数据压缩方式(7~4bit)与加密方式(3~0bit)
 *  Report data compression (7-4bit) and encryption (3-0bit)
 */
@property(nonatomic,assign)int reportEncryption;
/**
 *  报告数据有效性描述
 *  Report data validity description
 */
@property(nonatomic,assign)uint32_t reportDescription;
/**
 *  运动开始时间戳（秒）
 *  Motion start timestamp (seconds)
 */
@property(nonatomic,assign)long long startTime;
/**
 *  运动结束时间戳（秒
 *  Movement end timestamp (seconds)）
 */
@property(nonatomic,assign)long long endTime;
/**
 *  运动总时长（秒）
 *  Total exercise duration (seconds)
 */
@property(nonatomic,assign)int duration;
/**
 *  运动总里程（米）
 *  Total mileage (m)
 */
@property(nonatomic,assign)int distance;
/**
 *  活动卡路里（千卡）
 *  Activity calories (kcal)
 */
@property(nonatomic,assign)int carol;
/**
 *  最快配速（秒/公里）
 *  Fastest speed (s / km)
 */
@property(nonatomic,assign)int fastPace;
/**
 *  最慢配速（秒/公里）
 *  Slowest speed (s / km)
 */
@property(nonatomic,assign)int slowPace;
/**
 *  最快速度（公里/小时）
 *  Fastest speed (km / h)
 */
@property(nonatomic,assign)float fastSpeed;
/**
 *  总步数（步）
 *  Total steps (steps)
 */
@property(nonatomic,assign)int totalStep;
/**
 *  最大步频（步/分钟）
 *  Maximum step frequency (step / min)
 */
@property(nonatomic,assign)int frequency;
/**
 *  平均心率（次/分钟）
 *  Average heart rate (BPM)
 */
@property(nonatomic,assign)int avgHeart;
/**
 *  最大心率（次/分钟）
 *  Maximum heart rate (BPM)
 */
@property(nonatomic,assign)int maxHeart;
/**
 *  最小心率（次/分钟）
 *  Minimum heart rate (BPM)
 */
@property(nonatomic,assign)int minHeart;
/**
 *  累计上升（米）
 *  Cumulative rise (m)
 */
@property(nonatomic,assign)float riseUp;
/**
 *  累计下降（米）
 *  Cumulative decrease (m)
 */
@property(nonatomic,assign)float dropDown;
/**
 *  平均高度（米）
 *  Average height (m)
 */
@property(nonatomic,assign)float avgHeight;
/**
 *  最大高度（米）
 *  Maximum height (m)
 */
@property(nonatomic,assign)float maxHeight;
/**
 *  最小高度（米）
 *  Minimum height (m)
 */
@property(nonatomic,assign)float minHeight;
/**
 *  训练效果
 *  Training effect
 */
@property(nonatomic,assign)float effect;
/**
 *  最大摄氧量（毫升/千克/分钟）
 *  VO2max (ml / kg / min)
 */
@property(nonatomic,assign)int oxygen;
/**
 *  身体能量消耗
 *  Body energy expenditure
 */
@property(nonatomic,assign)int energy;
/**
 *  预计恢复时间（小时）
 *  Estimated recovery time (hours)
 */
@property(nonatomic,assign)int recovery;
/**
 *  心率-极限时长（秒）
 *  Heart rate limit duration (seconds)
 */
@property(nonatomic,assign)int limitsTime;
/**
 *  心率-无氧耐力时长（秒）
 *  Heart rate - duration of anaerobic endurance (seconds)
 */
@property(nonatomic,assign)int anaerobic;
/**
 *  心率-有氧耐力时长（秒）
 *  Heart rate aerobic endurance duration (seconds)
 */
@property(nonatomic,assign)int aerobic;
/**
 *  心率-燃脂时长（秒）
 *  Heart rate - duration of fat burning (seconds)
 */
@property(nonatomic,assign)int burning;
/**
 *  心率-热身时长（秒）
 *  Heart rate - warm up duration (seconds)
 */
@property(nonatomic,assign)int warmup;

#pragma mark - GPS数据
/**
 *  GPS数据压缩方式(7~4bit)与加密方式(3~0bit)
 *  GPS data compression mode (7 ~ 4bit) and encryption mode (3 ~ 0bit)
 */
@property(nonatomic,assign)int gpsEncryption;
/**
 *  GPS数据有效性描述
 *  Description of GPS data validity
 */
@property(nonatomic,assign)uint8_t gpsDescription;
/**
 *  GPS轨迹字符串，格式：经度1，纬度1；经度2，纬度2；...；经度N，纬度N
 *  GPS track string, format: longitude 1, latitude 1; longitude 2, latitude 2;...; longitude N, latitude N
 */
@property(nonatomic, copy) NSString *mapData;
/**
 *  GPS轨迹时间戳字符串，格式：时间戳1，时间戳2，...，时间戳N
 *  GPS track timestamp string, format: timestamp 1, timestamp 2,..., timestamp N
 */
@property(nonatomic, copy) NSString *timestampData;

@end

NS_ASSUME_NONNULL_END
