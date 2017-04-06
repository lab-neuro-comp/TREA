//
//  LTRViewControllerBotoes.h
//  trea
//
//  Created by Luciano Rocha on 8/7/14.
//  Copyright (c) 2014 Luciano Rocha. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVFUsuario.h"
#import "LTRPrograma.h"
#import "Experimento.h"
#import "JALLog.h"
#import "JALCustomTableViewCell.h"
#import <MessageUI/MessageUI.h>


@interface LTRViewControllerBotoes : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button7;
@property (weak, nonatomic) IBOutlet UIButton *button8;
@property (weak, nonatomic) IBOutlet UIButton *button9;
@property (weak, nonatomic) IBOutlet UIButton *button10;
@property (weak, nonatomic) IBOutlet UIButton *button11;
@property (weak, nonatomic) IBOutlet UIButton *button12;
@property (weak, nonatomic) IBOutlet UIButton *button13;
@property (weak, nonatomic) IBOutlet UIButton *button14;
@property (weak, nonatomic) IBOutlet UIButton *button15;
@property (weak, nonatomic) IBOutlet UIButton *button16;


- (IBAction)view1:(id)sender;
- (IBAction)view2:(id)sender;
- (IBAction)view3:(id)sender;
- (IBAction)view4:(id)sender;
- (IBAction)view5:(id)sender;
- (IBAction)view6:(id)sender;
- (IBAction)view7:(id)sender;
- (IBAction)view8:(id)sender;
- (IBAction)view9:(id)sender;
- (IBAction)view10:(id)sender;
- (IBAction)view11:(id)sender;
- (IBAction)view12:(id)sender;
- (IBAction)view13:(id)sender;
- (IBAction)view14:(id)sender;
- (IBAction)view15:(id)sender;
- (IBAction)view16:(id)sender;


@property (nonatomic) LTRPrograma * programa;
@property (nonatomic) AVFUsuario * usuario;
@property (nonatomic) Experimento *experimento;

@property (nonatomic) NSMutableArray * arrayProgramas;

@property (nonatomic) JALLog *log;

@property (nonatomic) NSString *experimentador;
@property (nonatomic) NSString *sessao;


@end
