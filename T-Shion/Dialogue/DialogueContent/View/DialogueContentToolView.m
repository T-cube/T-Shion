//
//  DialogueContentToolView.m
//  T-Shion
//
//  Created by together on 2018/3/28.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "DialogueContentToolView.h"

@implementation DialogueContentToolView

- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    return [super initWithViewModel:viewModel];
}

- (void)setupViews {
    [self addSubview:self.cameraButton];
    [self addSubview:self.textField];
    [self addSubview:self.emoticonButton];
    [self addSubview:self.voiceButton];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [super updateConstraints];
    [self.cameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(15);
        make.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(25, 25));
    }];
    
    [self.voiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(25, 25));
    }];
    
    [self.emoticonButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.voiceButton.mas_left).with.offset(-15);
        make.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(25, 25));
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.cameraButton.mas_right).with.offset(10);
        make.right.equalTo(self.emoticonButton.mas_left).with.offset(-10);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIButton *)cameraButton {
    if (!_cameraButton) {
        _cameraButton = [self creatButtonWithImage:@"Dialogue_Tool_Camera" tag:1];
    }
    return _cameraButton;
}

- (UIButton *)voiceButton {
    if (!_voiceButton) {
        _voiceButton = [self creatButtonWithImage:@"Dialogue_Tool_Voice" tag:2];
    }
    return _voiceButton;
}

- (UIButton *)emoticonButton {
    if (!_emoticonButton) {
        _emoticonButton = [self creatButtonWithImage:@"Dialogue_Tool_Emoji" tag:3];
    }
    return _emoticonButton;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"吃鸡吃鸡吃鸡吃鸡,脆皮的炸鸡";
        _textField.font = [UIFont systemFontOfSize:13];
    }
    return _textField;
}

- (UIButton *)creatButtonWithImage:(NSString *)image tag:(int)tag {
    UIButton *button =[UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setTag:tag];
    @weakify(self)
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        
    }];
    return button;
}

@end
