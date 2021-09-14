//
//  Packet.h
//  FFit
//
//  Created by 顾国强 on 2020/8/11.
//

#import <Foundation/Foundation.h>
#import "ActiveInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface PacketInfo : NSObject
/**
 *  记录时间戳（秒）
 *  Record timestamp (seconds)
 */
@property(nonatomic,assign)long long timeStamp;
/**
 *  初始海拔（米）
 *  Initial altitude (m)
 */
@property(nonatomic,assign)int altitude;
/**
 *  记录的数据条数
 *  Number of recorded data
 */
@property(nonatomic,assign)int dataNum;
/**
 *  每段运动内每秒的运动记录
 *  Movement records per second in each movement
 */
@property(nonatomic,strong)NSArray<__kindof ActiveInfo *> *activeArray;
@end

NS_ASSUME_NONNULL_END
