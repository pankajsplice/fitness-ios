//
//  ZHBlePeripheral.h
//
//  Created by Soar.
//  Copyright ©  zhouhai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "FitnessInfo.h"
#import "ZHMultiSportMode.h"


@protocol ZHBlePeripheralDelegate <NSObject>

@optional
/*
 * 蓝牙状态更新的回调  /  Callback to bluetooth status update
 */
- (void)didUpdateBlueToothState:(CBCentralManager *)central;
/*
 * 搜索找到设备回调  /  The search finds the device callback
 */
- (void)didFindPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber*)RSSI IsSupportBind:(BOOL)flag IsBinded:(BOOL)status;
/*
 * 连接蓝牙成功回调  /  Bluetooth connection successful callback
 */
- (void)didConnectPeripheral:(CBPeripheral *)peripheral;
/*
 * 发现外围设备的服务 / Discover peripheral services
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error;
/*
 * 发现外围设备服务的特征 / Discover the characteristics of peripheral services
 */
- (void) peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error;
/*
 * 连接蓝牙失败回调  /  Bluetooth connection failure callback
 */
- (void)didFailToConnectPeripheral:(CBPeripheral *)peripheral;
/*
 * 断开蓝牙回调  /  Disconnect the bluetooth callback
 */
- (void)didDisconnectPeripheral:(CBPeripheral *)peripheral;
/*
 * 未发现服务的回调  /  No service callbacks were found
 */
- (void)notfindAvailableDevice:(CBPeripheral *)peripheral;
/*
 * 连接错误回调  /  Connection error callback
 */
- (void)connectPeripheralError:(NSString *)error;


-(void)setMtuValue:(int)Mtu;
-(void)setConnectionSpacingCode:(int)dataCode;
-(void)alreadyToReceive;
- (void)singleBlockReceptionComplete;
-(void)lostPackageSNCode:(NSArray *)arrSN;
-(void)replacementPackageValidation:(int)SNCode;
-(void)dataTransportFailureInstruction:(int)errorCode;


@end

@protocol ZHBleSportDataSource <NSObject>

@required
/*
 * 设置用户身高(计算距离、卡路里需要)(若为空或0，则为默认值：175 kg)  /  Set user height (calculated distance, calories needed)(if empty or 0, the default value: 175 kg)
 */
- (CGFloat)setUserHeight;
/*
 * 设置用户体重(计算距离、卡路里需要)(若为空或0，则为默认值：60 kg)  /  Set the user's weight (calculate distance, calories needed)(if it is empty or 0, it will be the default value: 60 kg)
 */
- (CGFloat)setUserWeight;

@optional
/*******************
 * 获得某天的运动数据  /  Get movement data for a given day
 *
 * @param sportDate 某天的日期 格式:yyyy-MM-dd  /  Date format for a given day: yyyy-mm-dd
 * @param sportData 24个小时每个小时运动数据数组（共24条，0-23点）  /  24 hours per hour motion data array (24 items in total, 0-23 points)
 * @param distance  运动距离，设备端显示的是小数点后两位，是直接舍掉小数点两位后的所有数值(注意不是四舍五入)，计算英制时需直接用原始值计算(distance/1.61)  /  The moving distance is displayed at the end of the device after two decimal points. All the values after two decimal points are directly removed (Note: That it is not rounded). The original value should be directly used to calculate the British system.(distance/1.61)
 */
- (void)getSportForDate:(NSString *)sportDate andStepData:(NSArray *)sportData andDistance:(CGFloat)distance andKcal:(CGFloat)kcal;


@end

@protocol ZHOtherDataSource <NSObject>

@optional

/*******************
 * 获得某天的睡眠数据 (某天的睡眠数据是指在设备端前一天的睡眠数据，例如今天20日的睡眠数据是在设备端是19日)  /  Obtain the sleep data of a certain day (the sleep data of a certain day refers to the sleep data of the previous day on the device side, for example, the sleep data of today's 20th day is on the device side and is on the 19th day)
 *
 * @param sleepDate 某天的日期 格式:yyyy-MM-dd  /  Date format for a given day: yyyy-mm-dd
 * @param sleepTotalTime 总睡眠时长
 * @param typeDate 类型睡眠时长（0:熬夜,1:入睡,2:浅睡,3:深睡,4:中途醒来,5:起床）  /  Type sleep duration (0: stay up,1: fall asleep,2: light sleep,3: deep sleep,4: wake up halfway,5: wake up) Demo:typeDate =
 */
- (void)getSleepForDate:(NSString *)sleepDate forTotalSleepTime:(NSString *)sleepTotalTime andForSleepTypeData:(NSArray *)typeDate;

    
/*******************
 * 获得某天的连续心率数据  /  Obtain continuous heart rate data for a given day
 *
 * @param HRDate 某天的日期 格式:yyyy-MM-dd  /  Date format for a given day: yyyy-mm-dd
 * @param HRData 连续心率数据（288个点）  /  Continuous heart rate data (288 points)
 */
- (void)getContinuousHRForDate:(NSString *)HRDate forHeartRateData:(NSArray *)HRData;

/*******************
 * 获得MAC地址  /  Get MAC address
 *
 * @param MAC 设备mac地址 (--:--:--:--:--:--)  /  MAC address of device (--:--:--:--:--:--)
 */
- (void)getDeviceMAC:(NSString *)MAC;

/*******************
 * 获取设备信息  /  Get device information
 *
 * @param deviceNumber 设备类型  /  Device type
 * @param firmwareVersion 固件版本  /  Firmware version
 * @param deviceVersion 设备版本号  /  Device version number
 * @param type 平台类型(0为Nordic 1为Realtek 2为Dialog)  /  platform Type (0:Nordic 1:Realtek 2:Dialog)
 * @param notDisturb 是否支持勿扰功能  /  Does it support the do not disturb feature
 * @param battery 电量  /  electricity
 */
- (void)getDeviceNumber:(NSNumber *)deviceNumber
     andFirmwareVersion:(NSNumber *)firmwareVersion
       andDeviceVersion:(NSString *)deviceVersion
       andPlatformType:(NSNumber *)type
       andisSupportNotDisturb:(BOOL)notDisturb
       andDeviceBattery:(NSNumber *)battery;

/*
 * 摇摇拍照指令回调  /  Snap snap command callback
 */
- (void)shakePhotographInstruction;

/*
 * 找手机指令回调  /  Find the cell phone command callback
 */
- (void)findPhoneInstruction;

/*
 * 同步数据完成回调(获取运动、睡眠、心率等数据)  /  Complete the callback by synchronizing data (obtaining data of exercise, sleep, heart rate, etc.)
 */
- (void)synchronousDataFinished;

/*******************
 * 获得某天多运动模式的数据  /  Get data on multi-activity patterns for a given day
 *
 * @param sportModel 获取的多运动模式的模型  /  Get the multi-motion model
 *
 */
- (void)getMultiSportModeForData:(ZHMultiSportMode *)sportModel;

/*******************
 * 获得脱离手机测量的血压心率数据(设备最多储存20条数据)
 *
 * @param healthData 离线健康数据(字典数组：@"Date":测量时间(精确到秒) @"HeartRate":心率 @"Diastolic":收缩压(低压) @"Systolic":舒张压(高压))
 *
 */
- (void)getOfflineHealthData:(NSArray *)healthData;

/*******************
 * 获得脱离手机测量的血氧数据
 *
 * @param spoData 离线血氧数据(字典数组：@"SpoDate":测量时间(精确到秒) @"BloodOxygen":血氧)
 *
 */
- (void)getOfflineBloodOxygenData:(NSArray *)spoData;

@end

@protocol ZHBleHealthDataSource <NSObject>

@required
/*
 * 设置用户校准心率(若为0或者空，则为默认值：70 bpm)  /  Set the user calibration heart rate (if it is 0 or null, it will be the default value: 70 BPM)
 */
- (int)setCalibrationHR;
/*
 * 设置用户校准高压(收缩压)(若为0或者空，则为默认值：120 mmHg)  /  Set the user calibration high pressure (systolic pressure)(if it is 0 or empty, it will be the default value: 120 mmHg)
 */
- (int)setCalibrationSystolic;
/*
 * 设置用户校准低压(舒张压)(若为0或者空，则为默认值：70 mmHg)  /  Set the user calibration low pressure (diastolic pressure)(if it is 0 or empty, it will be the default value: 70 mmHg)
 */
- (int)setCalibrationDiastolic;


@optional

/*******************
 * 获得实时ppg测量健康数据(每次从蓝牙接到的数据)  /  Get real-time PPG health measurement data (data received from bluetooth every time)
 *
 * @param HR 实时心电测量的心率值  /  Real-time heart rate measurements
 * @param systolic 实时心电测量的高压值(收缩压)  /  High voltage values for real-time ecg measurements (systolic)
 * @param diastolic 实时心电测量的低压值(舒张压)  /  Low pressure values from real-time ecg measurements (diastolic)
 * 备注：以下参数,途中测量为默认值计算，测量结束为正确值。建议只在测量结束时显示  /  Note: for the following parameters, the measurement on the way is calculated as the default value, and the end of the measurement is the correct value. It is recommended to display only at the end of the measurement
 */
- (void)getMeasureHeartRate:(int)HR Systolic:(int)systolic Diastolic:(int)diastolic;


@end

@protocol ZHBleMultiSportDelegate <NSObject>

@optional
/**
 *  历史多运动记录同步进度 /   Synchronization progress of historical multiple motion records
 *  @param curCount 当前同步数据序号    /   current synchronous data serial number
 *  @param totalCount 需同步总数据数   /   total number of data to be synchronized
 */
-(void)haveReceiveHistoricalSportRecord:(NSInteger)curCount Total:(NSInteger)totalCount;
/**
 *  今日多运动记录同步进度 /   Today's multi motion record synchronization progress
 *  @param curCount 当前同步数据序号    /   current synchronous data serial number
 *  @param totalCount 需同步总数据数   /   total number of data to be synchronized
 */
-(void)haveReceiveTodaySportRecord:(NSInteger)curCount Total:(NSInteger)totalCount;
/**
 *  历史多运动记录同步完成 /   Synchronous completion of historical multiple motion records
 *  @param fitnessArray 运动记录模型数组    /   motion record model array
 */
-(void)didReceivedHistoricalSportRecord:(NSArray<__kindof FitnessInfo *> *)fitnessArray;
/**
 *  今日多运动记录同步完成 /   Today's multi motion recording is completed synchronously
 *  @param fitnessArray 运动记录模型数组    /   motion record model array
 */
-(void)didReceivedTodaySportRecord:(NSArray<__kindof FitnessInfo *> *)fitnessArray;
/**
 *  多运动记录同步超时   /   Multi motion record synchronization timeout
 */
-(void)didFinishReceiveSportRecordWithTimeOut;

@end

@protocol ZHBleFileTransferDelegate <NSObject>

@optional
/**
 *  OTA传输前设备状态  /   Device status before OTA transmission
 *  @param state 传输前状态，0x00-支持传输，0x01-状态异常，不支持传输   /   Status before transmission: 0x00 supports transmission; 0x01 is abnormal and does not support transmission
 */
-(void)didReceiveStatusBeforeOTATransmission:(NSInteger)state;
/**
 *  表盘传输前设备状态   /   Device status before dial transmission  /   Status before transmission: 0x00 supports transmission; 0x01 is abnormal and does not support transmission
 *  @param state 传输前状态，0x00-支持传输，0x01-状态异常，不支持传输
 */
-(void)didReceiveStatusBeforeDialTransmission:(NSInteger)state;
/**
 *  文件传输进度  /   File transfer progress
 *  @param curCount 当前传输数据包序号   /   serial number of current transmission packet
 *  @param totalCount 需传输总数据包数  /   total number of packets to be transmitted
 */
-(void)didSend:(NSUInteger)curCount totalToSend:(NSUInteger)totalCount;
/**
 *  文件传输超时  /   File transfer timeout
 */
-(void)didFinishSendWithTimeOut;

@end

@protocol ZHBleGPSSportDelegate <NSObject>

@optional
/**
 *  查询设备GPS运动状态回调，如未收到此回调表示设备不在运动状态 /   Query the GPS motion status callback of the device. If the callback is not received, the device is not in motion
 *  @param state 0x00-运动暂停，0x01-运动中 /   0x00 - motion pause, 0x01 - in motion
 */
-(void)didQueriedStatusOfDeviceGPSSport:(NSInteger)state;

/**
 *  设备上报GPS运动状态 /   Equipment report GPS movement status
 *  @param state 0x00-运动开始，0x01-运动暂停，0x02-运动恢复，0x03-运动结束    /   0x00 movement start, 0x01 movement pause, 0x02 movement resume, and 0x03 movement end
 */
-(void)didReceivedStatusOfDeviceGPSSport:(NSInteger)state;

/**
 *  询问设备是否需要更新AGPS回调    /   Ask if the device needs to update the AGPs callback
 *  @param needed 是否需要更新    /   Do you need to update
 */
-(void)didReceivedAGPSRequest:(BOOL)needed;

@end

@protocol ZHBleDeviceBindDelegate <NSObject>

@optional

/**
 *  发起设备绑定结果回调  /   Initiate device binding result callback
 *  @param result 0-拒绝，1-同意
 */
-(void)didReceiveDeviceBindingResult:(int)result;

/**
 *  查询设备绑定状态回调
 *  @param status 0-设备已解绑，1-设备被绑定   /   0-reject, 1-agree
 */
-(void)didReceiveDeviceBindingStatus:(int)status;

/**
 *  收到设备主动上报解绑  /   Query device binding status callback
 */
-(void)didReceiveDeviceReportToUnbind;

@end

@interface ZHBlePeripheral : NSObject <CBPeripheralDelegate, CBCentralManagerDelegate>


@property (strong, nonatomic) CBCentralManager * centralManager;

@property (nonatomic, strong) CBPeripheral * mPeripheral;

/**
 * 蓝牙连接代理  /  Bluetooth connection agent
 */
@property (nonatomic, weak) id<ZHBlePeripheralDelegate> delegate;
/**
 * 运动数据源  /  Motion data source
 */
@property (nonatomic, weak) id<ZHBleSportDataSource> sportDataSource;

/**
 * 其他数据源  /  Other data source
 */
@property (nonatomic, weak) id<ZHOtherDataSource> otherDataSource;

/**
 * 健康数据源  /  Health data source
 */
@property (nonatomic, weak) id<ZHBleHealthDataSource> healthDataSource;

/**
 *  多运动数据代理  /  MultiSport delegate
 */
@property (nonatomic, weak) id<ZHBleMultiSportDelegate> multiSportDelegate;

/**
 *  文件传输代理  /  File Transfer delegate
 */
@property (nonatomic, weak) id<ZHBleFileTransferDelegate> fileTransferDelegate;

/**
 *  设备GPS运动代理  /  GPS Sport delegate
 */
@property (nonatomic, weak) id<ZHBleGPSSportDelegate> gpsSportDelegate;

/**
 *  设备绑定代理  /  Device Bind delegate
 */
@property (nonatomic, weak) id<ZHBleDeviceBindDelegate> deviceBindDelegate;

/*
 * 蓝牙打开状态 / Bluetooth on
 */
@property (nonatomic, assign) BOOL mIsOpen;

/**
 * 设备连接状态  /  Device connection status
 */
@property (nonatomic,assign) BOOL mConnected;

/**
 * 是否重连  /  Whether reconnection
 */
@property (assign, nonatomic) BOOL isReconnection;

/**
 * mtu值
 */
@property (assign, nonatomic) int mtu;

/**
 * 实例化    /  instantiation
 */
+ (instancetype)sharedUartManager;

/**
 * 设备UUID  /  Device UUID
 */
+ (CBUUID *) uartServiceUUID;

/**
 *  扫描蓝牙设备  /  Scan bluetooth device
 */
-(void)scanDevice;

/**
 *  停止扫描蓝牙设备  /  Stop scanning the bluetooth device
 */
-(void)stopScan;

/**
 *  连接蓝牙  /  Connect the bluetooth
 */
- (void)didConnect;

/**
 *  断开蓝牙  /  Disconnect the bluetooth
 */
- (void)didDisconnect;

/**
 * 写入蓝牙指令  /  Write bluetooth
 *
 * @param data 需要写入的数据  /  Data that needs to be written
 */
- (void) writeData:(NSMutableData *) data;


/**
 *  写入主题数据  /   Write topic data
 */
- (void)writeThemeData:(NSMutableData *) data;

/**
 * 写入ProtoBuf指令 /   Write protobuf instruction
 * @param data 需要写入的数据  /   Data to be written
 * @param channel 数据发送通道    /   data transmission channel
 */
- (void)writeProtoData:(NSData *) data Channel:(int)channel;

@end

