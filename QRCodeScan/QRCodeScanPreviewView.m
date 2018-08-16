//
//  QRCodeScanViewController.h
//  QRCodeScanDemo
//
//  Created by Yun CHEN on 2018/8/13.
//  Copyright © 2018年 Yun CHEN. All rights reserved.
//


#import "QRCodeScanPreviewView.h"


@interface QRCodeScanPreviewView () {
    NSArray<CALayer *> *cornerLayers;
    CAShapeLayer *scanWindowCornerLayer;
    CALayer *barLayer;
}

@end


@implementation QRCodeScanPreviewView

+ (Class)layerClass {
	return [AVCaptureVideoPreviewLayer class];
}

- (AVCaptureVideoPreviewLayer *)videoPreviewLayer {
	return (AVCaptureVideoPreviewLayer *)self.layer;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _scanWindowCornerColor = [UIColor colorWithRed:25.0/255.0 green:201.0/255.0 blue:152.0/255.0 alpha:1.0]; //Default light green color
    
    [self addShadeLayers];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (CGRectEqualToRect(self.scanWindowFrame,CGRectZero)) {
        CGFloat width = self.frame.size.width * 0.618;
        self.scanWindowFrame = CGRectMake((self.frame.size.width - width)/2, (self.frame.size.height - width)/2 - 50, width, width); //Default scan window frame
    }
    
    [self frameChanged];
}


#pragma mark - Properties
-(void)setScanWindowFrame:(CGRect)scanWindowFrame {
    _scanWindowFrame = scanWindowFrame;
    [self frameChanged];
}

-(void)setScanWindowCornerColor:(UIColor *)scanWindowCornerColor {
    _scanWindowCornerColor = scanWindowCornerColor;
    scanWindowCornerLayer.strokeColor = self.scanWindowCornerColor.CGColor;
}


#pragma mark - Layers handling
//All sublayers need to be refresh after the view's frame changed.
-(void)frameChanged {
    [self refreshShadeLayers];
    [self refreshScanWindowCornerLayer];
    [self refreshBarLayer];
}

//Add four shade layers to cover the area except for center scan window.
-(void)addShadeLayers {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:4];
    for (int i=0;i<4;i++) {
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.5].CGColor;
        [array addObject:layer];
        [self.layer addSublayer:layer];
    }

    cornerLayers = [array copy];
}

//Change the shade layers' frame after the view's frame changed.
-(void)refreshShadeLayers {
    CGSize size = self.scanWindowFrame.size;
    CGPoint origin = self.scanWindowFrame.origin;
    cornerLayers[0].frame = CGRectMake(0, 0, self.frame.size.width, origin.y);
    cornerLayers[1].frame = CGRectMake(0, origin.y, origin.x, size.height);
    cornerLayers[2].frame = CGRectMake(origin.x + size.width, origin.y, self.frame.size.width - origin.x - size.width, size.height);
    cornerLayers[3].frame = CGRectMake(0, origin.y + size.height, self.frame.size.width, self.frame.size.height - origin.y - size.height);
}

//Add four right angles around the scan window, and change their frames after the view's frame changed.
-(void)refreshScanWindowCornerLayer {
    if (scanWindowCornerLayer == nil) {
        scanWindowCornerLayer = [CAShapeLayer layer];
        scanWindowCornerLayer.lineWidth = 4.0;
        scanWindowCornerLayer.strokeColor = self.scanWindowCornerColor.CGColor;
        [self.layer addSublayer:scanWindowCornerLayer];
    }
    
    CGSize size = self.scanWindowFrame.size;
    CGPoint origin = self.scanWindowFrame.origin;
    
    CGFloat length = 30, margin = 8;
    CGFloat halfLineWidth = scanWindowCornerLayer.lineWidth / 2.0;

    UIBezierPath *path = [[UIBezierPath alloc] init];

    CGPoint leftTopPoint = CGPointMake(origin.x - margin, origin.y - margin);
    [path moveToPoint:CGPointMake(leftTopPoint.x - halfLineWidth, leftTopPoint.y)];
    [path addLineToPoint:CGPointMake(leftTopPoint.x - halfLineWidth + length , leftTopPoint.y)];
    [path moveToPoint:CGPointMake(leftTopPoint.x, leftTopPoint.y + halfLineWidth)];
    [path addLineToPoint:CGPointMake(leftTopPoint.x, leftTopPoint.y + length - halfLineWidth)];
    
    CGPoint rightTopPoint = CGPointMake(origin.x + size.width + margin, origin.y - margin);
    [path moveToPoint:CGPointMake(rightTopPoint.x + halfLineWidth, leftTopPoint.y)];
    [path addLineToPoint:CGPointMake(rightTopPoint.x + halfLineWidth - length, leftTopPoint.y)];
    [path moveToPoint:CGPointMake(rightTopPoint.x, rightTopPoint.y + halfLineWidth)];
    [path addLineToPoint:CGPointMake(rightTopPoint.x, rightTopPoint.y + length - halfLineWidth)];
    
    CGPoint leftBottomPoint = CGPointMake(origin.x - margin, origin.y + size.height + margin);
    [path moveToPoint:CGPointMake(leftBottomPoint.x - halfLineWidth, leftBottomPoint.y)];
    [path addLineToPoint:CGPointMake(leftBottomPoint.x - halfLineWidth + length, leftBottomPoint.y)];
    [path moveToPoint:CGPointMake(leftBottomPoint.x, leftBottomPoint.y - halfLineWidth)];
    [path addLineToPoint:CGPointMake(leftBottomPoint.x, leftBottomPoint.y - length + halfLineWidth)];
    
    CGPoint rightBottomPoint = CGPointMake(origin.x + size.width + margin, origin.y + size.height + margin);
    [path moveToPoint:CGPointMake(rightBottomPoint.x + halfLineWidth, rightBottomPoint.y)];
    [path addLineToPoint:CGPointMake(rightBottomPoint.x + halfLineWidth - length, rightBottomPoint.y)];
    [path moveToPoint:CGPointMake(rightBottomPoint.x, rightBottomPoint.y - halfLineWidth)];
    [path addLineToPoint:CGPointMake(rightBottomPoint.x, rightBottomPoint.y - length + halfLineWidth)];
    
    scanWindowCornerLayer.path = path.CGPath;
}

//Add a vertical moving scan bar to indicate scan activity, and change its frames after the view's frame changed.
-(void)refreshBarLayer {
    if (barLayer == nil) {
        barLayer = [CALayer layer];
        barLayer.backgroundColor = UIColor.whiteColor.CGColor;
        barLayer.shadowColor = barLayer.backgroundColor;
        barLayer.shadowOffset = CGSizeMake(0,0);
        barLayer.shadowRadius = 3.f;
        barLayer.shadowOpacity = 0.9f;
        barLayer.cornerRadius = 15.0;
        barLayer.hidden = YES;

        [self.layer addSublayer:barLayer];
        [self startScanAnimation];
    }
    
    barLayer.frame = CGRectMake(self.scanWindowFrame.origin.x + self.scanWindowFrame.size.width * 0.1 / 2.0, self.scanWindowFrame.origin.y, self.scanWindowFrame.size.width * 0.9, 3.0);
}

//Start the scan animation
-(void)startScanAnimation {
    [barLayer removeAllAnimations];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    animation.toValue = @(self.scanWindowFrame.origin.y + self.scanWindowFrame.size.height);
    animation.duration = 3.0;
    animation.repeatCount = CGFLOAT_MAX;
    animation.beginTime = CACurrentMediaTime() + 0.5;
    animation.fillMode = kCAFillModeRemoved;
    [barLayer addAnimation:animation forKey:nil];
    __weak CALayer *_barLayer = barLayer;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _barLayer.hidden = NO;
    });
}

@end
