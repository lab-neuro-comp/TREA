//
//  AVFUsuario.h
//  TREA
//
//  Created by andre vinicius alves fonseca on 12/08/14.
//  Copyright (c) 2014 Andre Ltda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AVFUsuario : NSObject <NSCoding>

@property (nonatomic) NSString* idParticipante;
@property (nonatomic) NSString* sexo;
@property (nonatomic) NSDate* dataNasc;
//@property(nonatomic) NSMutableArray *uu;

@end
