//
//  AVFViewController.m
//  TREA
//
//  Created by andre vinicius alves fonseca on 13/08/14.
//  Copyright (c) 2014 Andre Ltda. All rights reserved.
//

#import "AVFViewController.h"
//#import "Programa.h"
#import "ELCImagePickerController.h"
#import <QuartzCore/QuartzCore.h>

@interface AVFViewController ()

@property (nonatomic, retain) NSMutableArray * fotos;
@property (nonatomic, retain) NSMutableArray * fotosCodificadas;

@property (weak, nonatomic) IBOutlet UIView *viewBackgroundColor;
@property (nonatomic) NSMutableArray *arrayProgramas;


@end

@implementation AVFViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _programa = [[LTRPrograma alloc]init];
        
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //STEPPERs
    [_stepperTempoExposto setValue:1];
    [_stepperTempoExposto setStepValue:0.1];
    [_stepperTempoExposto setMinimumValue:0.1];
    [_tempoExposicao setText:[NSString stringWithFormat:@"%.2f s", _stepperTempoExposto.value]];
    _programa.tempoExposicao = 1.0;
    
    [_stepperTempoAtraso setValue:1];
    [_stepperTempoAtraso setStepValue:0.1];
    [_stepperTempoAtraso setMinimumValue:0.1];
    [_tempoAtraso setText:[NSString stringWithFormat:@"%.2f s", _stepperTempoExposto.value]];
    _programa.tempoAtraso = 1.0;
    
    [_stepperTempoEntreTentativas setValue:1];
    [_stepperTempoEntreTentativas setStepValue:0.1];
    [_stepperTempoEntreTentativas setMinimumValue:0.1];
    [_tempoEntreTentativas setText:[NSString stringWithFormat:@"%.2f s", _stepperTempoExposto.value]];
    _programa.tempoEntreTentativa = 1.0;
    
    //SegmentedControl
    [_isFiguraUnica setSelectedSegmentIndex:1];
    
    [self populaArrayProgramas];
    
    [[_scrollView layer]setBorderWidth:1.0f];
}

//Button adicionar fotos
- (IBAction)adicionarFotos:(id)sender {
    
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    
    elcPicker.maximumImagesCount = 100;
    elcPicker.returnsOriginalImage =YES; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.imagePickerDelegate = self;
    elcPicker.onOrder = YES;
    
    [self presentViewController:elcPicker animated:YES completion:nil];
}

- (void)displayPickerForGroup:(ALAssetsGroup *)group{
    
    ELCAssetTablePicker *tablePicker = [[ELCAssetTablePicker alloc] initWithStyle:UITableViewStylePlain];
    
    tablePicker.singleSelection = NO;
    tablePicker.immediateReturn = YES;
    
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:tablePicker];
    elcPicker.maximumImagesCount = 1;
    elcPicker.imagePickerDelegate = self;
    elcPicker.returnsOriginalImage = NO; //Only return the fullScreenImage, not the fullResolutionImage
    tablePicker.parent = elcPicker;

    // Move me
    
    tablePicker.assetGroup = group;
    [tablePicker.assetGroup setAssetsFilter:[ALAssetsFilter allAssets]];

    [self presentViewController:elcPicker animated:YES completion:nil];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

//Image Picker das imagens
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info {
    
    [self dismissViewControllerAnimated:YES completion:nil];

    //    for (UIView *v in [_scrollView subviews]) {
    
    //        [v removeFromSuperview];
    
    //    }
    
    _fotos = [[NSMutableArray alloc]init];
    
    //CGRect workingFrame = _scrollView.frame;
    
    //workingFrame.origin.x = 0;
    
    
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[info count]];
    
    for (NSDictionary *dict in info) {
        
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                
                EYLargePhoto *photo = [[EYLargePhoto alloc] init];
                
                photo.thumb = [dict objectForKey:UIImagePickerControllerOriginalImage];
                
                UIImage* image=photo.thumb;
                
                [images addObject:image];
                
                
                
                UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
                
                [imageview setContentMode:UIViewContentModeScaleAspectFit];
                
                //imageview.frame = workingFrame;

                [_fotos addObject:imageview.image];

                //workingFrame.origin.x = workingFrame.origin.x + workingFrame.size.width;
                
            } else {
                
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
                
            }
            
            /*} else if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypeVideo){
             
             if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
             
             EYLargePhoto *photo = [[EYLargePhoto alloc] init];
             
             photo.thumb = [dict objectForKey:UIImagePickerControllerOriginalImage];
             
             UIImage* image=photo.thumb;
             
             [images addObject:image];
             
             
             
             UIImageView *imageview = [[UIImageView alloc] initWithImage:image];
             
             [imageview setContentMode:UIViewContentModeScaleAspectFit];
             
             //imageview.frame = workingFrame;
             
             
             
             [_scrollView addSubview:imageview];
             
             
             
             workingFrame.origin.x = workingFrame.origin.x + workingFrame.size.width;
             
             } else {
             
             NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
             
             }
             
             */
            
        } else {
            
            //selecionou um video
            
            //NSLog(@"Uknown asset type");
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"ERRO" message:@"Voce deve selecionar apenas fotos" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
        
    }

    for (int i = 0 ; i < _fotos.count; i++) {
        
        NSLog(@"\nfoto:%@", _fotos[i]);
        
    }
    
    //self.chosenImages = images;
    //[_scrollView setPagingEnabled:YES];
    
    //[_scrollView setContentSize:CGSizeMake(workingFrame.origin.x, workingFrame.size.height)];
    [self addFotoScroll];
    
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Volta para a view anterior
- (IBAction)voltarExperimento:(id)sender {
//    [[Programa sharePrograma] setarSharePrograma:nil and:nil and:nil and:nil and:nil and:nil and:nil and:nil and:nil and:_savee ];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Salva o programa no Plist
- (IBAction)salvarPrograma:(id)sender {
    
    //Validação dos campos
    NSString *validator = [self validaValores];
    if(validator != nil){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Atenção" message:[NSString stringWithFormat:@"Verifique os campos abaixo\n\n%@", validator] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
        return;
    }
    
    //Valida se o nome do programa já esta cadastrado no plist
    for (LTRPrograma *program in _arrayProgramas) {
        if ([_nomePrograma.text caseInsensitiveCompare:program.nomePrograma] == NSOrderedSame) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Atenção" message:@"Nome do programa já existe" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
            return;
        }
    }
    
    _programa.nomePrograma = _nomePrograma.text;
    _programa.tentativas = _tentativas.text.intValue;
    _programa.qtdElementos = _elementosPossiveis.text.intValue;
    
    //STEPPER
    if (self.isFiguraUnica.selectedSegmentIndex == 0) {
        _programa.isFiguraUnica = YES;
    }else{
        _programa.isFiguraUnica = NO;
    }
    
    if (self.isOrdemAleatoria.selectedSegmentIndex == 0) {
        _programa.isOrdemAleatoria = YES;
    }else{
        _programa.isOrdemAleatoria = NO;
    }
    
    int qtdImagens = _programa.isFiguraUnica ? _programa.tentativas : _programa.qtdElementos * _programa.tentativas;
    
    if(_fotos.count != qtdImagens || _fotos == nil){
        NSString *msg = @"";
        
        if(_fotos.count == 0){
            msg = [msg stringByAppendingString:@"Nenhuma imagem selecionada. "];
        }
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Atenção" message:[NSString stringWithFormat:@"%@\nSelecione %d imagens", msg,qtdImagens] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
        return;
    }
    
    [self salvaImagens];
    
    NSLog(@"%@", _programa);

    //Salvando o programa no Plist
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent: @"programas"];
    NSString* pathFile = [path stringByAppendingString:@"/programas.plist"];
    
    NSLog(@"Path: %@", pathFile);
    
    NSData *programsData = [NSData dataWithContentsOfFile:pathFile];
    
    NSArray *programas = [NSKeyedUnarchiver unarchiveObjectWithData:programsData];
    
    NSMutableArray *program = [[NSMutableArray alloc] initWithArray:programas];
    
    [program addObject:_programa];
    
    NSData *consultsData = [NSKeyedArchiver archivedDataWithRootObject:program];
    
    [consultsData writeToFile:pathFile atomically:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Valida campos da view
-(NSString *)validaValores{
    NSString *string;
    
    if([JALValidator isStringVazia:_nomePrograma.text]){
        if(string == nil){
            string = @"";
        }
        string = [string stringByAppendingString:@"Nome do programa\n"];
        [_nomePrograma setText:nil];
        [_nomePrograma setPlaceholder:@"Obrigatório"];
    }
    
    if([JALValidator isStringVazia:_tentativas.text]){
        if(string == nil){
            string = @"";
        }
        string = [string stringByAppendingString:@"Numero de tentativas\n"];
        [_tentativas setText:nil];
        [_tentativas setPlaceholder:@"Obrigatório"];
    }
    
    if([JALValidator isStringVazia:_elementosPossiveis.text]){
        if(string == nil){
            string = @"";
        }
        string = [string stringByAppendingString:@"Elementos Possiveis\n"];
        [_elementosPossiveis setText:nil];
        [_elementosPossiveis setPlaceholder:@"Obrigatório"];
    }
    
    if(_fotos.count == 0){
        if(string == nil){
            string = @"";
        }
        string = [string stringByAppendingString:@"Nenhuma imagens selecionada\n"];
    }
    
    if(self.backGroundColor == nil){
        if(string == nil){
            string = @"";
        }
        string = [string stringByAppendingString:@"Cor de fundo\n"];
    }
    
    if(string != nil){
        return string;
    }
    
    NSLog(@"Elementos Possiveis - %d", _elementosPossiveis.text.intValue);
    NSLog(@"Tentativas - %d", _tentativas.text.intValue);
    
    int tentativas = _elementosPossiveis.text.intValue;
    int elementosPossiveis = _tentativas.text.intValue;
    
    if(tentativas <=0){
        if(string == nil){
            string = @"";
        }
        string = [string stringByAppendingString:@"Numero de Tentivas - Valor inválido\n"];
    }
    
    if(elementosPossiveis <=0){
        if(string == nil){
            string = @"";
        }
        string = [string stringByAppendingString:@"Elementos Possíveis - Valor invalido\n"];
    }
    
    return string;
}

//Salvando imagens no Array
-(void)salvaImagens{
    
    if (_fotos != nil) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString * documentsDirectory = [paths objectAtIndex:0];
        NSString* pathFolder = [documentsDirectory stringByAppendingPathComponent:@"programas"];
        NSString* pathFile = [pathFolder stringByAppendingString: [NSString stringWithFormat:@"/%@.plist", _programa.nomePrograma]];
        if (![[NSFileManager defaultManager] fileExistsAtPath:pathFolder])
            [[NSFileManager defaultManager] createDirectoryAtPath:pathFolder withIntermediateDirectories:NO attributes:nil error:nil]; //Create folder
        NSLog(@"\npath save: %@",pathFile);
        
        //preenchendo o array com o NSData das fotos
        _fotosCodificadas = [[NSMutableArray alloc]init];
        for (int i = 0; i < _fotos.count; i++) {
            
            //UIImage *image = [_fotos objectAtIndex:i];
            
            NSData * data = [self convertImage:[_fotos objectAtIndex:i] withId:i];
            [_fotosCodificadas addObject:data];
        }
        //NSLog(@"tamanho do fotosCodificadas: %lu", _fotosCodificadas.count);
        
        [_fotosCodificadas writeToFile:pathFile atomically:YES];
    }
    _fotosCodificadas = nil;
}

//Converte imagem para NSData
- (NSData*)convertImage: (UIImage*)image withId: (int) idImage{
    if (image != nil)
    {
        NSData* data = UIImageJPEGRepresentation(image, 1);
        return data;
    }
    //se der erro
    return nil;
}

- (IBAction)amarelo:(id)sender {
    
//    [[_amarelo layer] setCornerRadius:20.0f];
//    [[_amarelo layer] setBorderWidth:4.0f];
//    [[_amarelo layer] setBorderColor:[UIColor blackColor].CGColor];
    self.backGroundColor = [UIColor yellowColor];
    [self setViewColor];
    
}

- (IBAction)azul:(id)sender {
    
    self.backGroundColor = [UIColor blueColor];
    [self setViewColor];
//    [[_azul layer] setBorderWidth:4.0f];
//    [[_azul layer] setBorderColor:[UIColor blackColor].CGColor];

}

- (IBAction)verdeGrama:(id)sender {
    //self.backGroundColor = [UIColor colorWithRed:192 green:192 blue:192 alpha:1];
    
    self.backGroundColor = self.verdeGrama.backgroundColor;
    [self setViewColor];
}

- (IBAction)cinzaClaro:(id)sender {
//    self.backGroundColor = [UIColor colorWithRed:255 green:0 blue:255 alpha:1];
    self.backGroundColor = self.cinzaClaro.backgroundColor;
    [self setViewColor];
}

- (IBAction)roxo:(id)sender {
//    self.backGroundColor = [UIColor colorWithRed:139 green:0 blue:139 alpha:1];
    self.backGroundColor = self.roxo.backgroundColor;
    [self setViewColor];
}

- (IBAction)vermelho:(id)sender {
    self.backGroundColor = [UIColor redColor];
    [self setViewColor];
}

- (IBAction)azulClaro:(id)sender {
    
//    self.backGroundColor = [UIColor colorWithRed:255 green:0 blue:255 alpha:1];
    self.backGroundColor = self.azulClaro.backgroundColor;
    [self setViewColor];
}

- (IBAction)verdeFlorescente:(id)sender {
//    self.backGroundColor = [UIColor colorWithRed:0  green:255 blue:0 alpha:1];
    self.backGroundColor = self.verdeFlorecente.backgroundColor;
    [self setViewColor];
   
}

- (IBAction)cinzaEscuro:(id)sender {
//    self.backGroundColor = [UIColor colorWithRed:220   green:220 blue:220 alpha:1];
    self.backGroundColor = self.cinzaEscuro.backgroundColor;
    [self setViewColor];
}

- (IBAction)verdeMaisClaro:(id)sender {
//    self.backGroundColor = [UIColor colorWithRed:0 green:191 blue:255 alpha:1];
    self.backGroundColor = self.verdeMaisClaro.backgroundColor;
   [self setViewColor];
}

- (IBAction)rosaPink:(id)sender {
//    self.backGroundColor = [UIColor colorWithRed:255 green:0 blue:255 alpha:1];
    self.backGroundColor = self.rosapink.backgroundColor;
    [self setViewColor];
    
}

- (IBAction)azulPiscina:(id)sender {
    
//    self.backGroundColor = [UIColor colorWithRed:0 green:255 blue:255 alpha:1];
    self.backGroundColor = self.azulPiscina.backgroundColor;
    [self setViewColor];
}

- (IBAction)preto:(id)sender {
    self.backGroundColor = [UIColor blackColor];
    [self setViewColor];
}

- (IBAction)branco:(id)sender {
    
    self.backGroundColor = [UIColor whiteColor];
    [self setViewColor];
    
}

- (IBAction)azulEscuro:(id)sender {
    
//    self.backGroundColor = [UIColor colorWithRed:0 green:0 blue:139 alpha:1];
    self.backGroundColor = self.azulEscuro.backgroundColor;
    [self setViewColor];
}

- (IBAction)semCor:(id)sender {
    
    [self setViewColor];
}

//Seta cor da view de demonstracao do background color
-(void) setViewColor{
    self.viewBackgroundColor.backgroundColor = self.backGroundColor;
    _programa.backgroundColor = self.backGroundColor;
}

-(void) addFotoScroll{
    
    CGFloat currentX = 0.0f;
    CGFloat currentY = 0.0f;
    
    //remove todas as view dentro da scrollView
    for(UIView *subview in [self.scrollView subviews]) {
        [subview removeFromSuperview];
    }
    
//    [self.scrollView setBounds:CGRectMake(0, 0, 400, 400)];
    
    NSLog(@"Count fotos - %lu", _fotos.count);
    
    for (int i = 0; i < _fotos.count; i++) {
        
        UIImage *image = [_fotos objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,133, 133)];
        imageView.image = image;
        
        // colocar a imagem na posiçao correta
        CGRect rect = imageView.frame;
        rect.origin.x = currentX;
        rect.origin.y = currentY;
        imageView.frame = rect;
        
        // update currentX
        
        if (i != 0 && (i + 1) % 3 == 0) {
            currentX = 0.0;
            //adiciona 133 + 1 para dar espaço entre as imagens
            currentY += 134.0;
        }else{
            //adiciona mais um para dar espaço entre as imagens
            currentX += imageView.frame.size.width+1;
        }
        
        [self.scrollView addSubview:imageView];
        
    }
    //calculo para pular linha na scrollVIew
    CGFloat tamanhoScroll;
    if (_fotos.count % 3 == 0) {
        tamanhoScroll = ((_fotos.count / 3)) * 133;
    }else{
        tamanhoScroll = ((_fotos.count / 3)+1) * 133;
    }
    
    self.scrollView.contentSize = CGSizeMake(currentX, tamanhoScroll);
    
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    _numeroFiguras.text = [NSString stringWithFormat:@"%lu", _fotos.count];
}

- (IBAction)stepperTempoExposto:(id)sender {
    [_tempoExposicao setText:[NSString stringWithFormat:@"%.2f s", _stepperTempoExposto.value]];
    _programa.tempoExposicao = _stepperTempoExposto.value;
}

- (IBAction)stepperTempoAtraso:(id)sender {
    [_tempoAtraso setText:[NSString stringWithFormat:@"%.2f s", _stepperTempoAtraso.value]];
    _programa.tempoAtraso = _stepperTempoAtraso.value;
}

- (IBAction)stepperTempoEntreTentativas:(id)sender {
    [_tempoEntreTentativas setText:[NSString stringWithFormat:@"%.2f s", _stepperTempoEntreTentativas.value]];
    _programa.tempoEntreTentativa = _stepperTempoEntreTentativas.value;
}

- (IBAction)segmentControlFigura:(id)sender {
    //STEPPER
    if (self.isFiguraUnica.selectedSegmentIndex == 0) {
        _isOrdemAleatoria.enabled = NO;
        _isOrdemAleatoria.selectedSegmentIndex = 1;
    }else{
        _isOrdemAleatoria.enabled = YES;
    }
}

-(void)populaArrayProgramas{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent: @"programas"];
    NSString* pathFile = [path stringByAppendingString:@"/programas.plist"];
    
    NSData *usersData = [NSData dataWithContentsOfFile:pathFile];
    NSArray *programas = [NSKeyedUnarchiver unarchiveObjectWithData:usersData];
    
    _arrayProgramas = [[NSMutableArray alloc] initWithArray:programas];
    NSLog(@"Array programas - %@", _arrayProgramas);
}


@end
