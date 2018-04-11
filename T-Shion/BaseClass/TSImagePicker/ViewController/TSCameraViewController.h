//
//  TSCameraViewController.h
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/29.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

//前后置
typedef enum : NSUInteger {
    TSCameraPositionRear,
    TSCameraPositionFront
} TSCameraPosition;

//闪光灯
typedef enum : NSUInteger {
    // 默认off
    TSCameraFlashOff,
    TSCameraFlashOn,
    TSCameraFlashAuto
} TSCameraFlash;

//镜像
typedef enum : NSUInteger {
    // 默认off
    TSCameraMirrorOff,
    TSCameraMirrorOn,
    TSCameraMirrorAuto
} TSCameraMirror;

typedef enum : NSUInteger {
    TSCameraErrorCodeCameraPermission = 10,
    TSCameraErrorCodeMicrophonePermission = 11,
    TSCameraErrorCodeSession = 12,
    TSCameraErrorCodeVideoNotEnabled = 13
} TSSimpleCameraErrorCode;

extern NSString *const TSCameraErrorDomain;


typedef void (^CameraBlock) (UIImage *image, NSDictionary *info);

@interface TSCameraViewController : UIViewController


/**
 *设备转换
 */
@property (nonatomic, copy) void (^onDeviceChange)(TSCameraViewController *camera, AVCaptureDevice *device);

/**
 * 错误类型
 */
@property (nonatomic, copy) void (^onError)(TSCameraViewController *camera, NSError *error);

/**
 * 开始记录
 */
@property (nonatomic, copy) void (^onStartRecording)(TSCameraViewController *camera);

/**
 * 相片质量
 */
@property (copy, nonatomic) NSString *cameraQuality;

@property (nonatomic, readonly) TSCameraFlash flash;


@property (nonatomic) TSCameraMirror mirror;


@property (nonatomic) TSCameraPosition position;

/**
 * 白平衡
 */
@property (nonatomic) AVCaptureWhiteBalanceMode whiteBalanceMode;

/**
 * 放大缩小
 */
@property (nonatomic, getter=isZoomingEnabled) BOOL zoomingEnabled;

@property (nonatomic, assign) CGFloat maxScale;

/**
 * 将图像捕获后的方向固定为Yes
 */
@property (nonatomic) BOOL fixOrientationAfterCapture;

/**
 * 聚焦
 */
@property (nonatomic) BOOL tapToFocus;

/**
 * 设备镜像
 */
@property (nonatomic) BOOL useDeviceOrientation;


//获取设备权限
+ (void)requestCameraPermission:(void (^)(BOOL granted))completionBlock;


- (instancetype)initWithQuality:(NSString *)quality position:(TSCameraPosition)position videoEnabled:(BOOL)videoEnabled;

- (instancetype)initWithVideoEnabled:(BOOL)videoEnabled;

- (void)start;

- (void)stop;

- (void)capture:(void (^)(TSCameraViewController *camera, UIImage *image, NSDictionary *metadata, NSError *error))onCapture exactSeenImage:(BOOL)exactSeenImage animationBlock:(void (^)(AVCaptureVideoPreviewLayer *))animationBlock;

- (void)capture:(void (^)(TSCameraViewController *camera, UIImage *image, NSDictionary *metadata, NSError *error))onCapture exactSeenImage:(BOOL)exactSeenImage;

- (void)capture:(void (^)(TSCameraViewController *camera, UIImage *image, NSDictionary *metadata, NSError *error))onCapture;

- (void)attachToViewController:(UIViewController *)viewController frame:(CGRect)frame;

- (BOOL)updateFlashMode:(TSCameraFlash)cameraFlash;

- (BOOL)isFlashAvailable;

//手电筒
- (BOOL)isTorchAvailable;

- (TSCameraPosition)togglePosition;

- (void)alterFocusBox:(CALayer *)layer animation:(CAAnimation *)animation;

+ (BOOL)isFrontCameraAvailable;

+ (BOOL)isRearCameraAvailable;


@end
