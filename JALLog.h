//
//  JALLog.h
//  TREA
//
//  Created by Joabe Alexandre Leite on 03/09/14.
//  Copyright (c) 2014 Andre Ltda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JALLog : NSObject

/////////////////PROPERTS PARA O LOG ////////////////
@property (nonatomic) NSDate *horaImagem;
@property (nonatomic) NSDate *horaToque;
@property (nonatomic) UIImage *figura;
@property (nonatomic) int areaToque;
@property (nonatomic) int areaImagem;
@property (nonatomic) NSString *programa;
@property (nonatomic)  double tempoExposicao;
@property (nonatomic) BOOL isBotaoCerto;

@property (nonatomic) NSString *horaImagemString;
@property (nonatomic) NSString *horaToqueString;

+(NSString *)getStringDataFromDate: (NSDate* ) date;
+(NSString *)getStringHoraFromDate: (NSDate *) date;
+(NSString *) getHoraAtualComMilissegundos;

@end
