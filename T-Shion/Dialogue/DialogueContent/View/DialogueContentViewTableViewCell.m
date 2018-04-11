//
//  DialogueContentViewTableViewCell.m
//  T-Shion
//
//  Created by together on 2018/3/27.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "DialogueContentViewTableViewCell.h"

@implementation DialogueContentViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



- (void)setModel:(DialogueContentModel *)model {
    for (UIView *v  in [self.contentView subviews]) {
        [v removeFromSuperview];
    }
    _model = model;
    self.backgroundColor = RGB(246, 246, 246);
    switch (model.messageType) {
        case 1:{
            if (_model.messageSenderType) {
                [self.contentView addSubview:self.receiveText];
                self.cellView = self.receiveText;
                
            } else {
                [self.contentView addSubview:self.sendTextCell];
                self.cellView = self.sendTextCell;
            }
        }
            break;
        case 2:{
            if (_model.messageSenderType) {
                [self.contentView addSubview:self.receiveVoiceCell];
                self.cellView = self.receiveVoiceCell;
            } else {
                [self.contentView addSubview:self.sendVoiceCell];
                self.cellView = self.sendVoiceCell;
            }
        }
            break;
        case 3:{
            if (_model.messageSenderType) {
                [self.contentView addSubview:self.receiveImageCell];
                self.cellView = self.receiveImageCell;
            } else {
                [self.contentView addSubview:self.sendImageCell];
                self.cellView = self.sendImageCell;
            }
        }
            break;
            
        default:
            break;
    }
    [self.cellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
#pragma mark 懒加载
- (SendTextCell *)sendTextCell {
    if (!_sendTextCell) {
        _sendTextCell = [[SendTextCell alloc] initWithModel:_model];
    }
    return _sendTextCell;
}

- (ReceiveTextCell *)receiveText {
    if (!_receiveText) {
        _receiveText = [[ReceiveTextCell alloc] initWithModel:_model];
    }
    return _receiveText;
}

- (ReceiveVoiceCell *)receiveVoiceCell {
    if (!_receiveVoiceCell) {
        _receiveVoiceCell = [[ReceiveVoiceCell alloc] initWithModel:_model];
    }
    return _receiveVoiceCell;
}

- (SendVoiceCell *)sendVoiceCell {
    if (!_sendVoiceCell) {
        _sendVoiceCell = [[SendVoiceCell alloc] initWithModel:_model];
    }
    return _sendVoiceCell;
}

- (ReceiveImageCell *)receiveImageCell {
    if (!_receiveImageCell) {
        _receiveImageCell = [[ReceiveImageCell alloc] initWithModel:_model];
    }
    return _receiveImageCell;
}

- (SendImageCell *)sendImageCell {
    if (!_sendImageCell) {
        _sendImageCell = [[SendImageCell alloc] initWithModel:_model];
    }
    return _sendImageCell;
}
@end

#pragma mark 接收文字
@implementation ReceiveTextCell

- (instancetype)initWithModel:(DialogueContentModel *)model {
    self = [super init];
    if (self) {
        _model = model;
        [self addSubview:self.imageBackView];
        [self addSubview:self.contentText];
        [self addSubview:self.time];
    }
    return self;
}

- (void)layoutSubviews {
    CGFloat topMargin = _model.showMessageTime == YES ? 38.0f: 11.0f;
    self.imageBackView.frame = CGRectMake(15, topMargin, _model.contentSize.width+20, _model.contentSize.height);
    
    [self.contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageBackView).with.offset(12);
        make.left.equalTo(self.imageBackView).with.offset(10);
        make.right.equalTo(self.imageBackView.mas_right).with.offset(-10);
        make.height.offset(_model.contentHeight);
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imageBackView.mas_bottom).with.offset(-6);
        make.right.equalTo(self.imageBackView.mas_right).with.offset(-10);
        make.size.mas_offset(CGSizeMake(_model.contentSize.width, 11));
    }];
}

- (UIImageView *)imageBackView {
    if (!_imageBackView) {
        _imageBackView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"Dialogue_Background_Left"]  resizableImageWithCapInsets:UIEdgeInsetsMake(30, 50, 8, 5) resizingMode:UIImageResizingModeStretch]];
        _imageBackView.layer.shadowOffset = CGSizeMake(0, 0);
        _imageBackView.layer.shadowRadius = 4;
        _imageBackView.layer.shadowOpacity = 0.7;
        _imageBackView.layer.shadowColor = RGB(222, 231, 239).CGColor;
    }
    return _imageBackView;
}

- (UILabel *)contentText {
    if (!_contentText) {
        _contentText = [[UILabel alloc] init];
        _contentText.font = [UIFont systemFontOfSize:16];
        _contentText.text = _model.messageText;
        _contentText.numberOfLines = 0;
    }
    return _contentText;
}

- (UILabel *)time {
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.font = [UIFont systemFontOfSize:11];
        _time.textColor = RGB(179, 179, 179);
        _time.text = @"11.23.pm";
        _time.textAlignment = NSTextAlignmentRight;
    }
    return _time;
}
@end
#pragma mark 发送文字
@implementation SendTextCell

- (instancetype)initWithModel:(DialogueContentModel *)model {
    self = [super init];
    if (self) {
        _model = model;
        [self addSubview:self.imageBackView];
        [self addSubview:self.contentText];
        [self addSubview:self.time];
    }
    return self;
}

- (void)layoutSubviews {
    CGFloat topMargin = _model.showMessageTime == YES ? 38.0f: 11.0f;
    [self.imageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.top.equalTo(self).with.offset(topMargin);
        make.size.mas_offset(CGSizeMake(_model.contentSize.width+20, _model.contentSize.height));
    }];
    
    [self.contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageBackView).with.offset(12);
        make.left.equalTo(self.imageBackView).with.offset(10);
        make.right.equalTo(self.imageBackView.mas_right).with.offset(-10);
        make.height.offset(_model.contentHeight);
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imageBackView.mas_bottom).with.offset(-6);
        make.right.equalTo(self.imageBackView.mas_right).with.offset(-10);
        make.size.mas_offset(CGSizeMake(_model.contentSize.width, 11));
    }];
}

- (UIImageView *)imageBackView {
    if (!_imageBackView) {
        _imageBackView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"Dialogue_Background_Right"]  resizableImageWithCapInsets:UIEdgeInsetsMake(30, 9, 6, 50) resizingMode:UIImageResizingModeStretch]];
        _imageBackView.layer.shadowOffset = CGSizeMake(0, 0);
        _imageBackView.layer.shadowRadius = 4;
        _imageBackView.layer.shadowOpacity = 0.7;
        _imageBackView.layer.shadowColor = RGB(222, 231, 239).CGColor;
    }
    return _imageBackView;
}

- (UILabel *)contentText {
    if (!_contentText) {
        _contentText = [[UILabel alloc] init];
        _contentText.font = [UIFont systemFontOfSize:16];
        _contentText.text = _model.messageText;
        _contentText.numberOfLines = 0;
    }
    return _contentText;
}

- (UILabel *)time {
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.font = [UIFont systemFontOfSize:11];
        _time.textColor = RGB(179, 179, 179);
        _time.text = @"11.23.pm";
        _time.textAlignment = NSTextAlignmentRight;
    }
    return _time;
}
@end

#pragma mark 接收音频
@implementation ReceiveVoiceCell

- (instancetype)initWithModel:(DialogueContentModel *)model {
    self = [super init];
    if (self) {
        _model = model;
        [self addSubview:self.imageBackView];
        [self addSubview:self.playerIcon];
        [self addSubview:self.contentSlider];
        [self addSubview:self.longSeconds];
        [self addSubview:self.redView];
        [self addSubview:self.time];
    }
    return self;
}

- (void)layoutSubviews {
    CGFloat topMargin = _model.showMessageTime == YES ? 38.0f: 11.0f;
    [self.imageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(15);
        make.top.equalTo(self).with.offset(topMargin);
        make.size.mas_offset(CGSizeMake(_model.contentSize.width, _model.contentSize.height));
    }];
    
    [self.playerIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageBackView).with.offset(12);
        make.top.equalTo(self.imageBackView).with.offset(7);
        make.size.mas_offset(CGSizeMake(19, 25));
    }];
    
    [self.contentSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageBackView).with.offset(12);
        make.left.equalTo(self.playerIcon.mas_right).with.offset(10);
        make.right.equalTo(self.imageBackView.mas_right).with.offset(-12);
        make.height.offset(20);
    }];
    
    [self.longSeconds mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentSlider);
        make.top.equalTo(self.contentSlider.mas_bottom);
        make.size.mas_offset(CGSizeMake(100, 11));
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imageBackView.mas_bottom).with.offset(-6);
        make.right.equalTo(self.imageBackView.mas_right).with.offset(-10);
        make.size.mas_offset(CGSizeMake(_model.contentSize.width, 11));
    }];
    
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imageBackView.mas_right).with.offset(2);
        make.top.equalTo(self.imageBackView).with.offset(-2);
        make.size.mas_offset(CGSizeMake(7, 7));
    }];
}
#pragma mark method
- (UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage *scaleImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImage;
}
#pragma mark 懒加载
- (UIImageView *)imageBackView {
    if (!_imageBackView) {
        _imageBackView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"Dialogue_Background_Left"]  resizableImageWithCapInsets:UIEdgeInsetsMake(30, 50, 8, 9) resizingMode:UIImageResizingModeStretch]];
        _imageBackView.layer.shadowOffset = CGSizeMake(0, 0);
        _imageBackView.layer.shadowRadius = 4;
        _imageBackView.layer.shadowOpacity = 0.7;
        _imageBackView.layer.shadowColor = RGB(222, 231, 239).CGColor;
    }
    return _imageBackView;
}

- (UISlider *)contentSlider {
    if (!_contentSlider) {
        _contentSlider = [[UISlider alloc] init];
        UIImage *imagea= [self OriginImage:[UIImage imageNamed:@"NavigationBar_Flash"] scaleToSize:CGSizeMake(12, 12)];
        [_contentSlider  setThumbImage:imagea forState:UIControlStateNormal];
    }
    return _contentSlider;
}

- (UIImageView *)playerIcon {
    if (!_playerIcon) {
        _playerIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Dialogue_Voice_Play"]];
    }
    return _playerIcon;
}

-(UILabel *)longSeconds {
    if (!_longSeconds) {
        _longSeconds = [[UILabel alloc] init];
        _longSeconds.text = @"0:12";
        _longSeconds.textColor = [UIColor lightGrayColor];
        _longSeconds.font = [UIFont systemFontOfSize:11];
    }
    return _longSeconds;
}

- (UILabel *)time {
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.textColor = [UIColor lightGrayColor];
        _time.text = @"11.23.pm";
        _time.textAlignment = NSTextAlignmentRight;
        _time.font = [UIFont systemFontOfSize:11];
        
    }
    return _time;
}

- (UIView *)redView {
    if (!_redView) {
        _redView = [[UIView alloc] init];
        _redView.layer.cornerRadius = 3.5f;
        _redView.backgroundColor = RGB(255, 99, 121);
        _redView.layer.shadowOffset = CGSizeMake(0, 0);
        _redView.layer.shadowColor = RGB(128,145,160).CGColor;
        _redView.layer.shadowOpacity = 0.6;
        _redView.layer.shadowRadius = 2;
    }
    return _redView;
}
@end

#pragma mark 发送音频
@implementation SendVoiceCell

- (instancetype)initWithModel:(DialogueContentModel *)model {
    self = [super init];
    if (self) {
        _model = model;
        [self addSubview:self.imageBackView];
        [self addSubview:self.playerIcon];
        [self addSubview:self.contentSlider];
        [self addSubview:self.longSeconds];
        [self addSubview:self.time];
    }
    return self;
}

- (void)layoutSubviews {
    CGFloat topMargin = _model.showMessageTime == YES ? 38.0f: 11.0f;
    [self.imageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.top.equalTo(self).with.offset(topMargin);
        make.size.mas_offset(CGSizeMake(_model.contentSize.width, _model.contentSize.height));
    }];
    
    [self.playerIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imageBackView).with.offset(12);
        make.top.equalTo(self.imageBackView).with.offset(7);
        make.size.mas_offset(CGSizeMake(19, 25));
    }];
    
    [self.contentSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageBackView).with.offset(12);
        make.left.equalTo(self.playerIcon.mas_right).with.offset(10);
        make.right.equalTo(self.imageBackView.mas_right).with.offset(-12);
        make.height.offset(20);
    }];
    
    [self.longSeconds mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentSlider);
        make.top.equalTo(self.contentSlider.mas_bottom);
        make.size.mas_offset(CGSizeMake(100, 11));
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imageBackView.mas_bottom).with.offset(-6);
        make.right.equalTo(self.imageBackView.mas_right).with.offset(-10);
        make.size.mas_offset(CGSizeMake(_model.contentSize.width, 11));
    }];
}
#pragma mark method
- (UIImage *)OriginImage:(UIImage *)image scaleToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage *scaleImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImage;
}
#pragma mark 懒加载
- (UIImageView *)imageBackView {
    if (!_imageBackView) {
        _imageBackView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"Dialogue_Background_Right"]  resizableImageWithCapInsets:UIEdgeInsetsMake(30, 9, 8, 50) resizingMode:UIImageResizingModeStretch]];
        _imageBackView.layer.shadowOffset = CGSizeMake(0, 0);
        _imageBackView.layer.shadowRadius = 4;
        _imageBackView.layer.shadowOpacity = 0.7;
        _imageBackView.layer.shadowColor = RGB(222, 231, 239).CGColor;
    }
    return _imageBackView;
}

- (UISlider *)contentSlider {
    if (!_contentSlider) {
        _contentSlider = [[UISlider alloc] init];
        UIImage *imagea= [self OriginImage:[UIImage imageNamed:@"NavigationBar_Flash"] scaleToSize:CGSizeMake(12, 12)];
        [_contentSlider  setThumbImage:imagea forState:UIControlStateNormal];
    }
    return _contentSlider;
}

- (UIImageView *)playerIcon {
    if (!_playerIcon) {
        _playerIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Dialogue_Voice_Play"]];
    }
    return _playerIcon;
}

-(UILabel *)longSeconds {
    if (!_longSeconds) {
        _longSeconds = [[UILabel alloc] init];
        _longSeconds.text = @"0:12";
        _longSeconds.textColor = [UIColor lightGrayColor];
        _longSeconds.font = [UIFont systemFontOfSize:11];
    }
    return _longSeconds;
}

- (UILabel *)time {
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.textColor = [UIColor lightGrayColor];
        _time.text = @"11.23.pm";
        _time.textAlignment = NSTextAlignmentRight;
        _time.font = [UIFont systemFontOfSize:11];
    }
    return _time;
}

@end


@implementation ReceiveImageCell
- (instancetype)initWithModel:(DialogueContentModel *)model {
    self = [super init];
    if (self) {
        _model = model;
        [self addSubview:self.imageBackView];
        [self addSubview:self.contentImage];
        [self addSubview:self.time];
    }
    return self;
}

- (void)layoutSubviews {
    CGFloat topMargin = _model.showMessageTime == YES ? 38.0f: 11.0f;
    
    [self.imageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(15);
        make.top.equalTo(self).with.offset(topMargin);
        make.size.mas_offset(_model.contentSize);
    }];
    [super layoutSubviews];
}

- (UIImageView *)imageBackView {
    if (!_imageBackView) {
        _imageBackView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"test_Image"]  resizableImageWithCapInsets:UIEdgeInsetsMake(30, 50, 8, 9) resizingMode:UIImageResizingModeStretch]];
        _imageBackView.layer.shadowOffset = CGSizeMake(0, 0);
        _imageBackView.layer.shadowRadius = 4;
        _imageBackView.layer.shadowOpacity = 0.7;
        _imageBackView.layer.shadowColor = RGB(222, 231, 239).CGColor;
    }
    return _imageBackView;
}
@end

@implementation SendImageCell
- (instancetype)initWithModel:(DialogueContentModel *)model {
    self = [super init];
    if (self) {
        _model = model;
        [self addSubview:self.imageBackView];
        [self addSubview:self.contentImage];
        [self addSubview:self.time];
    }
    return self;
}

- (void)layoutSubviews {
    CGFloat topMargin = _model.showMessageTime == YES ? 38.0f: 11.0f;

    [self.imageBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.top.equalTo(self).with.offset(topMargin);
        make.size.mas_offset(_model.contentSize);
    }];
    [super layoutSubviews];

}

- (UIImageView *)imageBackView {
    if (!_imageBackView) {
        _imageBackView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"test_Image"]  resizableImageWithCapInsets:UIEdgeInsetsMake(30, 50, 8, 9) resizingMode:UIImageResizingModeStretch]];
        _imageBackView.layer.shadowOffset = CGSizeMake(0, 0);
        _imageBackView.layer.shadowRadius = 4;
        _imageBackView.layer.shadowOpacity = 0.7;
        _imageBackView.layer.shadowColor = RGB(222, 231, 239).CGColor;
    }
    return _imageBackView;
}


@end
