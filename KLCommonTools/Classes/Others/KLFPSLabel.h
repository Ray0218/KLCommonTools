//
//  KLFPSLabel.h
//  KLCommonTools
//
//  Created by WKL on 2020/5/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
Show Screen FPS...

The maximum fps in OSX/iOS Simulator is 60.00.
The maximum fps on iPhone is 59.97.
The maxmium fps on iPad is 60.0.
 
 #if DEBUG
 //显示当前帧率
 KLFPSLabel *label = [[KLFPSLabel alloc] init];
    label.frame = CGRectMake(10, kScreenHeight - 49 - 30 - 10, 60, 30);
    [self.view addSubview:label];
 #endif

*/
@interface KLFPSLabel : UILabel

@end

NS_ASSUME_NONNULL_END
