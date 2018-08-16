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
    //scanViewController.scanWindowCornerColor = UIColor.redColor;
    //scanViewController.scanWindowFrame = CGRectMake(100, 100, 100, 100);
    [self.navigationController pushViewController:scanViewController animated:YES];
}


#pragma mark - QRCodeScanViewControllerDelegate
-(void)QRCodeDidScanned:(NSString *)qrCode {
    NSLog(@"Scaned:%@",qrCode);
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"QRCode scanned:" message:qrCode preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
