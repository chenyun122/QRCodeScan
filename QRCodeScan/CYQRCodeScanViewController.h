//
//  QRCodeScanViewController.h
//  QRCodeScanDemo
//
//  Created by Yun CHEN on 2018/8/13.
//  Copyright © 2018年 Yun CHEN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYQRCodeScanPreviewView.h"

@class CYQRCodeScanViewController;
@protocol CYQRCodeScanViewControllerDelegate <NSObject>
-(void)CYQRCodeScanViewController:(CYQRCodeScanViewController *)qrCodeScanViewController qrCodeDidScanned:(NSString *)qrCode;
@end



@interface CYQRCodeScanViewController : UIViewController

@property (nonatomic, weak) id<CYQRCodeScanViewControllerDelegate> delegate;
@property (nonatomic, assign) BOOL continuous;
@property (nonatomic, assign) NSTimeInterval scanInterval;

@property (nonatomic, strong) UIColor *scanWindowCornerColor;
@property (nonatomic, assign) CGRect scanWindowFrame;
@property (nonatomic, copy) NSString *textAboveScanWindow;
@property (nonatomic, assign) CGFloat textAboveScanWindowMargin;
@property (nonatomic, copy) NSString *textBelowScanWindow;
@property (nonatomic, assign) CGFloat textBelowScanWindowMargin;

@property (nonatomic, weak) IBOutlet UIButton *flashLightButton;

+ (instancetype)qrcodeScanViewController;

@end
