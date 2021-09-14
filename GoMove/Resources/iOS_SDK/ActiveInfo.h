//
//  MovementInfo.h
//  FFit
//
//  Created by 顾国强 on 2020/8/11.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActiveInfo : NSObject
/**
 *  新增里程（0.1米），原始数据 = 真实数据*10
 *  New mileage (0.1M), original data = real data * 10
 */
@property(nonatomic,assign)uint32_t distance;
/**
 *  高度变化（0.1），原始数据 = 真实数据*10
 *  Height change (0.1), raw data = real data * 10
 */
@property(nonatomic,assign)uint32_t height;
/**
 *  高度变化类型，0=下降，1=上升
 *  Height change type, 0 = descending, 1 = ascending
 */
@property(nonatomic,assign)uint32_t heightType;
/**
 *  是否整公里，0=不是整公里，1=是整公里
 *  If it is a whole kilometer, 0 = not a whole kilometer, 1 = a whole kilometer
 */
@property(nonatomic,assign)uint32_t iskm;
/**
 *  心率
 *  Heart rate
 */
@property(nonatomic,assign)uint32_t heart;
/**
 *  步数
 *  Steps
 */
@property(nonatomic,assign)uint32_t step;
/**
 *  新增卡路里（千卡）
 *  New calories (kcal)
 */
@property(nonatomic,assign)uint32_t carol;
@end

NS_ASSUME_NONNULL_END
