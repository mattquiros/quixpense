//
//  SPRTextField.h
//  Spare
//
//  Created by Matt Quiros on 3/30/14.
//  Copyright (c) 2014 Matt Quiros. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPRField;

@interface SPRTextField : UITextField

@property (weak, nonatomic) SPRField *field;

@end