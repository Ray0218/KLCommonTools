//
//  KLTextField.m
//  KLCommonTools_Example
//
//  Created by WKL on 2019/9/23.
//  Copyright © 2019 ray_ios@163.com. All rights reserved.
//

#import "KLTextField.h"

@implementation KLTextField

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    UIMenuController*menuController = [UIMenuController sharedMenuController];
    
    if(menuController) {
        
        [UIMenuController sharedMenuController].menuVisible=NO;
        
    }
    
    return NO;
    
}


@end
