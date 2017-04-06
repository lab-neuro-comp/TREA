//
//  JALValidator.h
//  TREA
//
//  Created by Joabe Alexandre Leite on 08/09/14.
//  Copyright (c) 2014 Andre Ltda. All rights reserved.
//

#import <Foundation/Foundation.h>

//Comparar se String é vazia
#define allTrim( object ) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ]

@interface JALValidator : NSObject


+(BOOL)isStringVazia: (NSString *)string;

@end
