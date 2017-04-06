//
//  LTRPrograma.m
//  trea
//
//  Created by Luciano Rocha on 8/7/14.
//  Copyright (c) 2014 Luciano Rocha. All rights reserved.
//

#import "LTRPrograma.h"

@implementation LTRPrograma

-(id)initWithCoder:(NSCoder *)coder{
    
    if (self = [super init]) {
        self.nomePrograma = [coder decodeObjectForKey:@"nomePrograma"];
//        self.qtdAcertos = [coder decodeIntForKey:@"qtdAcertos"];
        self.qtdElementos = [coder decodeIntForKey:@"qtdElementos"];
        self.isFiguraUnica = [coder decodeBoolForKey:@"isFiguraUnica"];
        self.isOrdemAleatoria = [coder decodeBoolForKey:@"isOrdemAleatoria"];
        self.backgroundColor = [coder decodeObjectForKey:@"backgroundColor"];
        self.tempoAtraso = [coder decodeDoubleForKey:@"tempoAtraso"];
        self.tempoExposicao = [coder decodeDoubleForKey:@"tempoExposicao"];
        self.tempoEntreTentativa = [coder decodeDoubleForKey:@"tempoEntreTentativa"];
        self.tentativas = [coder decodeIntForKey:@"tentativas"];
        self.imagens = nil;
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)coder{
    
    [coder encodeObject:self.nomePrograma forKey:@"nomePrograma"];
    [coder encodeInt:self.qtdElementos forKey:@"qtdElementos"];
//    [coder encodeInt:self.qtdAcertos forKey:@"qtdAcertos"];
    [coder encodeBool:self.isFiguraUnica forKey:@"isFiguraUnica"];
    [coder encodeBool:self.isOrdemAleatoria forKey:@"isOrdemAleatoria"];
    [coder encodeObject:self.backgroundColor forKey:@"backgroundColor"];
    [coder encodeDouble:self.tempoAtraso forKey:@"tempoAtraso"];
    [coder encodeDouble:self.tempoExposicao forKey:@"tempoExposicao"];
    [coder encodeDouble:self.tempoEntreTentativa forKey:@"tempoEntreTentativa"];
    [coder encodeInt:self.tentativas forKey:@"tentativas"];
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"Nome-%@, Elementos-%d, isFiguraUnica-%d, isOrdemAleatoria-%d,tempoAtraso %.2f, tempoExposicao-%.2f, tempoEntreTentativa-%.2f\n", _nomePrograma, _qtdElementos, _isFiguraUnica, _isOrdemAleatoria, _tempoAtraso, _tempoExposicao, _tempoEntreTentativa ];
}

@end
