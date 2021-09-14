//
//  CustomDialSDK.h
//  CustomDialSDK
//
//  Created by 腾飞 on 2020/9/28.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomDialSDK : NSObject

/*******************
 * 实例化  /   Instantiation
 *
 */
+ (instancetype)sharedUartManager;

/*******************
 * 获取效果图    /   Get renderings
 *
 * @param BJImage 背景图   /   Background image
 * @param textImage 显示时间等文字图    /   displays time and other text graphs
 * @param color 需要更改的文字颜色   /   text color to be changed
 *
 * @return 新的效果图    /   new rendering
 *
 */
- (UIImage *)getEffectPictureForImage:(UIImage *)BJImage TextImage:(UIImage *)textImage setColor:(UIColor *)color;

/*******************
 * 更改颜色和背景后返回的总数据   /   Total data returned after changing color and background
 *
 * @param bgImage 更改的背景图    /   Background image change
 * @param setColor 更改的颜色值   /   Color value changed
 * @param binData  更改之前的数据  /   data before changing
 *
 * @return 返回更改后的数据 /   the changed data
 *
 */
- (NSData *)getCustonClockDialDataWithBGImage:(UIImage *)bgImage textImage:(UIImage *)textImage setColor:(UIColor *)setColor ForData:(NSData *)binData;

@end
