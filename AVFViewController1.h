//
//  AVFViewController1.h
//  TREA
//
//  Created by andre vinicius alves fonseca on 08/08/14.
//  Copyright (c) 2014 Andre Ltda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVFUsuario.h"
#import "Experimento.h"
#import "LTRViewControllerBotoes.h"
#import "JALValidator.h"

@interface AVFViewController1 : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak,nonatomic) IBOutlet UITableView *listaPaciente;
@property (weak,nonatomic) IBOutlet UITableView *listaExperimentos;

@property(nonatomic)NSMutableArray *pacientes;
@property(nonatomic)NSMutableArray *nomeExperimentos;

@property (weak, nonatomic) IBOutlet UIButton *BotaoEditar;
@property (weak, nonatomic) IBOutlet UIButton * botaoEditarTableViewExperimentos;
@property (nonatomic) IBOutlet UIButton * botaoEditarTableViewProgramas;

- (IBAction)BotaoEditarTap:(id)sender;
- (IBAction)addPaciente:(id)sender;
- (IBAction)addExperimento:(id)sender;

@property(nonatomic) NSString *nomeExperimentador;
@property(nonatomic) NSString *sessaoValue;

@property (weak, nonatomic) IBOutlet UITextField *sessao;
@property (weak, nonatomic) IBOutlet UITextField *experimentador;

@property(nonatomic) AVFUsuario *usuario;
@property(nonatomic) Experimento *experimento;
//@property(nonatomic) Programa *programa;

@property(nonatomic) NSMutableArray *arrayUsuarios;
@property(nonatomic) NSMutableArray *arrayExperimentos;
@property(nonatomic) NSMutableArray *arrayProgramas;

-(IBAction)comecarTeste:(id)sender;
-(void)dismissPopup;

@end
