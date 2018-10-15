//
//  QRCodeScanViewController.h
//  QRCodeScanDemo
//
//  Created by Yun CHEN on 2018/8/13.
//  Copyright © 2018年 Yun CHEN. All rights reserved.
//

@import UIKit;
@import AVFoundation;

@interface CYQRCodeScanPreviewView : UIView

@property (nonatomic, readonly) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, assign) CGRect scanWindowFrame;
@property (nonatomic, strong) UIColor *scanWindowCornerColor;
@property (nonatomic, copy) NSString *textAboveScanWindow;
@property (nonatomic, assign) CGFloat textAboveScanWindowMargin;
@property (nonatomic, copy) NSString *textBelowScanWindow;
@property (nonatomic, assign) CGFloat textBelowScanWindowMargin;

-(void)startScanAnimation;

@end


