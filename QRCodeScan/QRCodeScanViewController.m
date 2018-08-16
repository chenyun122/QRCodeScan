//
//  QRCodeScanViewController.m
//  QRCodeScanDemo
//
//  Created by Yun CHEN on 2018/8/13.
//  Copyright © 2018年 Yun CHEN. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "QRCodeScanViewController.h"


@interface QRCodeScanViewController () <AVCaptureVideoDataOutputSampleBufferDelegate> {
    CFAbsoluteTime lastDetectionTime;
    CFAbsoluteTime lastCallbackTime;
    CIDetector *detector;
    BOOL isCallback;
}

@property (nonatomic,strong) AVCaptureSession *captureSession;
@property (nonatomic,strong) AVCaptureDevice *videoDevice;
@property (nonatomic,strong) AVCaptureVideoDataOutput *videoOutput;
@property(nonatomic, weak) IBOutlet QRCodeScanPreviewView *previewView;

@end

@implementation QRCodeScanViewController

const static CGFloat kMinDetectionInterval = 0.3;

- (instancetype)init {
    self = [super init];
    if (self) {
        _continuous = NO;
        _scanInterval = 1.5;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    //Initialize QRCode detetor
    detector =  [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
    
    //Set properties
    if (self.scanWindowCornerColor != nil) {
        self.previewView.scanWindowCornerColor = self.scanWindowCornerColor;
    }
    if (!CGRectEqualToRect(self.scanWindowFrame,CGRectZero)) {
        self.previewView.scanWindowFrame = self.scanWindowFrame;
    }
    
    //Start videos
    [self setupCaptureSession];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Properties
-(void)setScanWindowFrame:(CGRect)scanWindowFrame {
    _scanWindowFrame = scanWindowFrame;
    self.previewView.scanWindowFrame = scanWindowFrame;
}

-(void)setScanWindowCornerColor:(UIColor *)scanWindowCornerColor {
    _scanWindowCornerColor = scanWindowCornerColor;
    self.previewView.scanWindowCornerColor = scanWindowCornerColor;
}


#pragma mark - Video Handling
- (void)setupCaptureSession {
    AVCaptureDevice *videoDevice;
    if (@available(iOS 10.2, *)) {
        videoDevice = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInDualCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack];
        if (!videoDevice) {
            videoDevice = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack];
            
            if (!videoDevice) {
                videoDevice = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionFront];
            }
        }
    } else {
        NSArray *possibleDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
        videoDevice = [possibleDevices firstObject];
    }
    if (!videoDevice) return;
    self.videoDevice = videoDevice;
    
    // Session Congfguration
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    [session beginConfiguration];
    
    session.sessionPreset = AVCaptureSessionPresetHigh;
    
    // Add Input capabilities
    NSError *error = nil;
    AVCaptureDeviceInput* input = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
    [session addInput:input];
    
    // Add output
    self.videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    dispatch_queue_t queue = dispatch_queue_create("com.chenyun.QRCodeScanDemo", DISPATCH_QUEUE_SERIAL);
    [self.videoOutput setSampleBufferDelegate:self queue:queue];
    [session addOutput:self.videoOutput];


    [session commitConfiguration];
    
    self.captureSession = session;
    self.previewView.videoPreviewLayer.session = session;
    
    [session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    CVImageBufferRef imageBuf = CMSampleBufferGetImageBuffer(sampleBuffer);
    CIImage* frame = [CIImage imageWithCVImageBuffer: imageBuf];
    CFAbsoluteTime time = CFAbsoluteTimeGetCurrent();
    if (time - lastDetectionTime >= kMinDetectionInterval) {
        lastDetectionTime = time;
        CIQRCodeFeature *feature = (CIQRCodeFeature *)[detector featuresInImage: frame].firstObject;
        if (feature) {
            if (!isCallback) {
                isCallback = YES;
                [self callbackWithCode:feature.messageString];
            }
            else{
                if (self.continuous && time - lastCallbackTime >= self.scanInterval) {
                    [self callbackWithCode:feature.messageString];
                }
            }
        }
    }
}


#pragma mark - Callback
- (void)callbackWithCode:(NSString *)qrCode {
    lastCallbackTime = CFAbsoluteTimeGetCurrent();
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.delegate && [self.delegate respondsToSelector:@selector(QRCodeDidScanned:)]) {
            [self.delegate QRCodeDidScanned:qrCode];
        }
    });
}


@end
