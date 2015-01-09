//
//  StringHelper.h
//  FinancialIPAD
//
//  Created by zsc on 13-11-25.
//  Copyright (c) 2013年 CYTX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface StringHelper : NSObject

+ (NSString *)stringFromDate:(NSDate *)date andDateFormat:(NSString*)format;
/**只用来处理NSDate*/
+(NSString *) stringFromString:(NSString *)str andFormat:(NSString *)format;

+(NSString *) replaceNullString:(NSString *)str;

+(NSString*) convertNullJsongStringToZeroString:(NSString*)str;

+(NSString *) stringFormatFromFloat:(float)flt andFormat:(NSString *)format;

/**千分位*/
+(NSString*) nsNumberToThousandsString:(NSNumber*)numb;

/**用来处理float 是否保留小数点。
 规则：当小数不是零时，则取2位小数，如果小数位都是零，则只取前面整数*/
+(NSString *) removeZero:(float)flt;

/**根据字体返回字体的CGSize
 */
+(CGSize)getTextSize:(NSString *)text withFont:(UIFont *)font;

+(NSNumber*)getIntValueFromDicValue:(id)value;

+(NSNumber*)getFloatValueFromDicValue:(id)value;

/**返回费用 
 */
+(NSString *)getMoneyStr:(float) number;
@end
