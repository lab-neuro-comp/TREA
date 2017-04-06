//
//  AVFViewControllerAddExperimento.h
//  TREA
//
//  Created by andre vinicius alves fonseca on 12/08/14.
//  Copyright (c) 2014 Andre Ltda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Experimento.h"
#import "LTRPrograma.h"

@interface AVFViewControllerAddExperimento : UIViewController <UITableViewDataSource , UITableViewDelegate>


- (IBAction)addPrograma:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *nomeExperimento;


@property (weak, nonatomic) IBOutlet UITableView *tableListaProgramas;


- (IBAction)salvarExperimento:(id)sender;


@property(nonatomic)BOOL isSave;


@property(nonatomic) Experimento *experimento;
@property(nonatomic) LTRPrograma *programa;


@property(nonatomic) NSMutableArray *nomeProgramas;

@property(nonatomic) NSMutableArray *listaProgramas;


@property(nonatomic) NSMutableArray *selectedIndexes;

@end
