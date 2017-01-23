//
//  RSAController.m
//  sdfd
//
//  Created by 梁齐才 on 17/1/22.
//  Copyright © 2017年 梁齐才. All rights reserved.
//

#import "RSAController.h"
#import "NSData+KKRSA.h"
#import "SecKeyTools.h"

@interface RSAController ()
{
    NSString *_randomS;
}


@property (weak, nonatomic) IBOutlet UILabel *lmiwen;
@property (weak, nonatomic) IBOutlet UILabel *lmingwen;

@end

@implementation RSAController

- (void)viewDidLoad{
    [super viewDidLoad];
    _randomS = @"1";
}

- (IBAction)jiami:(UIButton *)sender
{
    NSInteger aa = [_randomS integerValue];
    aa++ ;
    _randomS = [NSString stringWithFormat:@"%zd",aa];
    
    NSString *cerPA = [[NSBundle mainBundle] pathForResource:@"CPPUB.cer" ofType:nil];
    SecKeyRef pubkey = [SecKeyTools publicKeyFromCer:cerPA];
    
    NSData *data = [_randomS dataUsingEncoding:NSUTF8StringEncoding];
    NSData *miwenData = [data RSAEncryptWith:pubkey paddingType:RSAPaddingPKCS1];
    NSString *miwen = [miwenData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    _lmiwen.text = miwen;
}


- (IBAction)jiemi:(id)sender
{
    
    NSString *p12PA = [[NSBundle mainBundle] pathForResource:@"CPPRI.p12" ofType:nil];
    SecKeyRef prikey = [SecKeyTools privateKeyFromP12:p12PA password:@"test"];
    
    NSData *data = [[NSData alloc] initWithBase64EncodedString:_lmiwen.text options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *minwenData = [data RSADecryptWith:prikey paddingType:RSAPaddingPKCS1];
    _lmingwen.text = [[NSString alloc] initWithData:minwenData encoding:NSUTF8StringEncoding];
}

@end
