//
//  ZHSendCmdTool.h
//
//  Created by Soar.
//  Copyright ©  zhouhai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ZHAlarmClockModel.h"

/**
 生理周期类型类型
 */
typedef NS_ENUM(NSInteger, MenstrualType) {
    TypeMenstrualPeriod,          // 生理期                              0
    TypeSafetyPeriod,            // 安全期                              1
    TypeOvipositPeriod          // 排卵期                           2
};

/**
 * 主题传输结果状态
 */
typedef NS_ENUM(NSInteger, ThemeState) {
    ThemeStateFailure,          // 传输失败                              0
    ThemeStateSuccess            // 传输成功                              1
};

/**
 功能开关类型
 */
typedef NS_ENUM(NSInteger, FunctionSwitchType) {
    FunctionPhoneType,          // 通话     /  call
    FunctionSMSType,            // 短信    /  SMS
    FunctionBrightScreenType,   // 抬腕亮屏  /  Lift the wrist bright screen
    FunctionNotDisturbType,     // 勿扰模式(需先判断是否支持勿扰模式)   /  Not disturb (must first determine whether the do not disturb mode is supported)
    FunctionContinuousType,     // 连续心率监测开关  /  Continuous heart rate monitor switch
    FunctionTimeType,           // 24小时制(YES为24，NO为12)  /  24 hours (YES 24, NO 12)
    FunctionUnitType,           // 公制英制切换(YES为公制，NO为英制)  /  Metric to imperial switching (YES for metric, NO for imperial)
    FunctionWeChatType,         // 微信  /  WeChat
    FunctionQQType,             // QQ
    FunctionSkypeType,          // Skype
    FunctionWhatsAppType,       // WhatsApp
    FunctionFacebookType,       // Facebook
    FunctionLinkedInType,       // LinkedIn
    FunctionTwitterType,        // Twitter
    FunctionViberType,          // Viber
    FunctionLineType,            // Line
    FunctioniOSEmailType,        // iOS邮箱
    FunctionOutlookType,         // Outlook
    FunctionInstagramType,       // Instagram
    FunctionSnapchatType,        // Snapchat
    FunctionGmailType           // Gmail
};

/**
 功能设置时间类型
 */
typedef NS_ENUM(NSInteger, FunctionSetTimeType) {
    FunctionSedentaryType,      // 久坐  /  sedentary
    FunctionMedicineType,       // 吃药  /  Take the medicine
    FunctionDrinkType,          // 喝水  /  Drink lots of water
};

@protocol ZHThemeDelegate <NSObject>

@optional

/*******************
 * 发送主题数据进度回调
 *
 * @param totalParts 数据总量
 * @param progress  已发送的数据
 *
 */
-(void)sendThemeDataProgressDidChangeFor:(NSInteger)totalParts to:(NSInteger)progress;


/*******************
 * 发送主题结果状态
 *
 * @param state   失败/成功
 *
 */
-(void)sendThemeDataState:(ThemeState)state;



@end


@interface ZHSendCmdTool : NSObject

/**
 *  实例化   /  instantiation
 */
+ (ZHSendCmdTool *)shareIntance;

/**
 * 主题传输代理
 */
@property (nonatomic, weak) id<ZHThemeDelegate> delegate;


/*******************
 *
 *  发送告诉手环是iOS设备指令及某国语言(此为连接蓝牙成功后必设置项）  /  Sending a notification bracelet is an iOS device instruction and a certain language (this is a required setting item after successfully connecting bluetooth).
 *  @param  language_value 多国语言标识位：0为英文 1为中文 2为繁体 3为日 4为法 5为德 6为意大利 7为西班牙 8为俄罗斯 9为葡萄牙 10为马来西亚语 11为韩文 12为波兰  13为泰文  14为罗马尼亚语  15为保加利亚语  16为匈牙利语  17为土耳其语  18为捷克  19为斯洛伐克  20为丹麦  21为挪威  22为瑞典  23为菲律宾  24为乌克兰
 /  Signs of multiple languages: 0:English 1:Chinese 2:Traditional 3:Japanese 4:French 5:German 6:Italy 7:Spain 8:Russia 9:Portugal 10:Malaysia 11:Korean 12:Poland 13:Thai 14:romanian 15:Bulgarian 16:Hungarian 17:Turkish 18:Czech 19:slovak 20:Denmark 21:Norway 22:Sweden 23:Philippines 24:Ukraine
 */
- (void)sendiOSDeviceAndLanguageValue:(int)language_value;

/*******************
 *
 *  发送运动目标(此为连接蓝牙成功后必设置项）  /  Send a moving target (this is required after successfully connecting to bluetooth)
 *
 */
- (void)sendSportTarget:(int)target;


/**
 *   蓝牙同步个人信息（此为连接蓝牙成功后必设置项）  /  Bluetooth synchronization of personal information (this is required after successful bluetooth connection)
 *
 *  @param ageStr :25  sex:1  height:170cm  weight:65kg
 */
-(void)synPersonalInformationForAge:(NSString *)ageStr andSex:(NSString *)sexStr andHeight:(NSString *)heightStr andWeight:(NSString *)weightStr;


/*******************
 * 连接蓝牙时发送默认开关指令（此为连接蓝牙成功后必设置项） /  Send default switch instruction when connecting bluetooth (this is required after successfully connecting bluetooth)
 *
 * @param time 12/24小时制（0为12 1为24）  unit：公英制（1为公制 0为英制）  /  Unit: metric system (1 is metric system, 0 is British system)
 * @param hand 抬腕亮屏开关   continuous：连续心率监测 notDisturb：勿扰模式   /   hand:Raise wrist bright screen switch     continuous: Continuous heart rate monitoring   notDisturb: Disturb mode   /   messenger: facebook messenger
 *
 */
- (void)sendRemindStatusPhone:(int)phone
                       andSMS:(int)sms
                    andWeChat:(int)weChat
                        andQQ:(int)qq
                     andSkype:(int)skype
                  andWhatsapp:(int)whatsapp
                 andMessenger:(int)messenger
                      andTime:(int)time
                      andUnit:(int)unit
                      andHand:(int)hand
                andContinuous:(int)continuous
                andNotDisturb:(int)notDisturb
                  andLinkedIn:(int)linkedIn
                   andTwitter:(int)twitter
                     andViber:(int)viber
                      andLine:(int)line
                      iOSMail:(int)iOSMail
                      outlook:(int)outlook
                    instagram:(int)instagram
                     snapchat:(int)snapchat
                        gmail:(int)gmail;


/**
 *  同步时间指令，从蓝牙获得数据需要此指令  /  Synchronous time command, needed to get data from bluetooth
 */
-(void)synchronizeTime;


/**
 *  查找手环指令  /  Find the bracelet command
 */
- (void)sendFindBraceletCmd;

/**
 *  摇摇拍照指令  /  Shake the camera command
 */
- (void)sendShakePhotographCmd;
/**
 *  关闭拍照页面指令  /  Turn off the take photo page command
 */
- (void)turnOffShakePhotographCmd;

/**
*  结束睡眠标识(当检测用户有操作app时，需调用结束睡眠标识。例如在app启动时候)  /  End of sleep sign
*/
- (void)endSleepSign;


/**
 *  DFU(升级指令)  /  DFU(upgrade instruction)
 */
- (void)sendUpdateCmd;

/**
 *  恢复出厂设置指令  /  Restore factory Settings
 */
- (void)sendFactorySettingCmd;

/*******************
 * 实时测量指令  /  Real-time measurement command
 *
 * @param keyValue 实时测量指令   (0为结束  1为开始)   /  Real-time measurement instruction (0 is the end and 1 is the beginning)
 *
 */
- (void)sendMeasureCmd:(int)keyValue;


/**
*  发送校准的心率 血压 / Send calibrated heart rate and blood pressure
*
*  @param heartRate 心率 / HeartRate
*  @param systolic 收缩压(高压) / Systolic pressure (high pressure)
*  @param diastolic 舒张压(低压) / Diastolic blood pressure (low pressure)
*
*/
-(void)sendCalibrationBloodForHeartRate:(int)heartRate andSystolic:(int)systolic andDiastolic:(int)diastolic;


/**
 *  发送测量后心率 血压 / Send measured heart rate, blood pressure
 *
 *  @param heart 心率 / HeartRate
 *  @param systolic 收缩压(高压) / Systolic pressure (high pressure)
 *  @param diastolic 舒张压(低压) / Diastolic blood pressure (low pressure)
 *
 */
- (void)sendHeartDataCmd:(int)heart andSystolic:(int)systolic andDiastolic:(int)diastolic;



/*******************
 * 发送提醒开关指令  /  Send reminder switch instruction
 *
 * @param type 功能类型 枚举FunctionSwitchType  /  Function type  enumeration:FunctionSwitchType
 * @param isOpen 是否开着的
 *
 */
- (void)setRemindForType:(FunctionSwitchType)type withSwitch:(BOOL)isOpen;

/*******************
 * 久坐、吃药、喝水提醒  /  Sit for too long, take medicine, drink water to remind
 *
 * @param type 功能类型 枚举FunctionSetTimeType  /  Function type  enumeration:FunctionSwitchType
 * @param startTime 开始时间 格式：HH:mm  /  Start time format: HH:mm
 * @param endTime   结束时间 格式：HH:mm  /  End time format: HH:mm
 * @param interval  时间间隔 四个选择--久坐、喝水：1，2，3，4小时  吃药：4，6，8，12小时  /  Time interval four choices -- sitting for a long time, drinking water: 1,2,3,4 hours to take medicine: 4，6，8，12 hours
 * @param isOpen  是否打开  /  Whether to open the
 *
 */
- (void)setRemindTimeForType:(FunctionSetTimeType)type withStartTime:(NSString *)startTime EndTime:(NSString *)endTime Interval:(int)interval andSwitch:(BOOL)isOpen;

/*******************
 * 设置会议提醒  /  Set meeting reminders
 *
 * @param time 提醒时间 格式：yyyy:MM:dd HH:mm  /  Reminder time format: yyyy:MM:dd HH: MM
 * @param isOpen  是否打开  /  Whether to open the
 *
 */
- (void)setMeetingRemindForTime:(NSString *)time andSwitch:(BOOL)isOpen;

/*******************
 * 设置闹钟  /  Set the alarm clock
 *
 * @param arrModel 闹钟数据模型数组  /  Alarm clock data model array
 *
 */
- (void)setAlarmClockForModel:(NSArray <ZHAlarmClockModel *> *)arrModel;

/*******************
 * 发送生理周期   /Send physiological cycle
 *
 * @param begainDate    开始日期  "yyyy-MM-dd"  /   start date "yyyy-MM-dd"
 * @param menstrualLengh     经期长度   /   menstruallengh
 * @param cycleLengh       周期长度 /   cyclengh cycle length
 * @param offOn         提醒开关    /   offon alert switch
 */
-(void)sendMenstrualCycleForDate:(NSDate *)begainDate MenstrualPeriodLengh:(int)menstrualLengh AndCycleLengh:(int)cycleLengh Switch:(BOOL)offOn;

/*******************
 * 获取当前日期的经期类型 (MenstrualType)  /   Gets the menstrualtype of the current date
 *
 * @param begainDate        开始日期 "yyyy-MM-dd"   /   start date "yyyy-MM-dd"
 * @param menstrualLengh    经期长度    /   menstrual lengh
 * @param cycleLengh       周期长度     /   cycle length
 * @param chooseDate       选中的日期    /   selected date
 */
-(MenstrualType)getMenstrualForBegainDate:(NSDate *)begainDate MenstrualPeriodLengh:(int)menstrualLengh AndCycleLengh:(int)cycleLengh chooseDate:(NSDate *)chooseDate;


/*******************
 * 开始发送主题信息 /   Start sending topic information
 *
 * @param binData 主题文件的Data /   Data of theme file
 *
 */
- (void)begainSendTheme:(NSData *)binData;

#pragma mark - 多运动

/**
 *  设置设备时区    /   Set device time zone
 *  @param timeZone 时区，例如中国时区为东八区 +8   /   Time zone, for example, the Chinese time zone is the East eight zone +8
 */
-(void)setDeviceTimeZone:(int)timeZone;

/**
 *  获取历史运动记录    / Get historical movement records
 */
-(void)queryHistoricalMultiSportRecords;
/**
 *  获取今日运动记录    /   Get today's sports record
 */
-(void)queryTodayMultiSportRecords;

#pragma mark - 文件传输

/**
 *  查询OTA传输前设备状态
 *  @param version 升级文件版本号
 *  @param fileData 升级文件数据
 */
-(void)queryStatusBeforeOTATransmissionWithFileVersion:(NSString *)version FileData:(NSData *)fileData;
/**
 *  开始发送OTA文件
 *  @param binData 升级文件数据
 */
-(void)startSendOTAFile:(NSData *)binData;
/**
 *  查询表盘传输前设备状态
 *  @param dialID 表盘ID
 *  @param size 表盘Bin文件大小(单位为b)
 */
-(void)queryStatusBeforeDialTransmissionWithId:(NSString *)dialID FileSize:(uint32_t)size;
/**
 *  开始发送表盘文件
 *  @param dialData 表盘文件数据
 */
-(void)startSendDialFile:(NSData *)dialData;
/**
 *  询问设备是否需要更新AGPS  /   Ask if the device needs to update AGPs
 */
-(void)askDeviceIsneededToUpdateAGPS;
/**
 *  开始发送AGPS文件  /   Start sending AGPs file
 *  @param AGPSData AGPS文件数据    /   AGPs file data
 */
-(void)startSendAGPSFile:(NSData *)AGPSData;

#pragma mark - 设备GPS运动
/**
 *  获取手环GPS运动状态 /   Get the GPS movement status of the bracelet
 */
-(void)queryGPSStateFromDevice;
/**
 *  发送定位坐标  /   Send positioning coordinates
 *  @param location CLLocation系统坐标对象    /   system coordinate object
 */
-(void)sendLocationToDeviceWith:(CLLocation *)location;

/**
 *  SDK日志打印开关   /   SDK log print switch
 *  @param enabled 默认为NO    /   enabled is no by default
 */
-(void)switchSDKLog:(BOOL)enabled;

#pragma mark - 设备绑定

/**
 *  向设备发起绑定 /   Bind to device
 */
-(void)startBindToDevice;

/**
 *  询问设备绑定状态    /   Query device binding status
 */
-(void)queryDeviceBindingStatus;

@end
