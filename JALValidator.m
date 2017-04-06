//
//  JALValidator.m
//  TREA
//
//  Created by Joabe Alexandre Leite on 08/09/14.
//  Copyright (c) 2014 Andre Ltda. All rights reserved.
//

#import "JALValidator.h"

@implementation JALValidator

+(BOOL)isStringVazia: (NSString *)string{
    
    //Valida se a string é vazia
    if(string == nil || string.length == 0 || [allTrim(string) length] == 0){
        return YES;
    }
    return NO;
}

@end
