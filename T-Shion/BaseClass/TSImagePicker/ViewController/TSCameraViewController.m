//
//  TSCameraViewController.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/29.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "TSCameraViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface TSCameraViewController ()<AVCaptureFileOutputRecordingDelegate,UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIView *preview;
@property (strong, nonatomic) AVCaptureStillImageOutput *stillImageOutput;
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) CALayer *focusBoxLayer;
@property (strong, nonatomic) CAAnimation *focusBoxAnimation;
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
@property (strong, nonatomic) AVCaptureDevice *videoCaptureDevice;
@property (strong, nonatomic) AVCaptureDeviceInput *videoDeviceInput;
//@property (strong, nonatomic) AVCaptureMovieFileOutput *movieFileOutput;

@property (strong, nonatomic) UIPinchGestureRecognizer *pinchGesture;//捏合动作

@property (nonatomic, assign) CGFloat beginGestureScale;
@property (nonatomic, assign) CGFloat effectiveScale;

@property (nonatomic, copy) void (^didRecordCompletionBlock)(TSCameraViewController *camera, NSURL *outputFileUrl, NSError *error);

@end

NSString *const TSCameraErrorDomain = @"TSCameraErrorDomain";

@implementation TSCameraViewController

- (instancetype)init {
    return [self initWithVideoEnabled:NO];
}

- (instancetype)initWithVideoEnabled:(BOOL)videoEnabled {
    return [self initWithQuality:AVCaptureSessionPresetHigh position:TSCameraPositionRear videoEnabled:videoEnabled];
}

- (instancetype)initWithQuality:(NSString *)quality position:(TSCameraPosition)position videoEnabled:(BOOL)videoEnabled {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        [self setupWithQuality:quality position:position videoEnabled:videoEnabled];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupWithQuality:AVCaptureSessionPresetHigh
                      position:TSCameraPositionRear
                  videoEnabled:YES];
    }
    return self;
}

- (void)setupWithQuality:(NSString *)quality
                position:(TSCameraPosition)position
            videoEnabled:(BOOL)videoEnabled {
    _cameraQuality = quality;
    _position = position;
    _fixOrientationAfterCapture = NO;
    _tapToFocus = YES;
    _useDeviceOrientation = NO;
    _flash = TSCameraFlashOff;
    _mirror = TSCameraMirrorAuto;

    _zoomingEnabled = YES;
    _effectiveScale = 1.0f;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.view.autoresizingMask = UIViewAutoresizingNone;
    
    [self.view addSubview:self.preview];
    [self.preview addGestureRecognizer:self.tapGesture];
    if (_zoomingEnabled) {
        [self.preview addGestureRecognizer:self.pinchGesture];
    }
    
    [self addDefaultFocusBox];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.preview.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation) && UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
        [self.view setNeedsLayout];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    [self stop];
}

#pragma mark - camera
- (void)attachToViewController:(UIViewController *)viewController frame:(CGRect)frame {
    [viewController addChildViewController:self];
    self.view.frame = frame;
    [viewController.view addSubview:self.view];
    [self didMoveToParentViewController:viewController];
}

- (void)start {
    __weak typeof(self) weakSelf = self;
    
    [TSCameraViewController requestCameraPermission:^(BOOL granted) {
        if (granted) {
            [weakSelf setupPragma];
        } else {
            
        }
    }];
}

- (void)stop {
    [self.session stopRunning];
    self.session = nil;
}

- (void)setupPragma {
    [self.preview.layer addSublayer:self.captureVideoPreviewLayer];
    AVCaptureDevicePosition devicePosition;
    
    switch (self.position) {
        case TSCameraPositionRear:
            if ([TSCameraViewController isRearCameraAvailable]) {
                devicePosition = AVCaptureDevicePositionBack;
            } else {
                devicePosition = AVCaptureDevicePositionFront;
                _position = TSCameraPositionFront;
            }
            break;
            
        case TSCameraPositionFront:
            if ([TSCameraViewController isFrontCameraAvailable]) {
                devicePosition = AVCaptureDevicePositionFront;
            } else {
                devicePosition = AVCaptureDevicePositionBack;
                _position = TSCameraPositionRear;
            }
            break;
            
        default:
            devicePosition = AVCaptureDevicePositionUnspecified;
            break;
    }
    
    if (devicePosition == AVCaptureDevicePositionUnspecified) {
        self.videoCaptureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    } else {
        self.videoCaptureDevice = [self cameraWithPosition:devicePosition];
    }
    
    NSError *error = nil;
    _videoDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:_videoCaptureDevice error:&error];
    
    if (!_videoDeviceInput) {
        [self passError:error];
        return;
    }
    
    if ( [self.session canAddInput:_videoDeviceInput] ) {
        [self.session  addInput:_videoDeviceInput];
        self.captureVideoPreviewLayer.connection.videoOrientation = [self orientationForConnection];
    }
    
    self.whiteBalanceMode = AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance;
    
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [self.stillImageOutput setOutputSettings:outputSettings];
    [self.session addOutput:self.stillImageOutput];
    
    if (![self.captureVideoPreviewLayer.connection isEnabled]) {
        [self.captureVideoPreviewLayer.connection setEnabled:YES];
    }
    
    [self.session startRunning];
}

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition) position {
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (device.position == position) return device;
    }
    return nil;
}

//更新闪光灯模式
- (BOOL)updateFlashMode:(TSCameraFlash)cameraFlash {
    if (!self.session)
        return NO;
    
    AVCaptureFlashMode flashMode;
    
    if (cameraFlash == TSCameraFlashOn) {
        flashMode = AVCaptureFlashModeOn;
    } else if(cameraFlash == TSCameraFlashAuto) {
        flashMode = AVCaptureFlashModeAuto;
    } else {
        flashMode = AVCaptureFlashModeOff;
    }
    
    if ([self.videoCaptureDevice isFlashModeSupported:flashMode]) {
        NSError *error;
        if([self.videoCaptureDevice lockForConfiguration:&error]) {
            self.videoCaptureDevice.flashMode = flashMode;
            [self.videoCaptureDevice unlockForConfiguration];
            
            _flash = cameraFlash;
            return YES;
        } else {
            [self passError:error];
            return NO;
        }
    } else {
        return NO;
    }
}

- (void)capture:(void (^)(TSCameraViewController *, UIImage *, NSDictionary *, NSError *))onCapture {
    [self capture:onCapture exactSeenImage:NO];
}

- (void)capture:(void (^)(TSCameraViewController *, UIImage *, NSDictionary *, NSError *))onCapture exactSeenImage:(BOOL)exactSeenImage {
    [self capture:onCapture exactSeenImage:exactSeenImage animationBlock:^(AVCaptureVideoPreviewLayer *layer) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
        animation.duration = 0.1;
        animation.autoreverses = YES;
        animation.repeatCount = 0.0;
        animation.fromValue = [NSNumber numberWithFloat:1.0];
        animation.toValue = [NSNumber numberWithFloat:0.1];
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        [layer addAnimation:animation forKey:@"animateOpacity"];
    }];
}

- (void)capture:(void (^)(TSCameraViewController *, UIImage *, NSDictionary *, NSError *))onCapture exactSeenImage:(BOOL)exactSeenImage animationBlock:(void (^)(AVCaptureVideoPreviewLayer *))animationBlock {
    
    if (!self.session) {
        NSError *error = [NSError errorWithDomain:TSCameraErrorDomain
                                             code:TSCameraErrorCodeSession
                                         userInfo:nil];
        onCapture(self, nil, nil, error);
        return;
    }
    
    AVCaptureConnection *videoConnection = [self captureConnection];
    videoConnection.videoOrientation = [self orientationForConnection];
    
    BOOL flashActive = self.videoCaptureDevice.flashActive;
    if (!flashActive && animationBlock) {
        animationBlock(self.captureVideoPreviewLayer);
    }
    
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
        
        UIImage *image = nil;
        NSDictionary *metadata = nil;
        
        if (imageSampleBuffer != NULL) {
            CFDictionaryRef exifAttachments = CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
            if (exifAttachments) {
                metadata = (__bridge NSDictionary*)exifAttachments;
            }
            
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
            image = [[UIImage alloc] initWithData:imageData];
            
            if (exactSeenImage) {
                image = [self cropImage:image usingPreviewLayer:self.captureVideoPreviewLayer];
            }
            
            if (self.fixOrientationAfterCapture) {
                image = [self fixOrientation:image];
            }
        }
        
        if (onCapture) {
            dispatch_async(dispatch_get_main_queue(), ^{
                onCapture(self, image, metadata, error);
            });
        }
    }];
}

- (UIImage *)cropImage:(UIImage *)image usingPreviewLayer:(AVCaptureVideoPreviewLayer *)previewLayer {
    CGRect previewBounds = previewLayer.bounds;
    CGRect outputRect = [previewLayer metadataOutputRectOfInterestForRect:previewBounds];
    
    CGImageRef takenCGImage = image.CGImage;
    size_t width = CGImageGetWidth(takenCGImage);
    size_t height = CGImageGetHeight(takenCGImage);
    CGRect cropRect = CGRectMake(outputRect.origin.x * width, outputRect.origin.y * height,
                                 outputRect.size.width * width, outputRect.size.height * height);
    
    CGImageRef cropCGImage = CGImageCreateWithImageInRect(takenCGImage, cropRect);
    image = [UIImage imageWithCGImage:cropCGImage scale:1 orientation:image.imageOrientation];
    CGImageRelease(cropCGImage);
    
    return image;
}

- (UIImage *)fixOrientation:(UIImage *)tempImage {
    
    if (tempImage.imageOrientation == UIImageOrientationUp) return tempImage;
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (tempImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, tempImage.size.width, tempImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, tempImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, tempImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (tempImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, tempImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, tempImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    

    CGContextRef ctx = CGBitmapContextCreate(NULL, tempImage.size.width, tempImage.size.height,
                                             CGImageGetBitsPerComponent(tempImage.CGImage), 0,
                                             CGImageGetColorSpace(tempImage.CGImage),
                                             CGImageGetBitmapInfo(tempImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (tempImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            
            CGContextDrawImage(ctx, CGRectMake(0,0,tempImage.size.height,tempImage.size.width), tempImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,tempImage.size.width,tempImage.size.height), tempImage.CGImage);
            break;
    }
    
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

#pragma mark - help
- (void)passError:(NSError *)error {
    if(self.onError) {
        __weak typeof(self) weakSelf = self;
        self.onError(weakSelf, error);
    }
}

#pragma mark - 类方法
+ (void)requestCameraPermission:(void (^)(BOOL))completionBlock {
    if ([AVCaptureDevice respondsToSelector:@selector(requestAccessForMediaType: completionHandler:)]) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            // return to main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                if(completionBlock) {
                    completionBlock(granted);
                }
            });
        }];
    } else {
        completionBlock(YES);
    }
}

+ (BOOL)isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

+ (BOOL)isRearCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

#pragma mark - FocusBox
- (void)addDefaultFocusBox {
    //对焦组合动画(需要改动的，动画完成后opacity没有变为0)
    CALayer *focusBox = [[CALayer alloc] init];
    focusBox.bounds = CGRectMake(0.0f, 0.0f, 120, 120);
    focusBox.borderWidth = 2.0f;
    focusBox.borderColor = [[UIColor greenColor] CGColor];
    focusBox.opacity = 0.0f;
    [self.view.layer addSublayer:focusBox];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    CABasicAnimation *focusBoxAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    focusBoxAnimation.duration = 0.75;
    focusBoxAnimation.autoreverses = NO;
    focusBoxAnimation.repeatCount = 0.0;
    focusBoxAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    focusBoxAnimation.toValue = [NSNumber numberWithFloat:0.0];
    
    CABasicAnimation *scaleAnim = [CABasicAnimation animation];
    scaleAnim.keyPath = @"transform.scale";
    scaleAnim.toValue = @0.4;
    
    group.animations = @[scaleAnim,focusBoxAnimation];
    group.removedOnCompletion = NO;
    group.fillMode  = kCAFillModeForwards;

    [self alterFocusBox:focusBox animation:group];
}

- (void)alterFocusBox:(CALayer *)layer animation:(CAAnimation *)animation {
    self.focusBoxLayer = layer;
    self.focusBoxAnimation = animation;
}

- (void)focusAtPoint:(CGPoint)point completionHandler:(void(^)(void))completionHandler{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];;
    CGPoint pointOfInterest = CGPointZero;
    CGSize frameSize = self.preview.size;
    pointOfInterest = CGPointMake(point.y / frameSize.height, 1.f - (point.x / frameSize.width));
    
    if ([device isFocusPointOfInterestSupported] && [device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
        
        NSError *error;
        if ([device lockForConfiguration:&error]) {
            
            if ([device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
                [device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
            }
            
            if ([device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]) {
                [device setFocusMode:AVCaptureFocusModeAutoFocus];
                [device setFocusPointOfInterest:pointOfInterest];
            }
            
            if([device isExposurePointOfInterestSupported] && [device isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure]) {
                [device setExposurePointOfInterest:pointOfInterest];
                [device setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
            }
            
            [device unlockForConfiguration];
            
            completionHandler();
        }
    }
    else { completionHandler(); }
}

- (void)showFocusBox:(CGPoint)point {
    
    if (self.focusBoxLayer) {
        [self.focusBoxLayer removeAllAnimations];
        
        [CATransaction begin];
        [CATransaction setValue: (id) kCFBooleanTrue forKey: kCATransactionDisableActions];
        self.focusBoxLayer.position = point;
        [CATransaction commit];
    }
    
    if (self.focusBoxAnimation) {
        [self.focusBoxLayer addAnimation:self.focusBoxAnimation forKey:@"GROUP"];
    }
}

#pragma mark - UITapGestureRecognizer
- (void)previewTapped:(UIGestureRecognizer *)gestureRecognizer {
    
    if (!self.tapToFocus) { return; }

    CGPoint touchedPoint = [gestureRecognizer locationInView:self.preview];
    
    __weak typeof(self) weakSelf = self;
    [self focusAtPoint:touchedPoint completionHandler:^{
        [weakSelf showFocusBox:touchedPoint];
    }];
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)recognizer {
    //处理捏合动作，放大缩小
    BOOL allTouchesAreOnThePreviewLayer = YES;
    NSUInteger numTouches = [recognizer numberOfTouches];
    
    for (NSInteger i = 0; i < numTouches; i++) {
        CGPoint location = [recognizer locationOfTouch:i inView:self.preview];
        CGPoint convertedLocation = [self.preview.layer convertPoint:location fromLayer:self.view.layer];
        if ( ! [self.preview.layer containsPoint:convertedLocation] ) {
            allTouchesAreOnThePreviewLayer = NO;
            break;
        }
    }
    
    if (allTouchesAreOnThePreviewLayer) {
        _effectiveScale = _beginGestureScale * recognizer.scale;
        if (_effectiveScale < 1.0f)
            _effectiveScale = 1.0f;
        if (_effectiveScale > self.videoCaptureDevice.activeFormat.videoMaxZoomFactor)
            _effectiveScale = self.videoCaptureDevice.activeFormat.videoMaxZoomFactor;
        
        NSError *error = nil;
        if ([self.videoCaptureDevice lockForConfiguration:&error]) {
            [self.videoCaptureDevice rampToVideoZoomFactor:_effectiveScale withRate:100];
            [self.videoCaptureDevice unlockForConfiguration];
        } else {
            [self passError:error];
        }
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ( [gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]] ) {
        _beginGestureScale = _effectiveScale;
    }
    return YES;
}

#pragma mark - getter
- (UIView *)preview {
    if (!_preview) {
        _preview = [[UIView alloc] initWithFrame:CGRectZero];
        _preview.backgroundColor = [UIColor clearColor];
    }
    return _preview;
}

- (UITapGestureRecognizer *)tapGesture {
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(previewTapped:)];
        _tapGesture.numberOfTapsRequired = 1;
        [_tapGesture setDelaysTouchesEnded:NO];
    }
    return _tapGesture;
}

- (UIPinchGestureRecognizer *)pinchGesture {
    if (!_pinchGesture) {
        _pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
        _pinchGesture.delegate = self;
    }
    return _pinchGesture;
}

- (AVCaptureVideoOrientation)orientationForConnection {
    AVCaptureVideoOrientation videoOrientation = AVCaptureVideoOrientationPortrait;
    
    if (self.useDeviceOrientation) {
        switch ([UIDevice currentDevice].orientation) {
            case UIDeviceOrientationLandscapeLeft:
                videoOrientation = AVCaptureVideoOrientationLandscapeRight;
                break;
            case UIDeviceOrientationLandscapeRight:
                videoOrientation = AVCaptureVideoOrientationLandscapeLeft;
                break;
            case UIDeviceOrientationPortraitUpsideDown:
                videoOrientation = AVCaptureVideoOrientationPortraitUpsideDown;
                break;
            default:
                videoOrientation = AVCaptureVideoOrientationPortrait;
                break;
        }
    } else {
        switch ([[UIApplication sharedApplication] statusBarOrientation]) {
            case UIInterfaceOrientationLandscapeLeft:
                videoOrientation = AVCaptureVideoOrientationLandscapeLeft;
                break;
            case UIInterfaceOrientationLandscapeRight:
                videoOrientation = AVCaptureVideoOrientationLandscapeRight;
                break;
            case UIInterfaceOrientationPortraitUpsideDown:
                videoOrientation = AVCaptureVideoOrientationPortraitUpsideDown;
                break;
            default:
                videoOrientation = AVCaptureVideoOrientationPortrait;
                break;
        }
    }
    
    return videoOrientation;
}

- (AVCaptureSession *)session {
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
        _session.sessionPreset = self.cameraQuality;
    }
    
    return _session;
}

- (AVCaptureVideoPreviewLayer *)captureVideoPreviewLayer {
    if (!_captureVideoPreviewLayer) {
        _captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        _captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        
        CGRect bounds = self.preview.layer.bounds;
        _captureVideoPreviewLayer.bounds = bounds;
        _captureVideoPreviewLayer.position = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    }
    
    return _captureVideoPreviewLayer;
}

- (TSCameraPosition)togglePosition {
    if (!self.session) {
        return self.position;
    }
    
    if (self.position == TSCameraPositionRear) {
        self.cameraPosition = TSCameraPositionFront;
    } else {
        self.cameraPosition = TSCameraPositionRear;
    }
    
    return self.position;
}

- (BOOL)isFlashAvailable {
    return self.videoCaptureDevice.hasFlash && self.videoCaptureDevice.isFlashAvailable;
}

- (AVCaptureConnection *)captureConnection {
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in self.stillImageOutput.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) {
            break;
        }
    }
    
    return videoConnection;
}

#pragma mark - setter
- (void)setCameraPosition:(TSCameraPosition)cameraPosition {
    if (_position == cameraPosition || !self.session) {
        return;
    }
    
    if (cameraPosition == TSCameraPositionRear && ![self.class isRearCameraAvailable]) {
        return;
    }
    
    if (cameraPosition == TSCameraPositionFront && ![self.class isFrontCameraAvailable]) {
        return;
    }
    
    [self.session beginConfiguration];
    [self.session removeInput:self.videoDeviceInput];
    
    AVCaptureDevice *device = nil;
    if (self.videoDeviceInput.device.position == AVCaptureDevicePositionBack) {
        device = [self cameraWithPosition:AVCaptureDevicePositionFront];
    } else {
        device = [self cameraWithPosition:AVCaptureDevicePositionBack];
    }
    
    if (!device) {
        return;
    }
    
    NSError *error = nil;
    AVCaptureDeviceInput *videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&error];
    if (error) {
        [self passError:error];
        [self.session commitConfiguration];
        return;
    }
    
    _position = cameraPosition;
    
    [self.session addInput:videoInput];
    [self.session commitConfiguration];
    
    self.videoCaptureDevice = device;
    self.videoDeviceInput = videoInput;
    
    [self setMirror:_mirror];
}

- (void)setVideoCaptureDevice:(AVCaptureDevice *)videoCaptureDevice {
    _videoCaptureDevice = videoCaptureDevice;
    
    if (videoCaptureDevice.flashMode == AVCaptureFlashModeAuto) {
        _flash = TSCameraFlashAuto;
    } else if(videoCaptureDevice.flashMode == AVCaptureFlashModeOn) {
        _flash = TSCameraFlashOn;
    } else if(videoCaptureDevice.flashMode == AVCaptureFlashModeOff) {
        _flash = TSCameraFlashOff;
    } else {
        _flash = TSCameraFlashOff;
    }
    
    _effectiveScale = 1.0f;
    
    if (self.onDeviceChange) {
        __weak typeof(self) weakSelf = self;
        self.onDeviceChange(weakSelf, videoCaptureDevice);
    }
}

@end
