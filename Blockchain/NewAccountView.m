//
//  NewAccountView.m
//  Blockchain
//
//  Created by Ben Reeves on 18/03/2012.
//  Copyright (c) 2012 Qkos Services Ltd. All rights reserved.
//

#import "NewAccountView.h"
#import "AppDelegate.h"

@implementation NewAccountView

@synthesize wallet;

-(void)dealloc {
    [createButton release];
    [activity release];
    [passwordTextField release];
    [password2TextField release];
    [super dealloc];
}

- (BOOL)textFieldShouldReturn:(UITextField*)aTextField {
    [aTextField resignFirstResponder];
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	[app.tabViewController responderMayHaveChanged];
}

-(void)awakeFromNib {
    [activity startAnimating];
}

-(void)walletJSReady {
    
    Key * key = [wallet generateNewKey];
    
    if (key) {
//        [app standardNotify:[NSString stringWithFormat:@"Generated new bitcoin address %@", key.addr] title:@"Success" delegate:nil];
        NSLog(@"Generated new bitcoin address %@", key.addr);
        
        if ([app.dataSource insertWallet:[wallet guid] sharedKey:[wallet sharedKey] payload:[wallet encryptedString]]) {
            [app didGenerateNewWallet:wallet password:passwordTextField.text];
            
            [app closeModal];
        } else {
        }
        
    } else {
#warning getting this error when pairing
        [app standardNotify:@"Error generating bitcoin address"];
    }
    
    [app finishTask];
    
    self.wallet = nil;
}

// Get here from New Account and also when manually pairing
-(IBAction)createAccountClicked:(id)sender {
    
    if ([passwordTextField.text length] < 10 || [passwordTextField.text length] > 255) {
        [app standardNotify:@"Password must 10 characters or longer"];
    }
    
    if (![[passwordTextField text] isEqualToString:[password2TextField text]]) {
        [app standardNotify:@"Passwords do not match"];
        return;
    }
    [app startTask:TaskGeneratingWallet];

    self.wallet = [[[Wallet alloc] initWithPassword:passwordTextField.text] autorelease];
    
    wallet.delegate = self;

}

@end
