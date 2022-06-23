//
//  wsyShosePicView.m
//  Woko
//
//  Created by 王树银 on 2022/4/21.
//

#import "wsyShosePicView.h"
#import "WsyShoseProx.h"
#import "WSYBaseCollectionCell.h"



typedef void(^deleteTheShosenPic)(NSIndexPath   *indexP);
@interface ShosePicCollectVCell : WSYBaseCollectionCell

@property(nonatomic,strong)UIButton  *deletBtn;

@property(nonatomic,strong)UIImageView   *imageV;

@property(nonatomic,copy)deleteTheShosenPic  block;

@property(nonatomic,strong)wsyShoseModel   *shoseModel;

@end

@implementation  ShosePicCollectVCell


-(UIImageView *)imageV{
    if (!_imageV) {
        _imageV = [UIImageView new];
        _imageV.contentMode = UIViewContentModeScaleAspectFill;
        _imageV.layer.masksToBounds = true;
        _imageV.layer.cornerRadius = 5.0f;
    }
    return _imageV;
}

-(UIButton *)deletBtn{
    if (!_deletBtn) {
        _deletBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deletBtn setImage:[UIImage mm_xcassetImageNamed:@"wsy_delete_1"] forState:UIControlStateNormal];
        [_deletBtn addTarget:self selector:@selector(delteThePic)];
        _deletBtn.hidden = true;
    }
    return _deletBtn;
}

-(void)setContentUI{
    [self.contentView addSubview:self.imageV];
    [self.contentView addSubview:self.deletBtn];
    [self.contentView bringSubviewToFront:self.deletBtn];
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).offset(10);
        make.bottom.right.mas_equalTo(self.contentView).offset(-10);
    }];
    [self.deletBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.imageV.mas_right);
        make.centerY.mas_equalTo(self.imageV.mas_top);
        make.width.height.equalTo(@20);
    }];
}

-(void)delteThePic{
    if (_block) {
        _block(self.indexpath);
    }
}

-(void)setShoseModel:(wsyShoseModel *)shoseModel{
    _shoseModel = shoseModel;
    if (_shoseModel) {
        self.imageV.image = shoseModel.imgName;
        self.deletBtn.hidden = !_shoseModel.canEdit;
    }
}


@end


@interface wsyShosePicView()<UICollectionViewDelegate,UICollectionViewDataSource,wsyShoseProtocol>

@property(nonatomic,strong)UICollectionViewFlowLayout   *layout;

@property(nonatomic,strong)UICollectionView  *collectV;

//@property(nonatomic,strong)wsyShoseModel  *baseModel;

@end

@implementation wsyShosePicView

-(UICollectionView *)collectV{
    if (!_collectV) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.minimumInteritemSpacing = 4;
        _layout.minimumLineSpacing = 4;
        float  itemWith = (self.frame.size.width - 4*4)/3;
        _layout.itemSize = CGSizeMake(itemWith, itemWith);
        _collectV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.frame.size.height/2 - itemWith/2 - 4, self.frame.size.width, itemWith + 8) collectionViewLayout:_layout];
        _collectV.backgroundColor = [UIColor clearColor];
    }
    return _collectV;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self createTheSubViews];
    }
    return self;
}

-(void)createTheSubViews{
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    [self addSubview:self.collectV];
    self.collectV.delegate = self;
    self.collectV.dataSource = self;
}

-(WsyShoseProx *)shoseProx{
    if (!_shoseProx) {
        _shoseProx = [[WsyShoseProx alloc]init];
//        _shoseProx.delegate = self;
    }
    return _shoseProx;
}

-(void)wsySetShoseProx:(WsyShoseProx *)shoseProx{
    self.shoseProx = shoseProx;
    if (_shoseProx) {
      self.dataArr = self.shoseProx.dataArray;
        [self.collectV reloadData];
    }
}

//-(void)setPicSize:(CGSize)picSize{
//    _picSize = picSize;
//    self.layout.itemSize = self.picSize;
//    _collectV.collectionViewLayout = self.layout;
//}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  self.dataArr.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.shoseProx shosePicWithIndexPath:indexPath withBlock:^{
        self.dataArr = self.shoseProx.dataArray;
        [self.collectV reloadData];
    }];
}

-(__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShosePicCollectVCell  *cell = [ShosePicCollectVCell creatTheCollectView:collectionView AndTheIndexPath:indexPath];
    cell.shoseModel = [self.dataArr objcetSafeGetIndex:indexPath.row];
    cell.block = ^(NSIndexPath *indexP) {
        [self->_shoseProx deleteThePicWithIndexPath:indexPath withBlock:^{
            self->_dataArr = self->_shoseProx.dataArray;
            [self->_collectV reloadData];
        }];
    };
    return cell;
}

-(void)collectReloadData{
    [self.collectV reloadData];
}

-(void)setwsyDataArr:(NSMutableArray *)arr{
    self.dataArr = [NSMutableArray arrayWithArray:arr];
    [self.collectV reloadData];
}

@end
