//
//  AVFViewController1.m
//  TREA
//
//  Created by andre vinicius alves fonseca on 08/08/14.
//  Copyright (c) 2014 Andre Ltda. All rights reserved.
//

#import "AVFViewController1.h"
#import "AVFViewController+CWPopup.h"
#import "AVFViewControllerAddExperimento.h"
#import "AVFUsuario.h"
#import "Experimento.h"
#import "AVFViewController.h"

@interface AVFViewController1 ()

@property (nonatomic) UIDatePicker *date;
@property (nonatomic) UITextField *fieldNome;
@property (nonatomic) UITextField *fieldNomeExperimento;
@property (nonatomic) UITableView *tableViewExperimento;

@property (nonatomic) NSMutableArray *listProgramasTableView;
@property (nonatomic) Experimento *experimentoSelecionado;
@property (nonatomic) NSMutableArray *selecionados;

@end

@implementation AVFViewController1

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        //Alocações
        _usuario = [[AVFUsuario alloc]init];
        _experimento = [[Experimento alloc]init];
        _arrayUsuarios = [[NSMutableArray alloc]init];
        _experimento.arrayProgramas = [[NSMutableArray alloc]init];
        
//       [self deleteArray];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //Table view lista de programas
    _tableViewExperimento = [[UITableView alloc]initWithFrame: CGRectMake(60,160, 420, 280) style:UITableViewStylePlain];
    _tableViewExperimento.restorationIdentifier = @"table3";
    
    //setando o delegate da tableView
    self.listaPaciente.delegate = self;
    self.listaExperimentos.delegate = self;
    self.tableViewExperimento.delegate = self;
    self.tableViewExperimento.dataSource = self;
    
    //delegate do textField
    self.sessao.delegate = self;
    self.experimentador.delegate = self;
    
    _listaPaciente.restorationIdentifier = @"table1";
    _tableViewExperimento.allowsMultipleSelection = YES;
        
    [self popularArrays];
}

//Popula todos os Arrays
-(void) popularArrays{
    
    [self populaArraySujeitos];
    [self populaArrayProgramas];
    [self populaArrayExperimentos];
}

//Array Sujeitos
-(void)populaArraySujeitos{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* pathFile = [documentsDirectory stringByAppendingString:@"/sujeitos.plist"];
    
    NSData *usersData = [NSData dataWithContentsOfFile:pathFile];
    NSArray *usuarios = [NSKeyedUnarchiver unarchiveObjectWithData:usersData];
    
    _arrayUsuarios = [[NSMutableArray alloc] initWithArray:usuarios];
}

//Array Programas
-(void)populaArrayProgramas{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent: @"programas"];
    NSString* pathFile = [path stringByAppendingString:@"/programas.plist"];
    
    NSData *usersData = [NSData dataWithContentsOfFile:pathFile];
    NSArray *programas = [NSKeyedUnarchiver unarchiveObjectWithData:usersData];
    
    _arrayProgramas = [[NSMutableArray alloc] initWithArray:programas];
}

//Array Experimentos
-(void)populaArrayExperimentos{
    NSString* pathFile = [self getExperimentosPath];
    
    NSData *usersData = [NSData dataWithContentsOfFile:pathFile];
    NSArray *experimentos = [NSKeyedUnarchiver unarchiveObjectWithData:usersData];
    
    _arrayExperimentos = [[NSMutableArray alloc] initWithArray:experimentos];
}

//Método para deletar um plist
-(void) deleteArray{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* pathFile = [self getExperimentosPath];

    NSLog(@"%@", pathFile);
    
    NSError* error;
    if (![[NSFileManager defaultManager]removeItemAtPath:pathFile error:&error]) {
        NSLog(@"NAO DEU CERTO A EXCLUSAO");
    }else{
        NSLog(@"DEU CERTO A EXCLUSAO");
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView.restorationIdentifier isEqualToString:@"table1"]) {
        return self.arrayUsuarios.count;
    }else if([tableView.restorationIdentifier isEqualToString:@"table3"]){
        return _arrayProgramas.count;
    }else{
        return _arrayExperimentos.count;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setBounds:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    }];

    [self.view endEditing:YES];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"entrou no cellForRow");
    
    static NSString *identificador1 = @"celula1";
    static NSString *identificador2 = @"celula2";
    static NSString *identificador3 = @"celula3";
    
    //Tabela Sujeitos
    if ([tableView.restorationIdentifier isEqualToString:@"table1"]){
        AVFUsuario * user = [_arrayUsuarios objectAtIndex:indexPath.row];
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identificador1];
        
        if(cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identificador1];
        }
        
        cell.textLabel.text = user.idParticipante;
        
        return cell;
    }
    
    //Tabela Experimentos
    if ([tableView.restorationIdentifier isEqualToString:@"table2"]){
        
        Experimento * experimentos = [_arrayExperimentos objectAtIndex:indexPath.row];
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identificador2];
        
        if(cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identificador2];
        }
        
        cell.textLabel.text = experimentos.nomeExperimento;
        return cell;
    }
    
    //Tabela Programas
    if ([tableView.restorationIdentifier isEqualToString:@"table3"]){
        
        LTRPrograma * programa = [_arrayProgramas objectAtIndex:indexPath.row];
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identificador3];
        
        if(cell == nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identificador3];
        }
        
        if(cell == nil){
            cell = [[UITableViewCell alloc]init];
        }
        cell.textLabel.text = programa.nomePrograma;
    
        return cell;
    }
    return nil;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
//    [self.listaPaciente setEditing:editing animated:animated];
}


-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

//Título da TableView
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if ([tableView.restorationIdentifier isEqualToString:@"table2"]) {
        return @"Lista de experimentos";
    }else if ([tableView.restorationIdentifier isEqualToString:@"table1"]){
        return @"Lista de pacientes";
    }else if([tableView.restorationIdentifier isEqualToString:@"table3"]){
        return @"Lista de programas";
    }else{
        return nil;
    }
}

//Exclusão de itens da TableView
-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if([tableView.restorationIdentifier isEqualToString:@"table1"]){
        [self deletarUsuario:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }else if([tableView.restorationIdentifier isEqualToString:@"table2"]){
        [self deletarExperimento:indexPath.row];
    }else if([tableView.restorationIdentifier isEqualToString:@"table3"]){
        [self deletarPrograma:indexPath.row];
    }
}

//Botão editar TableView usuários
-(IBAction)BotaoEditarTap:(id)sender{
    if ([self.BotaoEditar.titleLabel.text isEqualToString:@"Editar"]) {
        [self.listaPaciente setEditing:YES animated:YES];
        [self.BotaoEditar setTitle:@"Pronto" forState:UIControlStateNormal];
    }else{
        [self.listaPaciente setEditing:NO animated:YES];
        [self.BotaoEditar setTitle:@"Editar" forState:UIControlStateNormal];
    }
}

//Botão editar TableView Experimentos
- (IBAction)actionEditarTableViewExperimentos:(id)sender {
    if ([self.botaoEditarTableViewExperimentos.titleLabel.text isEqualToString:@"Editar"]) {
        [self.listaExperimentos setEditing:YES animated:YES];
        [self.botaoEditarTableViewExperimentos setTitle:@"Pronto" forState:UIControlStateNormal];
    }else{
        [self.listaExperimentos setEditing:NO animated:YES];
        [self.botaoEditarTableViewExperimentos setTitle:@"Editar" forState:UIControlStateNormal];
    }
}

//Botão editar TableView Programas
- (IBAction)actionEditarTableViewProgramas:(id)sender {
    if ([self.botaoEditarTableViewProgramas.titleLabel.text isEqualToString:@"Editar"]) {
        [self.tableViewExperimento setEditing:YES animated:YES];
        [self.botaoEditarTableViewProgramas setTitle:@"Pronto" forState:UIControlStateNormal];
    }else{
        [self.tableViewExperimento setEditing:NO animated:YES];
        [self.botaoEditarTableViewProgramas setTitle:@"Editar" forState:UIControlStateNormal];
    }
}

//POPUP adicionar Paciente
- (IBAction)addPaciente:(id)sender {
    
    //VIEW POPUP
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.4;
    
    UIView *viewTitleLine = [[UIView alloc]initWithFrame:CGRectMake(0, 45, 550, 1)];
    viewTitleLine.backgroundColor = [UIColor lightGrayColor];
    
    UIView *viewTitleRect = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 550, 45)];
    viewTitleRect.backgroundColor = [UIColor whiteColor];
    viewTitleRect.alpha = 0.3;
    
    UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake(256, 162, 550, 430)];
    view2.backgroundColor = [UIColor colorWithRed:239.0f/255.0f
                                            green:239.0f/255.0f
                                             blue:244.0f/255.0f
                                            alpha:1.0f];
    
    //LABELS
    UILabel *labelParticipante = [[UILabel alloc]initWithFrame:CGRectMake(60, 60, 150, 50)];
    [labelParticipante setText:@"ID do usuário"];
    UILabel *labelSexo = [[UILabel alloc]initWithFrame:CGRectMake(60, 110, 100, 50) ];
    [labelSexo setText:@"Sexo"];
    UILabel *labelDataNascimento= [[UILabel alloc]initWithFrame:CGRectMake(60, 160, 180, 50) ];
    [labelDataNascimento setText:@"Data de Nascimento"];
    UILabel *labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 550, 45)];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    [labelTitle setText:@"Adicionar Usuário"];
    
    //LABELBUTTON
    UILabel * labelSalvar = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 40)];
    labelSalvar.textAlignment = NSTextAlignmentCenter;
    labelSalvar.text = @"Salvar";
    labelSalvar.textColor = [UIColor colorWithRed:0.0f/255.0f
                                            green:122.0f/255.0f
                                             blue:255.0f/255.0f
                                            alpha:1.0f];
    labelSalvar.backgroundColor = [UIColor clearColor];
    [labelSalvar setFont:[UIFont boldSystemFontOfSize:16]];
    
    UILabel * labelCancelar = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 40)];
    labelCancelar.textAlignment = NSTextAlignmentCenter;
    labelCancelar.text = @"Cancelar";
    labelCancelar.textColor = [UIColor colorWithRed:0.0f/255.0f
                                            green:122.0f/255.0f
                                             blue:255.0f/255.0f
                                            alpha:1.0f];
    labelCancelar.backgroundColor = [UIColor clearColor];
    [labelCancelar setFont:[UIFont systemFontOfSize:16]];
    
    //TEXTFIELD ID PARTICIPANTE
    _fieldNome = [[UITextField alloc]initWithFrame:CGRectMake(200, 70, 220, 30)];
    [_fieldNome setBorderStyle:UITextBorderStyleRoundedRect];
    
    //SEGMENTED CONTROL SEXO
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"Masculino",@"Feminino"]];
    segmentControl.frame = CGRectMake(200, 120, 220, 30);
    [segmentControl addTarget:self action:@selector(segmentedControlValueDidChange:) forControlEvents:UIControlEventValueChanged];
    [segmentControl setSelectedSegmentIndex:0];
    _usuario.sexo = @"M";
    
    //DATE PICKER
    _date = [[UIDatePicker alloc]initWithFrame: CGRectMake(70,200, 400, 200)];
    [_date setDatePickerMode:UIDatePickerModeDate];
    [_date setMaximumDate:[NSDate date]];
    _usuario.dataNasc = [NSDate date];
    
    //BUTTONS
    UIButton *buttonSalvar = [[UIButton alloc]initWithFrame:CGRectMake(450, 10, 70, 40)];
    UIButton *buttonCancelar = [[UIButton alloc]initWithFrame:CGRectMake(30, 10, 70, 40)];
    
    [buttonSalvar addSubview:labelSalvar];
    [buttonCancelar addSubview:labelCancelar];
    
    [view2 addSubview:labelTitle];
    [view2 addSubview:viewTitleRect];
    [view2 addSubview:viewTitleLine];
    [view2 addSubview:labelParticipante];
    [view2 addSubview:_fieldNome];
    [view2 addSubview:labelSexo];
    [view2 addSubview:labelDataNascimento];
    [view2 addSubview:segmentControl];
    [view2 addSubview:_date];
    [view2 addSubview:buttonSalvar];
    [view2 addSubview:buttonCancelar];
    
    
    view2.alpha = 0;
    view.alpha = 0;
    
    [UIView animateWithDuration:0.2 animations:^{
        view2.alpha = 1;
        view.alpha = 0.4;
    }];
    
    [self.view addSubview:view];
    [self.view addSubview:view2];
    
    view.tag = 70;
    view2.tag = 71;
    
    [buttonCancelar addTarget:self action:@selector(removeSubviews) forControlEvents:UIControlEventTouchUpInside];
    [buttonSalvar addTarget:self action:@selector(salvarPaciente) forControlEvents:UIControlEventTouchUpInside];
    [_date addTarget:self action:@selector(dateFromChangedValue) forControlEvents:UIControlEventValueChanged];
    
//    //Tocou fora da Popup
//    UITapGestureRecognizer *touchOnView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSubviews)];
//    touchOnView.numberOfTapsRequired = 2;
//    [[self view] addGestureRecognizer:touchOnView];
}

//Método para persistir o paciente
-(void) salvarPaciente{
    
    //Valida se o ID do usuário é vazio
    if([JALValidator isStringVazia:_fieldNome.text]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Atenção" message:@"Informar o ID do usuário" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [_fieldNome setText:nil];
        [_fieldNome setPlaceholder:@"Obrigatório"];
        [alert show];
        return;
    }
    
    //Valida se o ID do usuário já esta cadastrado no plist
    for (AVFUsuario *user in _arrayUsuarios) {
        if ([user.idParticipante caseInsensitiveCompare:_fieldNome.text] == NSOrderedSame) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Atenção" message:@"ID do usuário já existe" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            return;
        }
    }
    
    _usuario.idParticipante = _fieldNome.text;
    NSLog(@"Usuário: %@", _usuario);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* pathFile = [documentsDirectory stringByAppendingString:@"/sujeitos.plist"];
//    NSMutableArray * array = [NSMutableArray arrayWithContentsOfFile:pathFile];
    
    NSLog(@"Path: %@", pathFile);
    
    NSData *usersData = [NSData dataWithContentsOfFile:pathFile];
    
    NSArray *usuarios = [NSKeyedUnarchiver unarchiveObjectWithData:usersData];
    
    if(usuarios == nil){
        usuarios = [[NSMutableArray alloc] init];
    }
    
    NSMutableArray *users = [[NSMutableArray alloc] initWithArray:usuarios];
    
    [users addObject:_usuario];
    
    NSData *consultsData = [NSKeyedArchiver archivedDataWithRootObject:users];
    
    [consultsData writeToFile:pathFile atomically:YES];
    
    //Reload Array
    [self popularArrays];
    NSLog(@"%@", _arrayUsuarios);
    [_listaPaciente reloadData];
    
    [self removeSubviews];
}

-(void) deletarUsuario:(NSInteger) numero{
    AVFUsuario * usuario = [_arrayUsuarios objectAtIndex:(int)numero];
    
    if (usuario == nil) {
        NSLog(@"usuario nulo");
        return;
    }
    [self.listaPaciente setEditing:YES animated:YES];
    NSString* pathFile = [self getPacientesPath];
    NSMutableArray *users = [[NSMutableArray alloc] initWithArray:_arrayUsuarios];
    [users removeObject:usuario];
    NSData *consultsData = [NSKeyedArchiver archivedDataWithRootObject:users];
    
    [consultsData writeToFile:pathFile atomically:YES];
    [self populaArraySujeitos];
    [_listaPaciente reloadData];
}

//Remover as Popups da tela
-(void) removeSubviews{
    
    for (UIView* subview in [self.view subviews]) {
        if (subview.tag == 70 || subview.tag == 71) {

            [UIView animateWithDuration:0.3 animations:^{
                subview.alpha = 0;
            }];
        }
    }
    [self performSelector:@selector(removefromSuperviews) withObject:nil afterDelay:0.3];
}

//Remover as Popups da tela
-(void)removefromSuperviews{

    for (UIView* subview in [self.view subviews]) {
        
        if (subview.tag == 70 || subview.tag == 71) {
            
            [subview removeFromSuperview];
        }
    }
}

- (void) dateFromChangedValue {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd'/'MM'/'YYYY"]; //no.3
//    NSLog(@"%@", [dateFormatter stringFromDate:_date.date]);
    _usuario.dataNasc = _date.date;

}

-(void)segmentedControlValueDidChange:(UISegmentedControl *)segment{
    switch (segment.selectedSegmentIndex) {
        case 0:{
            //action for the first button (Current)
            _usuario.sexo = @"M";
            break;}
        case 1:{
            //action for the first button (Current)
            _usuario.sexo = @"F";
            break;}
    }
}

//POPUP adicionar experimento
- (IBAction)addExperimento:(id)sender {
    
    //Reload Array
    [self popularArrays];
    [_tableViewExperimento reloadData];
    
    //VIEW POPUP
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.4;
    
    UIView *viewTitleLine = [[UIView alloc]initWithFrame:CGRectMake(0, 45, 550, 1)];
    viewTitleLine.backgroundColor = [UIColor lightGrayColor];
    
    UIView *viewTitleRect = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 550, 45)];
    viewTitleRect.backgroundColor = [UIColor whiteColor];
    viewTitleRect.alpha = 0.3;
    
    UIView * view2 = [[UIView alloc]initWithFrame:CGRectMake(256, 137, 550, 480)];
    view2.backgroundColor = [UIColor colorWithRed:239.0f/255.0f
                                            green:239.0f/255.0f
                                             blue:244.0f/255.0f
                                            alpha:1.0f];
    view2.opaque = YES;
    
    //LABELS
    UILabel *labelNome = [[UILabel alloc]initWithFrame:CGRectMake(60, 60, 150, 50)];
    [labelNome setText:@"Nome"];
//    UILabel *labelProgramas = [[UILabel alloc]initWithFrame:CGRectMake(60, 105, 150, 50)];
//    [labelProgramas setText:@"Programas"];
    UILabel *labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 550, 45)];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    [labelTitle setText:@"Adicionar Experimento"];
    
    //LABELBUTTON
    UILabel * labelSalvar = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 40)];
    labelSalvar.textAlignment = NSTextAlignmentCenter;
    labelSalvar.text = @"Salvar";
    labelSalvar.textColor = [UIColor colorWithRed:0.0f/255.0f
                                            green:122.0f/255.0f
                                             blue:255.0f/255.0f
                                            alpha:1.0f];
    labelSalvar.backgroundColor = [UIColor clearColor];
    [labelSalvar setFont:[UIFont boldSystemFontOfSize:16]];
    
    UILabel * labelCancelar = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 40)];
    labelCancelar.textAlignment = NSTextAlignmentCenter;
    labelCancelar.text = @"Cancelar";
    labelCancelar.textColor = [UIColor colorWithRed:0.0f/255.0f
                                              green:122.0f/255.0f
                                               blue:255.0f/255.0f
                                              alpha:1.0f];
    labelCancelar.backgroundColor = [UIColor clearColor];
    [labelCancelar setFont:[UIFont systemFontOfSize:16]];
    
    //TEXTFIELD ID PARTICIPANTE
    _fieldNomeExperimento = [[UITextField alloc]initWithFrame:CGRectMake(200, 70, 220, 30)];
    [_fieldNomeExperimento setBorderStyle:UITextBorderStyleRoundedRect];
    
    //BUTTONS
    UIButton *buttonSalvar = [[UIButton alloc]initWithFrame:CGRectMake(450, 10, 70, 40)];
    UIButton *buttonCancelar = [[UIButton alloc]initWithFrame:CGRectMake(30, 10, 70, 40)];
    _botaoEditarTableViewProgramas = [[UIButton alloc]initWithFrame:CGRectMake(14, 120, 150, 50)];
    [_botaoEditarTableViewProgramas setTitle:@"Editar" forState:UIControlStateNormal];
    [_botaoEditarTableViewProgramas setTitleColor:[UIColor colorWithRed:0.0f/255.0f
                                                                  green:122.0f/255.0f
                                                                   blue:255.0f/255.0f
                                                                  alpha:1.0f] forState:UIControlStateNormal];
    [buttonSalvar addSubview:labelSalvar];
    [buttonCancelar addSubview:labelCancelar];
    
    [view2 addSubview:labelTitle];
    [view2 addSubview:viewTitleRect];
    [view2 addSubview:viewTitleLine];
    [view2 addSubview:labelNome];
    [view2 addSubview:_fieldNomeExperimento];
    [view2 addSubview:_botaoEditarTableViewProgramas];
    [view2 addSubview:buttonSalvar];
    [view2 addSubview:buttonCancelar];
    [view2 addSubview:_tableViewExperimento];
    
    view2.alpha = 0;
    view.alpha = 0;
    
    [UIView animateWithDuration:0.2 animations:^{
        view2.alpha = 1;
        view.alpha = 0.4;
    }];
    
    view.tag = 70;
    view2.tag = 71;
    
    [buttonCancelar addTarget:self action:@selector(cancelAddExperimento) forControlEvents:UIControlEventTouchUpInside];
    [buttonSalvar addTarget:self action:@selector(salvarExperimentoAction) forControlEvents:UIControlEventTouchUpInside];
    [_botaoEditarTableViewProgramas addTarget:self action:@selector(actionEditarTableViewProgramas:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:view];
    [self.view addSubview:view2];
}

//Salvar experimento
-(void)salvarExperimentoAction{
    
    //Valida se o ID do usuário é vazio
    if([JALValidator isStringVazia:_fieldNomeExperimento.text]){
        NSString *string = @"";
        
        if(_experimento.arrayProgramas.count == 0){
            string = [string stringByAppendingString:@"Selecione pelo menos um programa"];
        }
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Atenção"
                                                       message:[NSString stringWithFormat:@"Informar o nome do experimento\n%@", string]
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles: nil];
        [_fieldNomeExperimento setText:nil];
        [_fieldNomeExperimento setPlaceholder:@"Obrigatório"];
        [alert show];
        return;
    }
    
    //Valida se o ID do usuário já esta cadastrado no plist
    for (Experimento *expe in _arrayExperimentos) {
        NSString *string = @"";
        if(_experimento.arrayProgramas.count == 0){
            string = [string stringByAppendingString:@"Selecione pelo menos um programa"];
        }
        
        if ([expe.nomeExperimento caseInsensitiveCompare:_fieldNomeExperimento.text] == NSOrderedSame) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Atenção"
                                                           message: [NSString stringWithFormat:@"Nome do experimento já existe\n%@", string]
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles: nil];
            [alert show];
            return;
        }
    }
    
    if(_experimento.arrayProgramas.count == 0){
        NSString *string = @"Selecione pelo menos um programa";
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Atenção"
                                                       message: string
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles: nil];
        [alert show];
        return;
    }
    
    _experimento.nomeExperimento = _fieldNomeExperimento.text;
    NSString* pathFile = [self getExperimentosPath];
    
    NSLog(@"Path: %@", pathFile);
    
    NSData *usersData = [NSData dataWithContentsOfFile:pathFile];
    NSArray *experimentos = [NSKeyedUnarchiver unarchiveObjectWithData:usersData];
    NSMutableArray *expe = [[NSMutableArray alloc] initWithArray:experimentos];
    
    
    [expe addObject:_experimento];
    
    NSData *consultsData = [NSKeyedArchiver archivedDataWithRootObject:expe];
    
    [consultsData writeToFile:pathFile atomically:YES];
    
    //Reload Array
    [self popularArrays];
    [_listaExperimentos reloadData];
    _experimento = nil;
    _experimento = [[Experimento alloc]init];
    _experimento.arrayProgramas = [[NSMutableArray alloc]init];
    
    [self removeSubviews];
}

-(void) deletarExperimento:(NSInteger) numero{
    Experimento * experimento = [_arrayExperimentos objectAtIndex:(int)numero];
    
    if (experimento == nil) {
        NSLog(@"experimento nulo");
        return;
    }
    
    [self.listaExperimentos setEditing:YES animated:YES];

    NSString* pathFile = [self getExperimentosPath];
    NSMutableArray *experimentos = [[NSMutableArray alloc] initWithArray:_arrayExperimentos];
    
    [experimentos removeObject:experimento];
    
    NSData *consultsData = [NSKeyedArchiver archivedDataWithRootObject:experimentos];
    
    [consultsData writeToFile:pathFile atomically:YES];
    [self populaArrayExperimentos];
    [_listaExperimentos reloadData];
    
}

-(void) deletarPrograma:(NSInteger) numero{
    LTRPrograma * programa = [_arrayProgramas objectAtIndex:(int)numero];
    
    if (programa == nil) {
        NSLog(@"programa nulo");
        return;
    }
    
    [self.tableViewExperimento setEditing:YES animated:YES];
    
    NSString* pathFile = [self getProgramasPath];
    NSString* pathFileImagens = [self getProgramasImagensPath:programa.nomePrograma];
    
    NSMutableArray *programas = [[NSMutableArray alloc] initWithArray:_arrayProgramas];
    [programas removeObject:programa];

    NSData *consultsData = [NSKeyedArchiver archivedDataWithRootObject:programas];
    
    [consultsData writeToFile:pathFile atomically:YES];
    
    //Removendo as imagens
    NSError *error;
    if(![[NSFileManager defaultManager] removeItemAtPath:pathFileImagens error:&error]){
        //TODO: Handle/Log error
        NSLog(@"Erro ao excluir");
    }else{
        NSLog(@"Excluido com sucesso");
    }
    
    [self populaArrayProgramas];
    [_tableViewExperimento reloadData];
    
}

-(void)cancelAddExperimento {
    _experimento.arrayProgramas = nil;
    _experimento.arrayProgramas = [[NSMutableArray alloc]init];
    [self removeSubviews];
}

//selecionando o usuario
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView.restorationIdentifier isEqualToString:@"table1"]) {
        
        if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellSelectionStyleDefault){
            _usuario = nil;
            NSLog(@"%@", _usuario);
        }else{
            _usuario = [_arrayUsuarios objectAtIndex:indexPath.row];
            NSLog(@"%@", _usuario);
        }
        
    }else if ([tableView.restorationIdentifier isEqualToString:@"table2"]){
        
        if([tableView cellForRowAtIndexPath:indexPath].accessoryType == UITableViewCellSelectionStyleDefault){
            _experimentoSelecionado = nil;
            NSLog(@"%@", _experimentoSelecionado.nomeExperimento);
        }else{
            _experimentoSelecionado = [_arrayExperimentos objectAtIndex:indexPath.row];
            NSLog(@"%@", _experimentoSelecionado.nomeExperimento);
        }

    }else if([tableView.restorationIdentifier isEqualToString:@"table3"]){
        
        LTRPrograma *programa = [_arrayProgramas objectAtIndex:indexPath.row];
        [_experimento.arrayProgramas addObject: programa.nomePrograma];
        NSLog(@"%@", _experimento.arrayProgramas);
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([tableView.restorationIdentifier isEqualToString:@"table3"]){
        
        LTRPrograma *programa = [_arrayProgramas objectAtIndex:indexPath.row];
        [_experimento.arrayProgramas removeObject:programa.nomePrograma];
        NSLog(@"%@", _experimento.arrayProgramas);
    }
}

//permitindo a remocao de elementos da table view
-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Button começar teste
- (IBAction)comecarTeste:(id)sender {
    
    //Valida se foram selecionados um programa e um sujeito
    //Valida se o experimentador e sessão são vazios
    NSString *erro;
    
    if([JALValidator isStringVazia:_experimentador.text]){
        erro = @"Informe o nome do experimentador \n";
    }
    if([JALValidator isStringVazia:_sessao.text]){
        erro = [erro stringByAppendingString: @"Informe a sessão\n"];
    }
    if(_experimentoSelecionado == nil){
        erro = [erro stringByAppendingString: @"Selecione um experimento\n"];
    }
//    NSLog(@"Usuário - %@", _usuario);
    if(_usuario.idParticipante == nil){
        erro = [erro stringByAppendingString: @"Selecione um usuário"];
    }
    
    if(erro != nil){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Atenção"
                                                       message:erro
                                                      delegate:self
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles: nil];
        [_experimentador setPlaceholder:@"Obrigatório"];
        [_sessao setPlaceholder:@"Obrigatório"];
        [alert show];
        return;
    }
    
    LTRViewControllerBotoes *viewTeste = [[LTRViewControllerBotoes alloc]init];
    viewTeste.experimento = _experimentoSelecionado;
    
    NSMutableArray *arrayTestes = [[NSMutableArray alloc]init];
    
    for (NSString *nomePrograma in _experimentoSelecionado.arrayProgramas) {
        for (LTRPrograma *programa in _arrayProgramas) {
            
            //Se os programas forem iguais
            if([nomePrograma isEqualToString:programa.nomePrograma]){
                
                programa.imagens = [self loadImagesArray:nomePrograma];
                
                [arrayTestes addObject:programa];
            }
        }
    }
    
    viewTeste.usuario = _usuario;
    viewTeste.arrayProgramas = arrayTestes;
    viewTeste.experimentador = _experimentador.text;
    viewTeste.sessao = _sessao.text;
    
    [self presentViewController:viewTeste animated:YES completion:nil];
}

//Button Criar programa
- (IBAction)buttonCriarPrograma:(id)sender {
    
    AVFViewController *viewPrograma = [[AVFViewController alloc]init];
    [self presentViewController:viewPrograma animated:YES completion:nil];
    
}

//Text Field Sessao e Experimentador
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setBounds:CGRectMake(0, 200, self.view.bounds.size.width, self.view.bounds.size.height)];
    }];
}

//Text Field Sessao e Experimentador
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.view setBounds:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    }];
}


/*metodo que carega as imagens da plist e coloca no array*/
- (NSMutableArray *)loadImagesArray: (NSString *) nomePrograma{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent: @"programas"];
    NSString* pathFile = [path stringByAppendingString: [NSString stringWithFormat:@"/%@.plist", nomePrograma]];
    NSMutableArray * array = [NSMutableArray arrayWithContentsOfFile:pathFile];
    
    NSLog(@"path: %@",path);
    
    NSMutableArray *fotos = [[NSMutableArray alloc]init];
    for (int i = 0; i < array.count; i++) {
        [fotos addObject:[UIImage imageWithData:[array objectAtIndex:i]]];
    }
    
    NSLog(@"tamanho do array:%lu", fotos.count);
    
    return fotos;
}

-(NSString*)getPacientesPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* pathFile = [documentsDirectory stringByAppendingString:@"/sujeitos.plist"];
    return pathFile;
}

-(NSString*)getExperimentosPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* pathFile = [documentsDirectory stringByAppendingString:@"/experimentos.plist"];
    return pathFile;
}

-(NSString*)getProgramasPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent: @"programas"];
    NSString* pathFile = [path stringByAppendingString:@"/programas.plist"];
    
    return pathFile;
}

-(NSString*)getProgramasImagensPath: (NSString *)nomePrograma{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent: @"programas"];
    NSString* pathFile = [path stringByAppendingString: [NSString stringWithFormat:@"/%@.plist", nomePrograma]];
    
    return pathFile;
}

@end