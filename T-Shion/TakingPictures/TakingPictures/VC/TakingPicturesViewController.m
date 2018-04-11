//
//  TakingPicturesViewController.m
//  T-Shion
//
//  Created by together on 2018/3/20.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "TakingPicturesViewController.h"
#import "TSImagePickerController.h"
#import "TSCameraViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface TakingPicturesViewController ()

@property (strong, nonatomic) TSCameraViewController *camera;
@property (strong, nonatomic) UIButton *dissMissBtn;
@property (strong, nonatomic) UIButton *flashButton;//闪光
@property (strong, nonatomic) UIButton *switchButton;//前后置转化
@property (strong, nonatomic) UIButton *snapButton;//拍照
@property (strong, nonatomic) UIButton *photoButton;//相册
@property (strong, nonatomic) UIImageView *captureImageView;//拍照拿到显示

@property (strong, nonatomic) UIButton *captureBackBtn;
@property (strong, nonatomic) UIButton *captureSendBtn;

@end

@implementation TakingPicturesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.camera start];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)addChildView {
    
    [self.camera attachToViewController:self frame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self cameraOperation];
    
    [self.view addSubview:self.captureImageView];
    [self.view addSubview:self.dissMissBtn];
    [self.view addSubview:self.flashButton];
    [self.view addSubview:self.captureBackBtn];
    [self.view addSubview:self.captureSendBtn];
    [self.view addSubview:self.snapButton];
    [self.view addSubview:self.switchButton];
    [self.view addSubview:self.photoButton];
    
    __weak typeof(self) weakSelf = self;
    
    [self.captureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view);
    }];
    [self.dissMissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(20);
        make.left.equalTo(weakSelf.view).offset(20);
        make.size.mas_offset(CGSizeMake(30, 30));
    }];
    
    [self.flashButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(20);
        make.right.equalTo(weakSelf.view).offset(-20);
        make.size.mas_offset(CGSizeMake(30, 30));
    }];
    
    [self.captureSendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(80, 80));
        make.centerX.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view).offset(-60);
    }];
    
    [self.captureBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(80, 80));
        make.centerX.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view).offset(-60);
    }];

    [self.snapButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(80, 80));
        make.centerX.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view).offset(-60);
    }];

    
    [self.switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(40, 40));
        make.left.equalTo(weakSelf.snapButton.mas_right).offset(40);
        make.centerY.equalTo(weakSelf.snapButton);
    }];
    
    [self.photoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(40, 40));
        make.right.equalTo(weakSelf.snapButton.mas_left).offset(-40);
        make.centerY.equalTo(weakSelf.snapButton);
    }];
}

#pragma mark - camera
- (void)cameraOperation {
    __weak typeof(self) weakSelf = self;
    
    //前后置转换闪光灯按钮操作
    [_camera setOnDeviceChange:^(TSCameraViewController *camera, AVCaptureDevice *device) {
        if([camera isFlashAvailable]) {
            weakSelf.flashButton.hidden = NO;
            weakSelf.flashButton.selected = camera.flash == TSCameraFlashOff ? NO : YES;
        } else {
            weakSelf.flashButton.hidden = YES;
        }
    }];
    
    [_camera setOnError:^(TSCameraViewController *camera, NSError *error) {
        
    }];
}

#pragma mark captureSend
- (void)setupBtnAfterCapture {
    self.dissMissBtn.hidden = YES;
    self.flashButton.hidden = YES;
    self.switchButton.hidden = YES;
    self.photoButton.hidden = YES;
    
    self.captureSendBtn.hidden = NO;
    self.captureBackBtn.hidden = NO;
    self.snapButton.hidden = YES;

    [UIView animateWithDuration:1 animations:^{
        self.captureSendBtn.alpha = 1;
        self.captureBackBtn.alpha = 1;
        
        [self.captureSendBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view).offset(90);
        }];
        
        [self.captureBackBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view).offset(-90);
        }];
        
        [self.captureSendBtn layoutIfNeeded];
        [self.captureBackBtn layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)setupBtnAfterCancleCapture {
    self.dissMissBtn.hidden = NO;
    self.flashButton.hidden = NO;
    self.switchButton.hidden = NO;
    self.photoButton.hidden = NO;
    self.snapButton.hidden = NO;
    
    self.captureSendBtn.hidden = YES;
    self.captureBackBtn.hidden = YES;
    self.captureBackBtn.alpha = 0;
    self.captureSendBtn.alpha = 0;
    
    self.captureImageView.hidden = YES;
    self.captureImageView.image = nil;
}

#pragma mark - getter and setter
- (TSCameraViewController *)camera {
    if (!_camera) {
        _camera = [[TSCameraViewController alloc] initWithQuality:AVCaptureSessionPresetHigh
                                                         position:TSCameraPositionRear
                                                     videoEnabled:YES];
        _camera.fixOrientationAfterCapture = NO;
    }
    return _camera;
}

- (UIImageView *)captureImageView {
    if (!_captureImageView) {
        _captureImageView = [[UIImageView alloc] init];
        _captureImageView.hidden = YES;
    }
    return _captureImageView;
}

- (UIButton *)dissMissBtn {
    if (!_dissMissBtn) {
        _dissMissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dissMissBtn setImage:[UIImage imageNamed:@"camera_close"] forState:UIControlStateNormal];
        @weakify(self)
        [[_dissMissBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    return _dissMissBtn;
}

- (UIButton *)flashButton {
    if (!_flashButton) {
        _flashButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_flashButton setBackgroundColor:[UIColor yellowColor]];
        @weakify(self)
        [[_flashButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if(self.camera.flash == TSCameraFlashOff) {
                BOOL done = [self.camera updateFlashMode:TSCameraFlashOn];
                if(done) {
                    self.flashButton.selected = YES;
                    self.flashButton.tintColor = [UIColor yellowColor];
                }
            }
            else {
                BOOL done = [self.camera updateFlashMode:TSCameraFlashOff];
                if(done) {
                    self.flashButton.selected = NO;
                    self.flashButton.tintColor = [UIColor whiteColor];
                }
            }
        }];
    }
    return _flashButton;
}

- (UIButton *)snapButton {
    if (!_snapButton) {
        _snapButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_snapButton setBackgroundImage:[UIImage imageNamed:@"TabBar_TakingPictures_Normal"] forState:UIControlStateNormal];
//        [_snapButton setImage:[UIImage imageNamed:@"TabBar_TakingPictures_Normal"] forState:UIControlStateNormal];
        @weakify(self)
        [[_snapButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.camera capture:^(TSCameraViewController *camera, UIImage *image, NSDictionary *metadata, NSError *error) {
                if(!error) {
                    self.captureImageView.image = image;
                    self.captureImageView.hidden = NO;
                    [self setupBtnAfterCapture];
                } else {
                    NSLog(@"An error has occured: %@", error);
                }
            } exactSeenImage:YES];

        }];
        
        _snapButton.layer.masksToBounds = YES;
        _snapButton.layer.cornerRadius = 40;

    }
    return _snapButton;
}

- (UIButton *)switchButton {
    if (!_switchButton) {
        _switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_switchButton setBackgroundColor:[UIColor TSRedColor]];
        @weakify(self)
        [[_switchButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.camera togglePosition];
        }];
    }
    return _switchButton;;
}

- (UIButton *)photoButton {
    if (!_photoButton) {
        _photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_photoButton setBackgroundColor:[UIColor TSRedColor]];
        @weakify(self)
        [[_photoButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            TSImagePickerController *imagePicker = [[TSImagePickerController alloc] init];
            imagePicker.autoJumpToPhotoSelectPage = YES;
            
            [self dismissViewControllerAnimated:NO completion:^{
                [[TShionSingleCase shared].main presentViewController:imagePicker animated:NO completion:nil];
            }];
        }];
    }
    return _photoButton;
}

- (UIButton *)captureBackBtn {
    if (!_captureBackBtn) {
        _captureBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_captureBackBtn setBackgroundColor:[UIColor TSBlueColor]];
        _captureBackBtn.layer.masksToBounds = YES;
        _captureBackBtn.layer.cornerRadius = 40;
        _captureBackBtn.hidden = YES;
        _captureBackBtn.alpha = 0;
        [_captureBackBtn setTitle:@"返回" forState:UIControlStateNormal];
        @weakify(self)
        [[_captureBackBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self setupBtnAfterCancleCapture];
        }];
    }
    
    return _captureBackBtn;
}

- (UIButton *)captureSendBtn {
    if (!_captureSendBtn) {
        _captureSendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_captureSendBtn setBackgroundColor:[UIColor yellowColor]];
        _captureSendBtn.layer.masksToBounds = YES;
        _captureSendBtn.layer.cornerRadius = 40;
        _captureSendBtn.hidden = YES;
        _captureSendBtn.alpha = 0;
        [_captureSendBtn setTitle:@"发送" forState:UIControlStateNormal];
        @weakify(self)
        [[_captureSendBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    
    return _captureSendBtn;
}

@end
