//
//  QRCodeScanViewController.h
//  QRCodeScanDemo
//
//  Created by Yun CHEN on 2018/8/13.
//  Copyright © 2018年 Yun CHEN. All rights reserved.
//

@import UIKit;
@import AVFoundation;

@interface QRCodeScanPreviewView : UIView

@property (nonatomic, readonly) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic, assign) CGRect scanWindowFrame;
@property (nonatomic, strong) UIColor *scanWindowCornerColor;

@end


