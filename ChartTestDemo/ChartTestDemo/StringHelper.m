//
//  StringHelper.m
//  FinancialIPAD
//
//  Created by zsc on 13-11-25.
//  Copyright (c) 2013年 CYTX. All rights reserved.
//

#import "StringHelper.h"

@implementation StringHelper


+ (NSString *)stringFromDate:(NSDate *)date andDateFormat:(NSString*)format{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:format];
    
    
    return  [dateFormatter stringFromDate:date];
  }

//+(NSString *) stringFromString:(NSString *)str andFormat:(NSString *)format
//{
//    if ([str isKindOfClass:[NSNull class]]) {
//        return kNULLVALUE;
//    }
//    @try {
//        NSDate *date =[str deserializeJsonDateString];
//        return   [StringHelper stringFromDate:date andDateFormat:format];
//    }
//    @catch (NSException *exception) {
//        return str;
//    }
//    
//}


+(NSString*) nsNumberToThousandsString:(NSNumber*)numb{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSString *string = [formatter stringFromNumber:numb];
    
    return string;
}

+(NSString *) removeZero:(float)flt{
    int temp =(int)( flt * 100);
    int p = temp % 100;
    if (p>0) {
        return [NSString stringWithFormat:@"%.2f",flt];
    }else{
        return [NSString stringWithFormat:@"%d",(int)flt];
    }
    
}

//+(NSString *) stringFormatFromFloat:(float)flt andFormat:(NSString *)format{
//    if (flt==MAXFLOAT) {
//        return kNULLVALUE;
//    }
//    if ([format isKindOfClass:[NSNull class]] || format.length==0) {
//        NSString * rtn =[NSString stringWithFormat:@"%f",flt];
//        return rtn;
//    }
//    NSString * rtn =  [NSString stringWithFormat:format,flt];
//    return rtn;
//}
//
//+(NSString *) replaceNullString:(NSString *)str{
//    if ([str isKindOfClass:[NSNull class]] || str==nil || str.length==0) {
//        return kNULLVALUE;
//    }
//    return str;
//}

+(NSString*) convertNullJsongStringToZeroString:(NSString*)str{
    if ([str isKindOfClass:[NSNull class]] || str==nil || str.length==0) {
        return @"";
    }
    return str;
}

+(CGSize ) getTextSize:(NSString *)text withFont:(UIFont *)font{
    if ([text respondsToSelector:@selector(sizeWithFont:)]) {
        return  [text sizeWithFont:font];
    }
    else
    {
       return  [text sizeWithAttributes:@{NSFontAttributeName:font}];
    }
}

//+(NSNumber*)getIntValueFromDicValue:(id)value{
//    int rtn ;
//    
//    if ([value isKindOfClass:[NSNull class]]) {
//        rtn = kInValidateIntValue;
//    }else{
//        rtn =[value intValue];
//    }
//    
//    return [NSNumber numberWithInt:rtn];
//}

+(NSNumber*)getFloatValueFromDicValue:(id)value{
    float rtn ;
    
    if ([value isKindOfClass:[NSNull class]]) {
        rtn = MAXFLOAT;
    }else{
        rtn =[value floatValue];
    }
    
    return [NSNumber numberWithFloat:rtn];
}

+(NSString *)getMoneyStr:(float) number
{
    NSNumberFormatter *yformatter = [[NSNumberFormatter alloc] init];
    yformatter.numberStyle = NSNumberFormatterDecimalStyle;
    
    NSString *value = [yformatter stringFromNumber:[NSNumber numberWithDouble:ceil(number) ]];

    return [NSString stringWithFormat:@"¥ %@", value];
}  
@end
