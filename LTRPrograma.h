//
//  LTRPrograma.h
//  trea
//
//  Created by Luciano Rocha on 8/7/14.
//  Copyright (c) 2014 Luciano Rocha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTRPrograma : NSObject <NSCoding>

//@property (weak, nonatomic) NSDate * horaInicio;
//@property (weak, nonatomic) NSDate * horaFim;


@property (nonatomic) NSString * nomePrograma;

@property (nonatomic) int qtdElementos;     // qtd de botoes ativos no mesmo teste/tentativa
//@property (nonatomic) int qtdAcertos;       // qtd de vezes que apertou o botao na ordem certa

@property (nonatomic) BOOL isFiguraUnica;   // yes - apenas uma figura // no - para varias figuras sem repeticao
@property (nonatomic) BOOL isOrdemAleatoria;    // yes - figuras em ordem aleatoria // no - para figuras na ordem de selecao


@property (nonatomic) UIColor * backgroundColor;

@property (nonatomic) double tempoAtraso;     //em segundos
@property (nonatomic) double tempoExposicao;  //em milisegundos
@property (nonatomic) double tempoEntreTentativa;  //em segundos

@property (nonatomic) int tentativas;   //qtd de vezes q a viewController vai ser executada

@property (nonatomic,strong) NSMutableArray* imagens;

@end
