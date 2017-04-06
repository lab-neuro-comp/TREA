//
//  LTRViewControllerBotoes.m
//  trea
//
//  Created by Luciano Rocha on 8/7/14.
//  Copyright (c) 2014 Luciano Rocha. All rights reserved.
//

#import "LTRViewControllerBotoes.h"

@interface LTRViewControllerBotoes ()

@property (nonatomic) NSMutableArray * numerosRandomicos;           //array com a ordem dos botoes
@property (nonatomic) NSMutableArray * arrayDeBotoes;

@property(nonatomic) UIButton * btnInicio;

@property(nonatomic) BOOL isFinishedPrograma;
@property (nonatomic) BOOL isBotaoCorreto;

@property(nonatomic) int contadorProgramas;
@property (nonatomic) int contadorDeExibicao;
@property (nonatomic) int contadorTentativas;

@property(nonatomic) double tempoTemp;

@property (nonatomic) NSMutableArray* fotosAleatorias;

//---------PROPERTS PARA LOG-------------//
@property (nonatomic) NSMutableArray *arrayDeLogs;
@property (nonatomic) NSString *stringFinal;
@property (nonatomic) NSDate *dataInicio;
@property (nonatomic) NSString *horaInicioString;
@property (nonatomic) BOOL isFimExperimento;
@property (nonatomic) NSString *pathFileLog;

@end

@implementation LTRViewControllerBotoes

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //Inicialização
        _contadorDeExibicao = 1;
        _arrayDeBotoes = [[NSMutableArray alloc]init];
        _numerosRandomicos = [[NSMutableArray alloc]init];  //inicializaçao array de numeros randomicos
        _contadorProgramas = 0;
        _isFinishedPrograma = NO;
        _log = [[JALLog alloc]init];
        _arrayDeLogs = [[NSMutableArray alloc]init];
//        _tableLog = [[UITableView alloc]initWithFrame: CGRectMake(15, 15, 1000, 500) style:(UITableViewStylePlain)];
	}
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	[self hideButtons];
    
    _tempoTemp = _programa.qtdElementos * (_programa.tempoExposicao + _programa.tempoAtraso) + _programa.tempoEntreTentativa;
    
    _contadorTentativas = 0;
    _programa = [_arrayProgramas objectAtIndex:0];
    
    //LOG
    if(_stringFinal == nil){
        _stringFinal = @"";
    }
    _stringFinal = [_stringFinal stringByAppendingString:[self getCabecalho]];
    _dataInicio = [NSDate date];
    _horaInicioString = [JALLog getHoraAtualComMilissegundos];
//    _tableLog.delegate = self;
//    _tableLog.dataSource = self;
    
    
    //codigo para registrar a nib
//    [self.tableLog registerNib:[UINib nibWithNibName:@"JALCustomTableViewCell"
//                                                 bundle:[NSBundle mainBundle]]
//           forCellReuseIdentifier:@"JALCustomTableViewCell"];

    [self addButtonInicio];
}

-(void) addButtonInicio{
    
    self.view.backgroundColor = [UIColor whiteColor];
    _btnInicio = [[UIButton alloc]init];
    [_btnInicio setFrame:CGRectMake(0, 0, 1024, 768)];
    
    // propriedade de texto do botao
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [NSString stringWithFormat:@"Toque para iniciar o %d˚ programa", _contadorProgramas+1];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:25];
    label.backgroundColor = [UIColor clearColor];
    _btnInicio.alpha = 0;
    [_btnInicio addSubview:label];
    
	//codigo para delay de animaçao
    [UIView animateWithDuration:1 animations:^{
        _btnInicio.alpha  = 1;
    }];
    
    [_btnInicio addTarget:self action:@selector(buttonInicio) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_btnInicio];
	
}

-(void) buttonInicio{
    
	[UIView animateWithDuration:1 animations:^{
        self.view.backgroundColor = _programa.backgroundColor;
		_btnInicio.alpha  = 0;
	}];
    
    [self performSelector:@selector(teste) withObject:nil afterDelay:_programa.tempoAtraso+1];
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) hideButtons{
    
    [_button1 setAlpha:0];
    [_button2 setAlpha:0];
    [_button3 setAlpha:0];
    [_button4 setAlpha:0];
    [_button5 setAlpha:0];
    [_button6 setAlpha:0];
    [_button7 setAlpha:0];
    [_button8 setAlpha:0];
    [_button9 setAlpha:0];
    [_button10 setAlpha:0];
    [_button11 setAlpha:0];
    [_button12 setAlpha:0];
    [_button13 setAlpha:0];
    [_button14 setAlpha:0];
    [_button15 setAlpha:0];
    [_button16 setAlpha:0];
    
}

-(void) showButtons{
    
    [_button1 setAlpha:1];
    [_button2 setAlpha:1];
    [_button3 setAlpha:1];
    [_button4 setAlpha:1];
    [_button5 setAlpha:1];
    [_button6 setAlpha:1];
    [_button7 setAlpha:1];
    [_button8 setAlpha:1];
    [_button9 setAlpha:1];
    [_button10 setAlpha:1];
    [_button11 setAlpha:1];
    [_button12 setAlpha:1];
    [_button13 setAlpha:1];
    [_button14 setAlpha:1];
    [_button15 setAlpha:1];
    [_button16 setAlpha:1];
}

-(void) deleteButtonsBackground{
    
    [_button1 setBackgroundImage:nil forState:UIControlStateNormal];
    [_button2 setBackgroundImage:nil forState:UIControlStateNormal];
    [_button3 setBackgroundImage:nil forState:UIControlStateNormal];
    [_button4 setBackgroundImage:nil forState:UIControlStateNormal];
    [_button5 setBackgroundImage:nil forState:UIControlStateNormal];
    [_button6 setBackgroundImage:nil forState:UIControlStateNormal];
    [_button7 setBackgroundImage:nil forState:UIControlStateNormal];
    [_button8 setBackgroundImage:nil forState:UIControlStateNormal];
    [_button9 setBackgroundImage:nil forState:UIControlStateNormal];
    [_button10 setBackgroundImage:nil forState:UIControlStateNormal];
    [_button11 setBackgroundImage:nil forState:UIControlStateNormal];
    [_button12 setBackgroundImage:nil forState:UIControlStateNormal];
    [_button13 setBackgroundImage:nil forState:UIControlStateNormal];
    [_button14 setBackgroundImage:nil forState:UIControlStateNormal];
    [_button15 setBackgroundImage:nil forState:UIControlStateNormal];
    [_button16 setBackgroundImage:nil forState:UIControlStateNormal];
	
}

-(void) disableButtons{
    
    [_button1 setEnabled:NO];
    [_button2 setEnabled:NO];
    [_button3 setEnabled:NO];
    [_button4 setEnabled:NO];
    [_button5 setEnabled:NO];
    [_button6 setEnabled:NO];
    [_button7 setEnabled:NO];
    [_button8 setEnabled:NO];
    [_button9 setEnabled:NO];
    [_button10 setEnabled:NO];
    [_button11 setEnabled:NO];
    [_button12 setEnabled:NO];
    [_button13 setEnabled:NO];
    [_button14 setEnabled:NO];
    [_button15 setEnabled:NO];
    [_button16 setEnabled:NO];
    
}

- (IBAction)view1:(id)sender {
    NSLog(@"botao 1");
    _log.areaToque = 1;
    [self touchButton];
}

- (IBAction)view2:(id)sender {
    NSLog(@"botao 2" );
    _log.areaToque = 2;
    [self touchButton];
}

- (IBAction)view3:(id)sender {
    NSLog(@"botao 3");
    _log.areaToque = 3;
    [self touchButton];
}

- (IBAction)view4:(id)sender {
    NSLog(@"botao 4");
    _log.areaToque = 4;
    [self touchButton];
}

- (IBAction)view5:(id)sender {
    NSLog(@"botao 5");
    _log.areaToque = 5;
    [self touchButton];
}

- (IBAction)view6:(id)sender {
    NSLog(@"botao 6");
    _log.areaToque = 6;
    [self touchButton];
}

- (IBAction)view7:(id)sender {
    NSLog(@"botao 7");
    _log.areaToque = 7;
    [self touchButton];
}

- (IBAction)view8:(id)sender {
    NSLog(@"botao 8");
    _log.areaToque = 8;
    [self touchButton];
}

- (IBAction)view9:(id)sender {
    NSLog(@"botao 9");
    _log.areaToque = 9;
    [self touchButton];
}

- (IBAction)view10:(id)sender {
    NSLog(@"botao 10");
    _log.areaToque = 10;
    [self touchButton];
}

- (IBAction)view11:(id)sender {
    NSLog(@"botao 11");
    _log.areaToque = 11;
    [self touchButton];
}

- (IBAction)view12:(id)sender {
    NSLog(@"botao 12");
    _log.areaToque = 12;
    [self touchButton];
}

- (IBAction)view13:(id)sender {
    NSLog(@"botao 13");
    _log.areaToque = 13;
    [self touchButton];
}

- (IBAction)view14:(id)sender {
    NSLog(@"botao 14");
    _log.areaToque = 14;
    [self touchButton];
}

- (IBAction)view15:(id)sender {
    NSLog(@"botao 15");
    _log.areaToque = 15;
    [self touchButton];
}

- (IBAction)view16:(id)sender {
    NSLog(@"botao 16");
    _log.areaToque = 16;
    [self touchButton];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

/*
 Metodo para gerar um array de 16 posicoes em ordem - é usado para quantidade de botoes na tela
 */
-(NSMutableArray *) getArrayPreenchido{
    
    NSMutableArray *numbers = [[NSMutableArray alloc]init];
    NSInteger i = 0;
    
    for ( i = 1; i <= 16; i++) {
        [numbers addObject: [NSNumber numberWithInteger:i]];
    }
    return numbers;
}

/*
 Randomiza ordem de um array populado (getArrayPreechido())
*/
-(NSMutableArray*)shuffledArray{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self.getArrayPreenchido count]];
    NSMutableArray *copy = [self.getArrayPreenchido mutableCopy];
    
    while ([copy count] > 0)
    {
        int index = arc4random() % [copy count];
        id objectToMove = [copy objectAtIndex:index];
        [array addObject: (NSNumber *) objectToMove];
        
        [copy removeObjectAtIndex:index];
    }

    _numerosRandomicos = array;
    return array;
}


-(NSMutableArray*)shuffledFotos:(NSMutableArray*)array {
    
    NSMutableArray* retorno = [[NSMutableArray alloc]initWithArray:array];
    
    for (int x = 0; x < [retorno count]; x++) {
        int randInt = (arc4random() % ([retorno count] - x)) + x;
        [retorno exchangeObjectAtIndex:x withObjectAtIndex:randInt];
    }
    return retorno;
}

/*
metodo que seta as imagens como  background dos botoes
as imagens sao setadas para todos os estados do botoes
 */
-(void) setBackgroundBotoes{
    
    [self deleteButtonsBackground];
    
    NSArray * array = [[NSArray alloc]initWithArray:[self shuffledArray]];
    _arrayDeBotoes = [[NSMutableArray alloc]init];
    
    //trecho de codigo para imagens variadas
    if (!_programa.isOrdemAleatoria) {
        
        
        if (!_programa.isFiguraUnica) {
            
            for (int i = 0; i < _programa.qtdElementos; i++) {
                int cont = _contadorTentativas * _programa.qtdElementos;
                
                UIButton * button = [self retornaBotao:[array objectAtIndex:i]];
                
                [button setBackgroundImage:[_programa.imagens objectAtIndex:(cont == 0 ? i : i + cont)] forState:UIControlStateNormal];
                [button setBackgroundImage:[_programa.imagens objectAtIndex:(cont == 0 ? i : i + cont)] forState:UIControlStateDisabled];
                [button setBackgroundImage:[_programa.imagens objectAtIndex:(cont == 0 ? i : i + cont)] forState:UIControlStateHighlighted];
                
                [_arrayDeBotoes addObject:button];
                NSLog(@"botao n:%@", [array objectAtIndex:i]);
            }
            
        }else{//trecho para imagem unica
            
            for (int i = 0; i < _programa.qtdElementos; i++) {
                UIButton * button = [self retornaBotao:[array objectAtIndex:i]];
                
                [button setBackgroundImage:[_programa.imagens objectAtIndex:_contadorTentativas] forState:UIControlStateNormal];
                [button setBackgroundImage:[_programa.imagens objectAtIndex:_contadorTentativas] forState:UIControlStateDisabled];
                [button setBackgroundImage:[_programa.imagens objectAtIndex:_contadorTentativas] forState:UIControlStateHighlighted];
                [_arrayDeBotoes addObject:button];
                NSLog(@"botao n:%@", [array objectAtIndex:i]);
            }
        }
    }else{ //ordem das imagens aleatoria
        
        //NSMutableArray* arrayAleatorioImagens = [self shuffledFotos:_programa.imagens.copy];
        for (int i = 0; i < _programa.qtdElementos; i++) {
            int cont = _contadorTentativas * _programa.qtdElementos;

            UIButton * button = [self retornaBotao:[array objectAtIndex:i]];
            
            [button setBackgroundImage:[_fotosAleatorias objectAtIndex:(cont == 0 ? i : i + cont)] forState:UIControlStateNormal];
            [button setBackgroundImage:[_fotosAleatorias objectAtIndex:(cont == 0 ? i : i + cont)] forState:UIControlStateDisabled];
            [button setBackgroundImage:[_fotosAleatorias objectAtIndex:(cont == 0 ? i : i + cont)] forState:UIControlStateHighlighted];
            
            [_arrayDeBotoes addObject:button];
            NSLog(@"botao n:%@", [array objectAtIndex:i]);
        }
    }
}

/*
 Muda o estado do ultimo botao do array
 Coloca os botoes anteriores ao ultimo desabilitados para que o usuario nao toque
*/
-(void) showButton  /*eIndex:(NSNumber*) index*/{

    NSLog(@"contador de exibiçao : %d", _contadorDeExibicao);
    
    //LOG
    _log.horaImagem = [NSDate date];
    _log.horaImagemString = [JALLog getHoraAtualComMilissegundos];
    _log.areaToque = 0;
    
    for (int i = 0; i < _contadorDeExibicao; i++) {
        UIButton * b = [_arrayDeBotoes objectAtIndex:i];
        
        [b setEnabled:YES];
        [b setAlpha:1];
        
        if (i > 0) {
            UIButton *button = [_arrayDeBotoes objectAtIndex:i-1];
            [button setEnabled:NO];
        }
    }
    
    [self performSelector:@selector(hideButtons) withObject:nil afterDelay:_programa.tempoExposicao];
    [self performSelector:@selector(saveLog) withObject:nil afterDelay:_programa.tempoExposicao];
    
    _contadorDeExibicao++;
}

/*
 Executa a tentativa de um programa que esta alocado na property
 Pode ser executado varias vezes, dependendo da configuraçao do experimento
*/
-(void) teste{
    _contadorDeExibicao = 1;
	
//    self.view.backgroundColor = _programa.backgroundColor;
    
    NSLog(@"Contador de tentativas : %d", _contadorTentativas);
	//    double j =  _programa.tempoAtraso;
    double j = 0;
    
    if(_contadorTentativas < _programa.tentativas ){
        [self setBackgroundBotoes];
        for (int i = 0; i < _programa.qtdElementos; i++) {
            [self performSelector:@selector(showButton) withObject:nil afterDelay:j];
            j+= _programa.tempoAtraso + _programa.tempoExposicao;
            
        }
        _contadorTentativas +=1;
    }else{
        NSLog(@"chamou a tentiva mas nao executou");
        
    }
	//    _contadorTentativas +=1;
    
    //if para executar segunda tentativa sem toque
    if(_contadorTentativas < _programa.tentativas ){
        //NSLog(@"chamou teste do touch button");
        double tempo = (_programa.qtdElementos * (_programa.tempoExposicao + _programa.tempoAtraso)) + _programa.tempoEntreTentativa - _programa.tempoAtraso;
        NSLog(@" tempo:%f", tempo );
        [self performSelector:@selector(teste) withObject:nil afterDelay:tempo];
        
    }else{
        NSLog(@"chamou a tentiva mas nao executou 2");
        _isFinishedPrograma = YES;
        double tempo = (_programa.qtdElementos * (_programa.tempoExposicao + _programa.tempoAtraso)) + _programa.tempoEntreTentativa - _programa.tempoAtraso;
		
		//        [self chamarBotaoInicio:tempo];
        [self performSelector:@selector(chamarBotaoInicio) withObject:nil afterDelay:tempo];
    }
}

/*
 Metodo que verifica o toque no botao (ultimo do array é o unico que pode ser tocado)
 se toque correto - continua a execuçao do teste
 se toque errado - pula para proxima tentativa
*/
-(void)touchButton{
    _isBotaoCorreto = YES;
    
    //LOG
    _log.horaToque = [NSDate date];
    _log.horaToqueString = [JALLog getHoraAtualComMilissegundos];
    [self saveLog];
    
    [self hideButtons];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    double j = _programa.tempoAtraso;
    for (int i = (_contadorDeExibicao -1); i < _programa.qtdElementos; i++) {
        [self performSelector:@selector(showButton) withObject:nil afterDelay:j];
        j+= _programa.tempoAtraso + _programa.tempoExposicao;
    }
    
    //Valida se acabou os elementos da tentativa
    if(_contadorDeExibicao - 1 == _programa.qtdElementos){
        NSLog(@"entrou no primeiro if do touch button");
        //_contadorTentativas +=1;
        if(_contadorTentativas < _programa.tentativas){
            NSLog(@"chamou teste do touch button");
            [self performSelector:@selector(teste) withObject:nil afterDelay:_programa.tempoEntreTentativa];
            
        }else{
            NSLog(@"Acabou o programa touch button");
            
            [self performSelector:@selector(chamarBotaoInicio) withObject:nil afterDelay:_programa.tempoEntreTentativa];
        }
    }
    else if (_contadorDeExibicao -1 <= _programa.qtdElementos){
        double tempo = (_programa.qtdElementos - _contadorDeExibicao+1) * (_programa.tempoExposicao + _programa.tempoAtraso) + _programa.tempoEntreTentativa;
        NSLog(@"entrou no else do touch button tempo:%f", tempo );
        [self performSelector:@selector(teste) withObject:nil afterDelay:tempo];
    }
}

/*
 Chama o botao de inicio de programa
 tem que ser tocado para iniciar a execucao do programa
*/
-(void)chamarBotaoInicio{
    //if de validacao
    _contadorProgramas++;
    if(_contadorProgramas <_arrayProgramas.count){
        _programa = nil;
        _programa = [_arrayProgramas objectAtIndex:_contadorProgramas];
        _contadorTentativas = 0;
        _contadorDeExibicao = 1;
        self.view.backgroundColor = [UIColor whiteColor];
        [self addButtonInicio];
        NSLog(@"Chamando proximo programa");
    }else{
        _isFimExperimento = YES;
        [self addButtonFim];
    }
}

-(void) addButtonFim{
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self saveToCsv];
    for (UILabel *subview in [_btnInicio subviews]) {
        [subview removeFromSuperview];
    }
    
    _btnInicio.frame = CGRectMake(631, 690, 275, 45);
    [[_btnInicio layer] setBorderWidth:1.0f];
    [[_btnInicio layer] setBorderColor:[UIColor blueColor].CGColor];
    

    // propriedade de texto do botao
//    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 550, 88)];
//    label.textAlignment = NSTextAlignmentCenter;
//    label.text = @"Toque para voltar ao menu inicial";
//    label.textColor = [UIColor blackColor];
//    label.font = [UIFont systemFontOfSize:25];
//    label.backgroundColor = [UIColor clearColor];
    _btnInicio.alpha = 0;
    [_btnInicio setTitle:@"Voltar" forState:UIControlStateNormal];
    [_btnInicio setTitleColor: [UIColor blueColor] forState:UIControlStateNormal];
    
//    [_btnInicio addSubview:label];

    //codigo para delay de animaçao
    [UIView animateWithDuration:1 animations:^{
        self.view.backgroundColor = [UIColor whiteColor];
        _btnInicio.alpha  = 1;
    }];
    
    [_btnInicio addTarget:self action:@selector(buttonFim)forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_btnInicio];
    [self mostrarWebView];
    [self.view addSubview:[self createButtonSendEmail]];
}

-(void) buttonFim{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
 Retorna o botao referente ao numero passado como parametro
*/
- (UIButton*) retornaBotao: (NSNumber*) numero{
    
    int num = [numero intValue];
    switch (num) {
        case 1:
            return self.button1;
            break;
        case 2:
            return self.button2;
            break;
        case 3:
            return self.button3;
            break;
        case 4:
            return self.button4;
            break;
        case 5:
            return self.button5;
            break;
        case 6:
            return self.button6;
            break;
        case 7:
            return self.button7;
            break;
        case 8:
            return self.button8;
            break;
        case 9:
            return self.button9;
            break;
        case 10:
            return self.button10;
            break;
        case 11:
            return self.button11;
            break;
        case 12:
            return self.button12;
            break;
        case 13:
            return self.button13;
            break;
        case 14:
            return self.button14;
            break;
        case 15:
            return self.button15;
            break;
        case 16:
            return self.button16;
            break;
        default:
            return nil;
            break;
    }
	
}

/*
 Verifica o toque na tela durante a execuçao do teste(), 
 caso exista, pula para proxima tentativa ou proximo programa
*/
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if(_isFimExperimento){
        return;
    }
    _isBotaoCorreto = NO;
    
    //LOG
    _log.horaToque = [NSDate date];
    _log.horaToqueString = [JALLog getHoraAtualComMilissegundos];
    for (UITouch *toque in touches) {
        _log.areaToque = [self getAreaButtonByCGPoint:[toque locationInView:self.view]];
    }
    [self saveLog];
    
    
    NSLog(@"entrou no touchsbegan");
    [self hideButtons];
	
    //cancela a execucao dos metodos agendados do programa
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    if(_contadorTentativas < _programa.tentativas){
        [self performSelector:@selector(teste) withObject:nil afterDelay:_programa.tempoEntreTentativa];
        
    }else{
        NSLog(@"Acabou o programa touchBegan");
        double tempo = _programa.tempoEntreTentativa;
        [self performSelector:@selector(chamarBotaoInicio) withObject:nil afterDelay:tempo];
    }
    
    for (UITouch *toque in touches) {
        [self getAreaButtonByCGPoint:[toque locationInView:self.view]];
        NSLog(@"area tocada: %d", [self getAreaButtonByCGPoint:[toque locationInView:self.view]]);
    }
}

/*
 Retorna a area clicada pelo usuario
*/
-(int) getAreaButtonByCGPoint: (CGPoint) toque{
    
    int x = 0;
    int y = 0;
    
    if (toque.x < 256) {
        x =1;
    }else if(toque.x < 512){
        x = 2;
    }else if (toque.x < 768){
        x = 3;
    }else{
        x = 4;
    }
    if (toque.y < 192) {
        y = 0;
    }else if(toque.y < 384){
        y = 1;
    }else if (toque.y < 576){
        y = 2;
    }else{
        y = 3;
    }
    int area = y*4 + x;
	
    return area;
}

//Salva as informacoes no LOG
-(void)saveLog{
    
    if(_stringFinal == nil){
        _stringFinal = @"";
    }
    
    UIButton *b = [_arrayDeBotoes objectAtIndex:_contadorDeExibicao -2];
    _log.areaImagem = [self getAreaButtonByCGPoint:b.frame.origin];
    
    //Não tocou
    if (_log.areaToque == 0) {
        _stringFinal  = [_stringFinal  stringByAppendingFormat:@"%@;%@;%@;%@;%@;%@;%@;%@;%@;%.3f;%@;%@;%d\n",
                            _experimentador,_sessao, _usuario.idParticipante, [JALLog getStringDataFromDate:_dataInicio], _horaInicioString, _log.horaImagemString, @"-", @"-", _programa.nomePrograma, _programa.tempoAtraso, @"Não tocou", @"Não tocou", _log.areaImagem];
   
    }else{
    
    _stringFinal = [_stringFinal  stringByAppendingFormat:@"%@;%@;%@;%@;%@;%@;%@;%f;%@;%.3f;%@;%d;%d\n",
                    _experimentador,_sessao, _usuario.idParticipante, [JALLog getStringDataFromDate:_dataInicio], _horaInicioString, _log.horaImagemString, _log.horaToqueString, [_log.horaToque timeIntervalSinceDate:_log.horaImagem], _programa.nomePrograma, _programa.tempoAtraso, _isBotaoCorreto == YES ? @"CERTO" : @"ERRADO",_log.areaToque, _log.areaImagem];
    }
    
    _log.programa = _programa.nomePrograma;
    _log.tempoExposicao = _programa.tempoExposicao;
    _log.isBotaoCerto = _isBotaoCorreto;
    [_arrayDeLogs addObject:_log];
    _log = nil;
    _log = [[JALLog alloc]init];
    
}

//Salvando CSV
- (void)saveToCsv{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = [paths objectAtIndex:0];
    NSString *outputFileName = [docDirectory stringByAppendingPathComponent:@"/logTeste.csv"];
    
    NSLog(@"%@", outputFileName);
    
    NSError *csvError = NULL;
    
    //We write the string to a file and assign it's return to a boolean
    //    BOOL written = [outputString writeToFile:outputFileName atomically:YES encoding:NSUTF8StringEncoding error:&csvError];
    
    NSLog(@"String final: %@", _stringFinal );
    BOOL written = [_stringFinal  writeToFile:outputFileName atomically:YES encoding:NSUTF8StringEncoding error:&csvError];
    
    //If there was a problem saving we show the error if not show success and file path
    if (!written)
        NSLog(@"write failed, error=%@", csvError);
    else{
        NSLog(@"Saved! File path = %@", outputFileName);
        _pathFileLog = outputFileName;
    }
}

-(NSString *) getCabecalho{
    return @"experimentador; sessao; sujeito; data de inicio; hora de inicio; hora exibicao imagem; hora toque na tela; tempo de reacao; programa; tempo de Atraso; status do toque; area do toque; area da imagem\n";
}

-(void)mostrarWebView{
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(35, 28, 955, 642)];
    NSString * cabecalho = @"<html><body><table border='1' style='width:100 %;'><tr><th>Experimentador</th><th>Sessao</th><th>Sujeito</th><th>Data de Início</th><th>Hora de Início</th><th>Apresentacao Imagem</th><th>Toque na Tela</th><th>Tempo de reação</th><th>Programa</th><th>Tempo de Atraso</th><th>Status do Toque</th><th>Área do Toque</th><th>Área da Imagem</th></tr>";
    
    NSString * corpo = @"";
    for (JALLog *log in _arrayDeLogs) {
        
        if(log.areaToque == 0){
            corpo = [corpo stringByAppendingString: [NSString stringWithFormat: @"<tr><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%.2f</td><td>%@</td><td>%@</td><td>%d</td></tr>", _experimentador, _sessao, _usuario.idParticipante, [JALLog getStringDataFromDate:_dataInicio], [JALLog getStringHoraFromDate:_dataInicio], log.horaImagemString ,@"Não tocou",  @"-", log.programa, log.tempoExposicao, log.isBotaoCerto == YES ? @"CERTO" : @"ERRADO",@"Não tocou", log.areaImagem]];
        
        }else{
        
        corpo = [corpo stringByAppendingString: [NSString stringWithFormat: @"<tr><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%@</td><td>%.3f</td><td>%@</td><td>%.2f</td><td>%@</td><td>%d</td><td>%d</td></tr>", _experimentador, _sessao, _usuario.idParticipante, [JALLog getStringDataFromDate:_dataInicio], [JALLog getStringHoraFromDate:_dataInicio], log.horaImagemString ,log.horaToqueString,  [log.horaToque timeIntervalSinceDate:log.horaImagem], log.programa, log.tempoExposicao, log.isBotaoCerto == YES ? @"CERTO" : @"ERRADO",log.areaToque, log.areaImagem]];
        }
    }
    
    NSString *rodape = @"</table></body></html>";
    NSString * final = @"";
    
    final = [final stringByAppendingString:cabecalho];
    final = [final stringByAppendingString:corpo];
    final = [final stringByAppendingString:rodape];
    
    [webView loadHTMLString:final baseURL:nil];
    
    webView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:webView];
}

-(void) sendToEmail{
    
    MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
    
    [composer setMailComposeDelegate:self];
    if([MFMailComposeViewController canSendMail]) {
//        [composer setToRecipients:[NSArray arrayWithObjects:@"lucianotrindade92@gmail.com",nil]];
        [composer setSubject:@"Log TREA - iOS"];
//        [composer setMessageBody:@"Olá,\." isHTML:NO];
        [composer setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        
        NSData *data = [NSData dataWithContentsOfFile:_pathFileLog];
        [composer addAttachmentData:data mimeType:@"document" fileName:@"Log.csv"];
        
        //        UIImage * image = [_fotos objectAtIndex:8];
        //        NSData *data = UIImageJPEGRepresentation(image,1);
        //        [composer addAttachmentData:data mimeType:@"teste/jpeg" fileName:[NSString stringWithFormat:@"Photo%d.jpg",8]];
        
        
        //NSMutableArray * arrayData = [[NSMutableArray alloc]init];
        
//        for (int i = 0; i < _fotos.count; i++) {
//            UIImage * imagem = [_fotos objectAtIndex:i];
//            NSData *dataImage = UIImageJPEGRepresentation(imagem, 0.5);
//            
//            //[arrayData addObject:dataImage];
//            [composer addAttachmentData:dataImage mimeType:@"teste/jpeg"fileName:[NSString stringWithFormat:@"Photo%d.jpg",i]];
//        }
        
        //        [composer addAttachmentData:data  mimeType:@"image/jpeg" fileName:@"Photograph.jpg"];
        
        //        [self presentModalViewController:composer animated:YES];
        [self presentViewController:composer animated:YES completion:nil];
    }
    
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(UIButton *)createButtonSendEmail{
    
    UIButton *b = [[UIButton alloc] initWithFrame:CGRectMake(118, 690, 275, 45)];
    
    [b setTitle:@"Enviar por email" forState:UIControlStateNormal];
    [b setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    [b addTarget:self action:@selector(sendToEmail) forControlEvents:(UIControlEventTouchUpInside)];
    
    [[b layer] setBorderWidth:1.0f];
    [[b layer] setBorderColor:[UIColor blueColor].CGColor];
    
    return b;
}

@end
