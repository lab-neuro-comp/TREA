//
//  AVFUsuario.m
//  TREA
//
//  Created by andre vinicius alves fonseca on 12/08/14.
//  Copyright (c) 2014 Andre Ltda. All rights reserved.
//

#import "AVFUsuario.h"
#import "AVFUsuario.h"

@implementation AVFUsuario

- (NSString *)description
{
    return [NSString stringWithFormat:@"nome:%@  sexo:%@  data: %@", self.idParticipante,self.sexo, self.dataNasc];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    if(self = [super init]){
        
        self.idParticipante = [aDecoder decodeObjectForKey:@"idParticipante"];
        self.sexo = [aDecoder decodeObjectForKey:@"sexo"];
        self.dataNasc = [aDecoder decodeObjectForKey:@"dataNasc"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{

    [aCoder encodeObject: _idParticipante forKey:@"idParticipante"];
    [aCoder encodeObject: _dataNasc forKey:@"dataNasc"];
    [aCoder encodeObject: _sexo forKey:@"sexo"];
}

@end
