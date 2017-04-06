//
//  Experimento.m
//  TREA
//
//  Created by andre vinicius alves fonseca on 20/08/14.
//  Copyright (c) 2014 Andre Ltda. All rights reserved.
//

#import "Experimento.h"

@implementation Experimento

-(id)initWithCoder:(NSCoder *)aDecoder{

    if(self = [super init]){
        self.nomeExperimento = [aDecoder decodeObjectForKey:@"nomeExperimento"];
        self.arrayProgramas = [aDecoder decodeObjectForKey:@"arrayProgramas"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject: _nomeExperimento forKey:@"nomeExperimento"];
    [aCoder encodeObject: _arrayProgramas forKey:@"arrayProgramas"];
}

@end
