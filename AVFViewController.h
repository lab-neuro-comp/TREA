//
//  AVFViewController.h
//  TREA
//
//  Created by andre vinicius alves fonseca on 13/08/14.
//  Copyright (c) 2014 Andre Ltda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELCImagePickerHeader.h"
//#import "Programa.h"
#import "LTRPrograma.h"
#import "JALValidator.h"


@interface AVFViewController : UIViewController
- (IBAction)salvarPrograma:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *salvarPrograma;

@property (weak, nonatomic) IBOutlet UITextField *nomePrograma;
@property (weak, nonatomic) IBOutlet UITextField *numeroFiguras;
@property (weak, nonatomic) IBOutlet UITextField *tentativas;
@property (weak, nonatomic) IBOutlet UITextField *elementosPossiveis;

@property (weak, nonatomic) IBOutlet UITextField *tempoExposicao;
@property (weak, nonatomic) IBOutlet UITextField *tempoAtraso;
@property (weak, nonatomic) IBOutlet UITextField *tempoEntreTentativas;

@property (weak, nonatomic) IBOutlet UIStepper *stepperTempoExposto;
@property (weak, nonatomic) IBOutlet UIStepper *stepperTempoAtraso;
@property (weak, nonatomic) IBOutlet UIStepper *stepperTempoEntreTentativas;

@property (weak, nonatomic) IBOutlet UISegmentedControl *isFiguraUnica;
@property (weak, nonatomic) IBOutlet UISegmentedControl *isOrdemAleatoria;

@property(nonatomic)BOOL salvo;

@property(nonatomic)UIColor *backGroundColor;
@property(nonatomic) NSString *savee;

//tables
@property (weak, nonatomic) IBOutlet UITableView *tabelaImagens;
@property (weak, nonatomic) IBOutlet UITableView *tabelaProgramas;


- (IBAction)voltarExperimento:(id)sender;

@property(nonatomic) NSMutableArray *caracteristicaPrograma;
@property(nonatomic) LTRPrograma *programa;

//criando string que serao convertidas em int depois por causa do singleton
@property(nonatomic) NSString *figuraUnica;
@property(nonatomic) NSString *aleatorio;


//@property(nonatomic) NSMutableArray *nomeProgramas;


- (IBAction)amarelo:(id)sender;
- (IBAction)azul:(id)sender;
- (IBAction)verdeGrama:(id)sender;
- (IBAction)cinzaClaro:(id)sender;
- (IBAction)roxo:(id)sender;
- (IBAction)vermelho:(id)sender;
- (IBAction)azulClaro:(id)sender;
- (IBAction)verdeFlorescente:(id)sender;
- (IBAction)cinzaEscuro:(id)sender;
- (IBAction)verdeMaisClaro:(id)sender;
- (IBAction)rosaPink:(id)sender;
- (IBAction)azulPiscina:(id)sender;
- (IBAction)preto:(id)sender;
- (IBAction)branco:(id)sender;
- (IBAction)azulEscuro:(id)sender;
- (IBAction)semCor:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *amarelo;
@property (weak, nonatomic) IBOutlet UIButton *azul;
@property (weak, nonatomic) IBOutlet UIButton *verdeGrama;
@property (weak, nonatomic) IBOutlet UIButton *cinzaClaro;
@property (weak, nonatomic) IBOutlet UIButton *roxo;
@property (weak, nonatomic) IBOutlet UIButton *vermelho;
@property (weak, nonatomic) IBOutlet UIButton *azulClaro;
@property (weak, nonatomic) IBOutlet UIButton *verdeFlorecente;
@property (weak, nonatomic) IBOutlet UIButton *cinzaEscuro;
@property (weak, nonatomic) IBOutlet UIButton *verdeMaisClaro;
@property (weak, nonatomic) IBOutlet UIButton *rosapink;
@property (weak, nonatomic) IBOutlet UIButton *azulPiscina;
@property (weak, nonatomic) IBOutlet UIButton *preto;
@property (weak, nonatomic) IBOutlet UIButton *branco;
@property (weak, nonatomic) IBOutlet UIButton *azulEscuro;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;



@end
