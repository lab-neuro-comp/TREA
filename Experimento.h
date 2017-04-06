//
//  Experimento.h
//  TREA
//
//  Created by andre vinicius alves fonseca on 20/08/14.
//  Copyright (c) 2014 Andre Ltda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Experimento : NSObject <NSCoding>

@property(nonatomic) NSString *nomeExperimento;
@property(nonatomic) NSMutableArray *arrayProgramas;

@end
