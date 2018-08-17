# QRCodeScan
A simple QR Code scan solution with only system API and smooth animation.

<p align="center" >
<img src="https://raw.githubusercontent.com/chenyun122/QRCodeScan/master/Screenshots/QRCodeScan.gif" alt="QRCodeScan" title="QRCodeScan" width="35%" height="35%" />
</p>

## Usage
Copy the source code in the **/QRCodeScan** folder into your project, then use it like `UIViewController`. Please check details in Demo project.

**Create the `QRCodeScanViewController` and present it:**
```Objective-C
    QRCodeScanViewController *scanViewController = [[QRCodeScanViewController alloc] init];
    scanViewController.continuous = YES;
    scanViewController.scanInterval = 1.5;
    scanViewController.delegate = self;
    [self presentViewController:scanViewController animated:YES completion:nil];
```

**Handle the QRCode scanned:**
```Objective-C
#pragma mark - QRCodeScanViewControllerDelegate
-(void)QRCodeScanViewController:(QRCodeScanViewController *)qrCodeScanViewController qrCodeDidScanned:(NSString *)qrCode {
    NSLog(@"QRCode Scanned:%@",qrCode);

    //Usually, we dismiss the QRCodeScanViewController after QRCode scanned
    [qrCodeScanViewController dismissViewControllerAnimated:YES completion:nil];
}
```

## Customization
The scan time interval, continuous scanning, scan window corner color and its frame could be customed.
___
[中文]  
这是一个简单轻量的二维码识别方案。它只使用了系统API，具备平滑的动画效果。

## 使用
拷贝**QRCodeScan**目录下源代码到您的项目中，就可以像使用`UIViewController`那样使用它。 可参考Demo项目。  
简要代码请参考以上英文介绍。

## 定制
扫描的时间间隔，是否持续扫描，扫描窗角颜色和位置大小可定制。

___
## License
StepIndicator is released under the MIT license. See LICENSE for details.