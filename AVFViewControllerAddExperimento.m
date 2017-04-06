//
//  AVFViewControllerAddExperimento.m
//  TREA
//
//  Created by andre vinicius alves fonseca on 12/08/14.
//  Copyright (c) 2014 Andre Ltda. All rights reserved.
//

#import "AVFViewControllerAddExperimento.h"
#import "AVFViewController+CWPopup.h"
#import "AVFViewController.h"

@interface AVFViewControllerAddExperimento ()


@end

@implementation AVFViewControllerAddExperimento

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.isSave = NO;
    self.tableListaProgramas.delegate = self;
    
    _selectedIndexes = [[NSMutableArray alloc]init];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addPrograma:(id)sender {
    
   AVFViewController *addPrograma = [[AVFViewController alloc]init];

   [self presentViewController:addPrograma animated:YES completion:nil];
}


- (IBAction)salvarExperimento:(id)sender {
    
    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


//
//      metodos da tableView
//

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    

    
    self.nomeProgramas = [[NSMutableArray alloc]initWithContentsOfFile:[self caminhoPerfil]];
    
    return self.nomeProgramas.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.nomeProgramas = [[NSMutableArray alloc]initWithContentsOfFile:[self caminhoPerfil]];

    
    static NSString *identificador = @"celula";
    UITableViewCell *thisCell = [tableView dequeueReusableCellWithIdentifier:identificador];
    
    if (thisCell == nil) {
        thisCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identificador];
    }
    
    thisCell.textLabel.text = [self.nomeProgramas  objectAtIndex:indexPath.row];
    
    
    return thisCell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];

    
    if ([selectedCell accessoryType] == UITableViewCellAccessoryNone) {
        [selectedCell setAccessoryType:UITableViewCellAccessoryCheckmark];
        [_selectedIndexes addObject:[NSNumber numberWithInt:indexPath.row]];
    } else {
        [selectedCell setAccessoryType:UITableViewCellAccessoryNone];
        [_selectedIndexes removeObject:[NSNumber numberWithInt:indexPath.row]];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSLog(@"%@", _selectedIndexes);
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.tableListaProgramas reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
//    self.programa = [[Programa alloc]init];
    
    //pegando da plist
    self.nomeProgramas = [[NSMutableArray alloc]initWithContentsOfFile:[self caminhoPerfil]];
    
    
    
    
//    self.programa.nomePrograma = [[Programa sharePrograma] obterSharedNomePrograma];
//    self.programa.tentativas = [[Programa sharePrograma] obterSharedTentativas];        //passar para inteiro
//    self.programa.qtdElementos = [[Programa sharePrograma]obterSharedqtdElementos];//   passar para inteiro
//    self.programa.tempoExposicao = [[Programa sharePrograma] obterSharedtempoExposicao];// passar para inteiro
//    self.programa.tempoAtraso = [[Programa sharePrograma]obterSharedtempoAtraso];   //passar para inteiro
//    self.programa.tempoEntreTentativa = [[Programa sharePrograma]obterSharedtempoEntreTentativa]; // passar para inteiro
//    self.programa.isFiguraUnica = [[Programa sharePrograma] obterSharedisFiguraUnica];  // passar pra int
//    self.programa.isOrdemAleatoria = [[Programa sharePrograma] obterSharedisOrdemAleatoria];    //passar pra int;
//    self.programa.backgroundColor = [[Programa sharePrograma] obterSharedbackgroundColor];
//    self.programa.save = [[Programa sharePrograma]obtersave];
    
    
    //declarando int
    int tentativas;
    int qtdElementos;
    double tempoExposicao;
    double tempoAtraso;
    double tempoEntreTentativa;
    int isFiguraUnica;
    int isOrdemAleatoria;
    int sav;
    
    //passando os valores pra int
//    tentativas = self.programa.tentativas.intValue;
//    qtdElementos = self.programa.qtdElementos.intValue;
//    tempoExposicao = self.programa.tempoExposicao.doubleValue;
//    tempoAtraso = self.programa.tempoAtraso.doubleValue;
//    tempoEntreTentativa = self.programa.tempoEntreTentativa.doubleValue;
//    isFiguraUnica = self.programa.isFiguraUnica.intValue;
//    isOrdemAleatoria = self.programa.isOrdemAleatoria.intValue;
//    sav = self.programa.save.intValue;
    
 //   NSLog(@"------ %d",sav);
    
    if (sav) {

//        
//        
//        //povoando o nomePrograma vetor com os nomes dos experimentos
//        if (!self.nomeProgramas) {
//            self.nomeProgramas = [[NSMutableArray alloc]init];
//        }
//        
//        if (!self.listaProgramas) {
//            self.listaProgramas = [[NSMutableArray alloc]init];
//        }
//
//        
//      //  [self.listaProgramas insertObject:self.programa atIndex:0];
//
//        [self.listaProgramas addObject:self.programa];
//        
//        
//        [self.nomeProgramas insertObject:self.programa.nomePrograma atIndex:0];
//        
//        
//        NSLog(@"lista porgs: %@",self.listaProgramas);
//
//        
//        NSIndexPath *index  = [NSIndexPath indexPathForRow:0 inSection:0];
//        [self.tableListaProgramas insertRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        
     
        
    
    }
    
    
}

//caminho plist
-(NSString*)caminhoPerfil
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fileName = [NSString stringWithFormat:@"%@/perfil.plist",documentsDirectory];
    
    return fileName;
}

//metodos oara poder editar as tebela

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    
    
    [super setEditing:editing animated:animated];
    [self.tableListaProgramas setEditing:editing animated:animated];
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath

{
    self.nomeProgramas = [[NSMutableArray alloc]initWithContentsOfFile:[self caminhoPerfil]];
    
        [self.nomeProgramas removeObjectAtIndex:indexPath.row ];
    
        [self.nomeProgramas writeToFile:[self caminhoPerfil] atomically:YES];
    
        [self.tableListaProgramas reloadData];
    
}
//


@end
