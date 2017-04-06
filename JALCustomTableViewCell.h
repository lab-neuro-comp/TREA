//
//  JALCustomTableViewCell.h
//  TREA
//
//  Created by Joabe Alexandre Leite on 01/10/14.
//  Copyright (c) 2014 Andre Ltda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JALCustomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelExperimentador;
@property (weak, nonatomic) IBOutlet UILabel *labelSessao;
@property (weak, nonatomic) IBOutlet UILabel *labelSujeito;
@property (weak, nonatomic) IBOutlet UILabel *labelData;
@property (weak, nonatomic) IBOutlet UILabel *labelHoraInicio;
@property (weak, nonatomic) IBOutlet UILabel *labelHoraExibicao;
@property (weak, nonatomic) IBOutlet UILabel *labelHoraToque;
@property (weak, nonatomic) IBOutlet UILabel *labelTempoReacao;
@property (weak, nonatomic) IBOutlet UILabel *labelPrograma;
@property (weak, nonatomic) IBOutlet UILabel *labelTempoExposicao;
@property (weak, nonatomic) IBOutlet UILabel *labelAreaImagem;
@property (weak, nonatomic) IBOutlet UILabel *labelAreaToque;
@property (weak, nonatomic) IBOutlet UILabel *labelStatusToque;

@end
