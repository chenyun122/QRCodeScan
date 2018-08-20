//
//  QRCodeScanViewController.h
//  QRCodeScanDemo
//
//  Created by Yun CHEN on 2018/8/13.
//  Copyright © 2018年 Yun CHEN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRCodeScanPreviewView.h"

@class QRCodeScanViewController;
@protocol QRCodeScanViewControllerDelegate <NSObject>
-(void)QRCodeScanViewController:(QRCodeScanViewController *)qrCodeScanViewController qrCodeDidScanned:(NSString *)qrCode;
@end



@interface QRCodeScanViewController : UIViewController

@property(nonatomic, weak) id<QRCodeScanViewControllerDelegate> delegate;
@property(nonatomic, assign) BOOL continuous;
@property(nonatomic, assign) NSTimeInterval scanInterval;

@property (nonatomic, strong) UIColor *scanWindowCornerColor;
@property (nonatomic, assign) CGRect scanWindowFrame;
@property (nonatomic, copy) NSString *textAboveScanWindow;
@property (nonatomic, assign) CGFloat textAboveScanWindowMargin;
@property (nonatomic, copy) NSString *textBelowScanWindow;
@property (nonatomic, assign) CGFloat textBelowScanWindowMargin;

@end
