//
//  JALLog.m
//  TREA
//
//  Created by Joabe Alexandre Leite on 03/09/14.
//  Copyright (c) 2014 Andre Ltda. All rights reserved.
//

#import "JALLog.h"

@implementation JALLog


+(NSString *)getStringDataFromDate: (NSDate* ) date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
    //    [dateFormatter setDateFormat:@"EEE, d MMM yyyy HH:mm:ss z"];
    [dateFormatter setDateFormat:@"dd'-'MM'-'yyyy'"];
    
    //    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    return dateString;
}

+(NSString *)getStringHoraFromDate: (NSDate *) date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setLocale:[[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"] autorelease]];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    
    //    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSString *dateString = [dateFormatter stringFromDate:date];
    
    //    return [dateString stringByAppendingString:[NSString stringWithFormat:@".%@",[self getStringMilisegundos]]];
    
    return dateString;
}

//Retorna o milisegundo da hora atual
+(NSString *) getHoraAtualComMilissegundos{
    
    NSString *temp = [NSString stringWithFormat:@"%.3f", CFAbsoluteTimeGetCurrent()];
    NSArray *array = [temp componentsSeparatedByString:@"."];
    NSString *ms = [array objectAtIndex:1];
    
    return [NSString stringWithFormat:@"%@:%@", [self getStringHoraFromDate:[NSDate date]], ms];
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@,%@,%d,%d ",_horaImagemString,_horaToqueString, _areaToque, _areaImagem];
}

@end
