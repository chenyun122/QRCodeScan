//
//  ViewController.m
//  QRCodeScanDemo
//
//  Created by Yun CHEN on 2018/8/13.
//  Copyright © 2018年 Yun CHEN. All rights reserved.
//

#import "ViewController.h"
#import "QRCodeScanViewController.h"

@interface ViewController () <QRCodeScanViewControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)scan:(id)sender {
    QRCodeScanViewController *scanViewController = [[QRCodeScanViewController alloc] init];
    scanViewController.continuous = YES;
    scanViewController.scanInterval = 1.5;
    scanViewController.delegate = self;
    scanViewController.textAboveScanWindow = @"A Title Here";
    scanViewController.textAboveScanWindowMargin = 70;
    scanViewController.textBelowScanWindow = @"Some descriptions";
    [self presentViewController:scanViewController animated:YES completion:nil];
    
    //Other customizations
    //scanViewController.scanWindowCornerColor = UIColor.redColor;
    //scanViewController.scanWindowFrame = CGRectMake(100, 100, 100, 100);
    //scanViewController.textAboveScanWindow = @"Scan QRcode";
    //scanViewController.textAboveScanWindowMargin = 20.0;
    
    //Change flashlight button's image
    //[scanViewController.flashLightButton setImage:[UIImage imageNamed:@"AnotherImage"] forState:UIControlStateNormal];
    //[scanViewController.flashLightButton setImage:[UIImage imageNamed:@"AnotherSelectedImage"] forState:UIControlStateSelected];
    
    //Could be pushed by an UINavigationController
    //[self.navigationController pushViewController:scanViewController animated:YES];
}


#pragma mark - QRCodeScanViewControllerDelegate
-(void)QRCodeScanViewController:(QRCodeScanViewController *)qrCodeScanViewController qrCodeDidScanned:(NSString *)qrCode {
    NSLog(@"Scanned:%@",qrCode);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"QRCode scanned:" message:qrCode preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [qrCodeScanViewController presentViewController:alertController animated:YES completion:nil];
    
    //Usually, we dismiss the QRCodeScanViewController after QRCode scanned, instead of displaying an alert.
    //[qrCodeScanViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
