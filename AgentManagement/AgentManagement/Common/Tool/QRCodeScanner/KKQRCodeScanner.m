//
//  KKQRCodeScanner.m
//  PuRunMedical
//
//  Created by Kyle on 16/6/20.
//  Copyright © 2016年 PuRun. All rights reserved.
//

#import "KKQRCodeScanner.h"
#import <AVFoundation/AVFoundation.h>

@interface KKQRCodeScanner () <AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic, strong) UIView *scannerSuperView;
@property (nonatomic, assign) CGRect availableScanRect;
@property (nonatomic, strong) AVCaptureDevice *device;
@property (nonatomic, strong) AVCaptureDeviceInput *input;
@property (nonatomic, strong) AVCaptureMetadataOutput *output;
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@end

@implementation KKQRCodeScanner

- (instancetype)initWithScannerSuperView:(UIView *)superView scanRect:(CGRect)scanRect
{
    self = [super init];
    if (self) {
        self.scannerSuperView = superView;
        self.availableScanRect = scanRect;
        [self setupScanner];
    }
    return self;
}

- (void)setupScanner
{
    // camera authorization
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if ((status == AVAuthorizationStatusRestricted) || (status == AVAuthorizationStatusDenied)) {
        return;
    }
    
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    self.output = [[AVCaptureMetadataOutput alloc] init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    self.session = [[AVCaptureSession alloc] init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.output]) {
        [self.session addOutput:self.output];
    }
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeQRCode];
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.previewLayer.frame = self.scannerSuperView.layer.bounds;
    [self.scannerSuperView.layer insertSublayer:self.previewLayer atIndex:0];
    if (!CGRectIsEmpty(self.availableScanRect)) {
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        
        self.output.rectOfInterest = CGRectMake(self.availableScanRect.origin.y / screenHeight, self.availableScanRect.origin.x / screenWidth, self.availableScanRect.size.height / screenHeight, self.availableScanRect.size.width / screenWidth);
    }
}

- (void)startScan
{
    if (!self.session.isRunning) {
        [self.session startRunning];
    }
}

- (void)stopScan
{
    if (self.session.isRunning) {
        [self.session stopRunning];
    }
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue = nil;
    
    if (metadataObjects.count > 0) {
        [self.session stopRunning];
        AVMetadataMachineReadableCodeObject *codeObject = [metadataObjects objectAtIndex:0];
        
        stringValue = codeObject.stringValue;
        if (self.resultBlock) {
            self.resultBlock(stringValue);
        }
    }
}

@end
