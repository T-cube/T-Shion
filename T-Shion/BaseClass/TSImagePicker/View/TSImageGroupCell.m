//
//  TSImageGroupCell.m
//  T-Shion
//
//  Created by 王四的mac air on 2018/3/27.
//  Copyright © 2018年 With_Dream. All rights reserved.
//

#import "TSImageGroupCell.h"
#import "PHAssetCollection+TS.h"
#import "NSString+TS.h"

@interface TSImageGroupCell ()

@property (nonatomic, strong) UIImageView *thumbnailImageView;
@property (nonatomic, strong) UILabel *groupNameLabel;
@property (nonatomic, strong) UILabel *photoNumberLabel;

@end

@implementation TSImageGroupCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - private
- (void)setupViews {
    [self.contentView addSubview:self.thumbnailImageView];
    [self.contentView addSubview:self.groupNameLabel];
    [self.contentView addSubview:self.photoNumberLabel];
}

- (void)layoutSubviews {
    __weak typeof(self) weakSelf = self;
    
    [self.thumbnailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(60, 60));
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.groupNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.thumbnailImageView.mas_right).offset(10);
        make.centerY.equalTo(weakSelf);
    }];
    
    [self.photoNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.groupNameLabel.mas_right).offset(15);
        make.centerY.equalTo(weakSelf);
    }];
    
    [super layoutSubviews];
}

- (void)reloadDataWithAssetCollection:(PHAssetCollection *)assetCollection {
    NSString *groupName = assetCollection.localizedTitle;
    
    self.groupNameLabel.text = [NSString replaceEnglishAssetCollectionNamme:groupName];
    self.photoNumberLabel.text = [NSString stringWithFormat:@"(%ld)",[assetCollection numberOfAssets]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        __weak typeof(self) weakSelf = self;
        [assetCollection posterImage:CGSizeMake(60, 60) resultHandler:^(UIImage *result, NSDictionary *info) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.thumbnailImageView.image = result;
            });
        }];
    });
}

#pragma mark - getter and setter
- (UIImageView *)thumbnailImageView {
    if (!_thumbnailImageView) {
        _thumbnailImageView = [[UIImageView alloc] init];
        _thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
        _thumbnailImageView.clipsToBounds = YES;
    }
    return _thumbnailImageView;
}

- (UILabel *)groupNameLabel {
    if (!_groupNameLabel) {
        _groupNameLabel = [[UILabel alloc] init];
        _groupNameLabel.font = [UIFont boldSystemFontOfSize:17];
        _groupNameLabel.textColor = [UIColor TSTextDarkColor];
        _groupNameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _groupNameLabel;
}

- (UILabel *)photoNumberLabel {
    if (!_photoNumberLabel) {
        _photoNumberLabel = [[UILabel alloc] init];
        _photoNumberLabel.font = [UIFont systemFontOfSize:17];
        _photoNumberLabel.textColor = [UIColor TSTextGrayColor];
        _photoNumberLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _photoNumberLabel;
}


@end
