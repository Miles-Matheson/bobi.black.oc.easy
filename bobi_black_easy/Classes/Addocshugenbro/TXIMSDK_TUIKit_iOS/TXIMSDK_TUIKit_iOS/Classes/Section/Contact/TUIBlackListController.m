//
//  TUIBlackListController.m
//  TXIMSDK_TUIKit_iOS
//
//  Created by annidyfeng on 2019/5/5.
//

#import "TUIBlackListController.h"
#import "ReactiveObjC.h"
#import "TUIFriendProfileControllerServiceProtocol.h"
#import "TCServiceManager.h"
#import "UIColor+TUIDarkMode.h"
#import "NSBundle+TUIKIT.h"
#import "Masonry.h"
#import "TUICameraViewController.h"
#import "SVProgressHUD.h"
#import "TUIAvatarViewController.h"
#import "MJRefresh.h"
#import "UIImageView+WebCache.h"
#import "TZImagePickerController.h"
#import "AFNetworking.h"
@interface TUIBlackListController ()

@end

@implementation TUIBlackListController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.view.backgroundColor = [UIColor d_colorWithColorLight:TController_Background_Color dark:TController_Background_Color_Dark];
    self.title = TUILocalizableString(TUIKitContactsBlackList); // @"黑名单";
    self.tableView.delaysContentTouches = NO;

    if (!self.viewModel) {
        self.viewModel = TUIBlackListViewModel.new;
        @weakify(self)
        [RACObserve(self.viewModel, isLoadFinished) subscribeNext:^(id finished) {
            @strongify(self)
            if ([(NSNumber *)finished boolValue])
                [self.tableView reloadData];
        }];
        [self.viewModel loadBlackList];
    }

    [self.tableView registerClass:[TCommonContactCell class] forCellReuseIdentifier:@"FriendCell"];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = self.view.backgroundColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onBlackListChanged:) name:TUIKitNotification_onBlackListAdded object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onBlackListChanged:) name:TUIKitNotification_onBlackListDeleted object:nil];
}

- (void)onBlackListChanged:(NSNotification *)no {
    [self.viewModel loadBlackList];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.blackListData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TCommonContactCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell" forIndexPath:indexPath];
    TCommonContactCellData *data = self.viewModel.blackListData[indexPath.row];
    data.cselector = @selector(didSelectBlackList:);
    [cell fillWithData:data];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 56;
}
/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TCommonContactCellData *data = self.viewModel.blackListData[indexPath.row];

    id<TUIFriendProfileControllerServiceProtocol> vc = [[TCServiceManager shareInstance] createService:@protocol(TUIFriendProfileControllerServiceProtocol)];
    if ([vc isKindOfClass:[UIViewController class]]) {
        vc.friendProfile = data.friendProfile;
        [self.navigationController pushViewController:(UIViewController *)vc animated:YES];
    }
}
 */

-(void)didSelectBlackList:(TCommonContactCell *)cell
{
    TCommonContactCellData *data = cell.contactData;

    id<TUIFriendProfileControllerServiceProtocol> vc = [[TCServiceManager shareInstance] createService:@protocol(TUIFriendProfileControllerServiceProtocol)];
    if ([vc isKindOfClass:[UIViewController class]]) {
        vc.friendProfile = data.friendProfile;
        [self.navigationController pushViewController:(UIViewController *)vc animated:YES];
    }
}
@end


@interface EditAboutCell ()


@end

@implementation EditAboutCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.backgroundColor = [UIColor clearColor];
        [self setupSubviews];
        [self setupSubviewsContrains];
    }
    return self;
}

- (void)setupSubviews{
    self.spView = [ViewInstance defindViewWithFrame:CGRectZero backgroundColor:HexString(@"#363636")];
    ViewBorderRadius(self.spView, 15, 0, [UIColor clearColor]);
    [self.contentView addSubview:self.spView];
    
    self.statusImg = [ViewInstance defindImageViewWithFrame:CGRectZero image:[UIImage imageNamed:TUIKitResource(@"hmhwookahmhrefued")]];
    [self.spView addSubview:self.statusImg];
    
    self.titleLabel = [ViewInstance defindLabelWithFrame:CGRectZero text:@"" textColor:WhiteColor textAlignment:NSTextAlignmentCenter font:MyFont(Font_Bold, 18)];
    [self.spView addSubview:self.titleLabel];
    
    self.editBtn = [ViewInstance defindButOnlyImageWithFrame:CGRectZero image:[UIImage imageNamed:TUIKitResource(@"hmhwookabianji")]];
    [self.spView addSubview:self.editBtn];
    
    self.contentLabel = [ViewInstance defindLabelWithFrame:CGRectZero text:@"" textColor:WhiteColor textAlignment:NSTextAlignmentLeft font:MyFont(Font_Regular, 15)];
    self.contentLabel.numberOfLines = 0;
    [self.spView addSubview:self.contentLabel];
}

- (void)setupSubviewsContrains{
    [self.spView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    [self.statusImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.spView).offset(5);
        make.left.equalTo(self.spView).offset(10);
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(40);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.spView).offset(20);
        make.left.right.equalTo(self.spView);
        make.height.mas_equalTo(15);
    }];
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.spView).offset(-15);
        make.top.equalTo(self.spView).offset(12);
        make.width.height.mas_equalTo(22);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.spView).offset(10);
        make.right.equalTo(self.spView).offset(-10);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(25);
        make.bottom.equalTo(self.spView).offset(-25);
    }];
}


@end


@interface EditPhotosCCell ()

@end

@implementation EditPhotosCCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _pre = [NeighborsSimpleCuteUserModel getUserInfo].appClient.spare17th;
        [self setupSubviews];
        [self setupSubviewsContrains];
    }
    return self;
}

- (void)setupSubviews{
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
    ViewBorderRadius(self.imgView, 5, 0, [UIColor clearColor]);
    [self addSubview:self.imgView];
    
    self.shadeView = [ViewInstance defindViewWithFrame:CGRectZero backgroundColor:HexStringPercent(@"#000000", 0.5)];
    ViewBorderRadius(self.shadeView,5, 0, [UIColor clearColor]);
    [self.imgView addSubview:self.shadeView];
    
    self.statusImg = [ViewInstance defindImageViewWithFrame:CGRectZero image:[UIImage imageNamed:TUIKitResource(@"hmhwookahmhsuo")]];
    [self.shadeView addSubview:self.statusImg];
    {
        self.tipLabel = [ViewInstance defindLabelWithFrame:CGRectZero text:@"Add Photo" textColor:HexString(@"#1F1F1F") textAlignment:NSTextAlignmentCenter font:MyFont(Font_Regular, 14)];
        [self.imgView addSubview:self.tipLabel];
    }
    
    self.statusLabel = [ViewInstance defindLabelWithFrame:CGRectZero text:@"Pending" textColor:WhiteColor textAlignment:NSTextAlignmentCenter font:MyFont(Font_Regular, 14)];
    [self.shadeView addSubview:self.statusLabel];
}

- (void)setupSubviewsContrains{
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self);
        make.height.mas_equalTo(140);
    }];
    [self.shadeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.imgView);
    }];
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.imgView);
        make.top.equalTo(self.imgView).offset(80);
        make.height.mas_equalTo(24);
    }];
    [self.statusImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(20);
        make.centerX.equalTo(self.shadeView.mas_centerX);
        make.top.equalTo(self.shadeView).offset(45);
    }];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statusImg.mas_bottom).offset(12);
        make.left.right.equalTo(self.shadeView);
        make.height.mas_equalTo(15);
    }];
}

- (void)setDic:(NSDictionary *)dic{
    _dic = dic;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",_pre,dic[@"imgUrl"]]]];
    NSInteger reviewStatus = [dic[@"reviewStatus"] integerValue];
    if(reviewStatus == 2){
        self.shadeView.hidden = NO;
        self.statusLabel.text = @"Pending";
        self.statusLabel.textColor = [UIColor whiteColor];
    }else if (reviewStatus == 3){
        self.shadeView.hidden = NO;
        self.statusLabel.text = @"Refused";
        self.statusLabel.textColor = HexString(@"#FF7200");
    }else{
        self.shadeView.hidden = YES;
    }
}

@end

@interface EditPhotoShowCell (){
    
    UIScrollView *_scrollerView;
    
    UIImageView *_imageView;
}

@end

@implementation EditPhotoShowCell

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        _scrollerView = [[UIScrollView alloc] initWithFrame:self.bounds];
        
        [self.contentView addSubview:_scrollerView];
        
        _scrollerView.showsVerticalScrollIndicator = NO;
        
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.frame = self.bounds;
        
        [_scrollerView addSubview:_imageView];
        
        _imageView.clipsToBounds = YES;
        
    }
    
    return self;
    
}

- (void)setValueObj:(id)valueObj{
    _valueObj = valueObj;
    if ([_valueObj isKindOfClass:[UIImage class]]) {
        UIImage *image = (UIImage *)_valueObj;
        CGSize size = image.size;
        
        CGSize imageViewSize = CGSizeMake(IPHONE_WIDTH, IPHONE_WIDTH*size.height/size.width);
        
        _scrollerView.contentSize = imageViewSize;
        
        _imageView.image = image;
        
        if (imageViewSize.height >= _scrollerView.height) {
            
            _imageView.frame = CGRectMake(0, 0, imageViewSize.width, imageViewSize.height);
            
        }else{
            
            _imageView.frame = CGRectMake(0, 0, imageViewSize.width, imageViewSize.height);
            
            _imageView.center = _scrollerView.center;
            
        }
    }else if ([_valueObj isKindOfClass:[NSString class]] && [_valueObj hasPrefix:@"http"]){
        //网络图片
        [_imageView sd_setImageWithURL:[NSURL URLWithString:_valueObj] placeholderImage:[UIImage imageNamed:TUIKitResource(@"n_default_bg")]];
        return;;
        
        
        [_imageView sd_setImageWithURL:[NSURL URLWithString:_valueObj] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (image == nil) {
                image = [UIImage imageNamed:TUIKitResource(@"n_default_bg")];
            }
            CGSize size = image.size;
            
            CGSize imageViewSize = CGSizeMake(IPHONE_WIDTH, IPHONE_WIDTH*size.height/size.width);
            _scrollerView.contentSize = imageViewSize;
            _imageView.image = image;
            if (imageViewSize.height >= _scrollerView.height) {
                _imageView.frame = CGRectMake(0, 0, imageViewSize.width, imageViewSize.height);
            }else{
                _imageView.frame = CGRectMake(0, 0, imageViewSize.width, imageViewSize.height);
                _imageView.center = _scrollerView.center;
            }
        }];
    }
}


@end


@interface EditMyPickerSingleCell ()

@property (nonatomic,strong) UILabel *label;

@end

@implementation EditMyPickerSingleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = HexString(@"#1F1F1F");
        self.label = [ViewInstance defindLabelWithFrame:Setframe(20, 3, Screen_Width-40, 24) text:@"test" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter font:MyFont(Font_Regular, 15)];;
        [self addSubview:self.label];
        ViewBorderRadius(self.label, 3, 0, [UIColor clearColor]);
    }
    return self;
}

- (void)setText:(NSString *)text{
    _text = text;
    self.label.text = _text;
}

- (void)setSelectTag:(BOOL)selectTag{
    _selectTag = selectTag;
    if(_selectTag){
        self.label.backgroundColor = HexString(@"#29292B");
        self.label.textColor = HexString(@"#FACC48");
    }else{
        self.label.backgroundColor = [UIColor clearColor];
        self.label.textColor = [UIColor whiteColor];
    }
}

@end

@interface EditMyPickerView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSString *tipText;
@property (nonatomic,assign) NSInteger flag; //1=单选 2=多选

@property (nonatomic,strong) UIView *contentView;

@property (nonatomic,strong) NSArray *datas;
@property (nonatomic,strong) NSMutableArray *selectArr;

@property (nonatomic,copy) void (^confirmBlock) (NSArray *arr);
@end

@implementation EditMyPickerView

+ (void)showWithData:(NSArray *)arr flag:(NSInteger)flag tipText:(NSString *)tip  block:(void(^)(NSArray * arr))block{
    EditMyPickerView *view = [[EditMyPickerView alloc] initWithFrame:Setframe(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT) WithData:arr flag:flag tipText:tip block:block];
    [KWindow addSubview:view];
}

- (instancetype)initWithFrame:(CGRect)frame WithData:(NSArray *)arr flag:(NSInteger)flag tipText:(NSString *)tip  block:(void(^)(NSArray *))block{
    if(self = [super initWithFrame:frame]){
        self.confirmBlock = block;
        self.tipText = tip;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        self.selectArr = [NSMutableArray array];
        for(int i=0;i<arr.count;i++){
            [self.selectArr addObject:@(NO)];
        }
        self.datas = arr;
        self.flag = flag;
        [self defindContentUI];
        [UIView animateWithDuration:0.25 animations:^{
            self.contentView.mj_y = self.height-self.contentView.height;
        }];
    }
    return self;
}

- (void)defindContentUI{
    self.contentView = [[UIView alloc] initWithFrame:Setframe(0, self.height, self.width, self.flag == 1?self.height/2:self.height/2+37)];
    [self addSubview:self.contentView];
//    UIBezierPath* rounded = [UIBezierPath bezierPathWithRoundedRect:self.contentView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
//    CAShapeLayer* shape = [[CAShapeLayer alloc] init];
//    [shape setPath:rounded.CGPath];
//    self.contentView.layer.mask = shape;
//    self.contentView.clipsToBounds = YES;
    {
        UIView *backView = [[UIView alloc] initWithFrame:Setframe(0, 0, self.width, 37)];
        [self.contentView addSubview:backView];
        backView.backgroundColor = HexString(@"#323232");
        
        UIButton *cancle = [ViewInstance defindButOnlyTileWithFrame:Setframe(0, 0, 27+46, 37) title:@"Cancel" titleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:TUIKitResource(@"上下渐变all")]] titleFont:MyFont(Font_Regular, 15)];
        [backView addSubview:cancle];
        [cancle addTarget:self action:@selector(cancleAction) forControlEvents:1<<6];
        
        UIButton *confirm = [ViewInstance defindButOnlyTileWithFrame:Setframe(self.width-27-46, 0, 27+46, 37) title:@"Choose" titleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:TUIKitResource(@"上下渐变all")]] titleFont:MyFont(Font_Regular, 15)];
        [backView addSubview:confirm];
        [confirm addTarget:self action:@selector(confirmAction) forControlEvents:1<<6];
        UILabel *tipLabel = [ViewInstance defindLabelWithFrame:Setframe(IPHONE_WIDTH/2-50, 0, 100, 37) text:self.tipText textColor:[UIColor colorWithPatternImage:[UIImage imageNamed:TUIKitResource(@"上下渐变all")]] textAlignment:NSTextAlignmentCenter font:MyFont(Font_Regular, 15)];
        [backView addSubview:tipLabel];
    }
    if(self.flag == 2){
        //多一个提示
        UILabel *tipLabel = [ViewInstance defindLabelWithFrame:Setframe(0, 37,self.width, 45) text:@"   You can select multiple ones" textColor:HexString(@"#80898C") textAlignment:NSTextAlignmentLeft font:MyFont(Font_Regular, 15)];
        [self.contentView addSubview:tipLabel];
        tipLabel.backgroundColor = HexString(@"#000000");
    }
    
    CGFloat offset = self.flag == 2?45+37:37;
    UITableView *tableView = [[UITableView alloc] initWithFrame:Setframe(0, offset, self.width, self.contentView.height-offset) style:(UITableViewStylePlain)];
    tableView.backgroundColor = HexString(@"#1F1F1F");
    [self.contentView addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    
}

#pragma mark Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.flag == 1){
        static NSString *flag = @"cell";
        EditMyPickerSingleCell *cell = [tableView dequeueReusableCellWithIdentifier:flag];
        if(!cell){
            cell = [[EditMyPickerSingleCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:flag];
        }
        cell.text = self.datas[indexPath.row];
        cell.selectTag = [self.selectArr[indexPath.row] boolValue];
        return cell;
    }else if (self.flag == 2){
        static NSString *flag = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:flag];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:flag];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = HexString(@"#1F1F1F");
        }
        cell.textLabel.text = self.datas[indexPath.row];
        cell.textLabel.font = MyFont(Font_Regular, 15);
        cell.textLabel.textColor = [UIColor whiteColor];
        if([self.selectArr[indexPath.row] boolValue]){
            cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:TUIKitResource(@"hmhwookaduoxuane")]];
            cell.textLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:TUIKitResource(@"上下渐变all")]];
        }else{
            cell.accessoryView = nil;
            cell.textLabel.textColor = [UIColor whiteColor];
        }
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.flag == 1){
        //单选
        NSMutableArray *arr = [NSMutableArray array];
        for(int i = 0;i<self.selectArr.count;i++){
            if(indexPath.row == i){
                [arr addObject:@(YES)];
            }else{
                [arr addObject:@(NO)];
            }
        }
        self.selectArr = [NSMutableArray arrayWithArray:arr];
    }else if (self.flag == 2){
        //多选
        NSMutableArray *arr = [NSMutableArray array];
        for(int i = 0;i<self.selectArr.count;i++){
            if(indexPath.row == i){
                [arr addObject:[self.selectArr[i] boolValue]?@(NO):@(YES)];
            }else{
                [arr addObject:self.selectArr[i]];
            }
        }
        self.selectArr = [NSMutableArray arrayWithArray:arr];
    }
    [tableView reloadData];
}

#pragma mark Action
- (void)cancleAction{
    [UIView animateWithDuration:0.25 animations:^{
        self.contentView.mj_y = self.height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)confirmAction{
    
    NSMutableArray *arr = [NSMutableArray array];
    for(int i=0;i<self.selectArr.count;i++){
        if([self.selectArr[i] boolValue]){
            [arr addObject:self.datas[i]];
        }
    }
    if(arr.count == 0){
        [self cancleAction];
    }else{
        if(self.confirmBlock){
            self.confirmBlock([NSArray arrayWithArray:arr]);
        }
        [self cancleAction];
    }
}

@end

//  zf  =====  edit View

@interface EditAboutView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *photoList;
@end

@implementation EditAboutView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configurationUI];
    }
    return self;
}

- (void)configurationUI{
    CGFloat btnWidth = IPHONE_WIDTH/3;
    UIImageView *topImg = [ViewInstance defindImageViewWithFrame:Setframe(btnWidth*2+(btnWidth-20)/2, 0, 20, 10) image:[UIImage imageNamed:TUIKitResource(@"hmhwookahmhxiangshangjto")]];
    [self addSubview:topImg];
    //背景
    UIView *bgView = [ViewInstance defindViewWithFrame:Setframe(0, topImg.bottom, self.width, self.height-10) backgroundColor:HexString(@"#262626")];
    [self addSubview:bgView];
    self.tableView = [[UITableView alloc]initWithFrame:Setframe(0, 10, bgView.width, bgView.height) style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [ViewInstance defindViewWithFrame:Setframe(0, 0, self.width, 20+(Is_IPhoneX?34:0)) backgroundColor:[UIColor clearColor]];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;//遵循协议
    self.tableView.dataSource = self;//遵循数据源
    [bgView addSubview:self.tableView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EditAboutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[EditAboutCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
    }
    
    NeighborsSimpleCuteUserModel*model =[ NeighborsSimpleCuteUserModel getUserInfo];
    if(indexPath.row == 0){
        //About me
        NSInteger statue = model.userInfo.spareNum1st;
        NSLog(@"model.userInfo.spareNum1st1111111:%ld",(long)statue);
        if(statue == 3){
            cell.statusImg.hidden = false;
            [cell.statusImg setImage:[UIImage imageNamed:TUIKitResource(@"hmhwookahmhrefued")]];
        }else if (statue == 2){
            cell.statusImg.hidden = false;
            [cell.statusImg setImage:[UIImage imageNamed:TUIKitResource(@"hmhwookahmhpending")]];
        }else{
            cell.statusImg.hidden = YES;
        }
        cell.titleLabel.text = @"About Me";
        if(![GlobalModel isNum:model.userInfo.tempStr2nd] && model.userInfo.tempStr2nd.length > 0){
            cell.contentLabel.text = model.userInfo.tempStr2nd;
            cell.contentLabel.textColor = [UIColor whiteColor];
            //[UIColor colorWithPatternImage:[UIImage imageNamed:TUIKitResource(@"udate-top-bg")]];
        }else if(![GlobalModel isNum:model.userInfo.tempStr1st] && model.userInfo.tempStr1st.length > 0){
            cell.contentLabel.text = model.userInfo.tempStr1st;
            cell.contentLabel.textColor = [UIColor whiteColor];
            //[UIColor colorWithPatternImage:[UIImage imageNamed:TUIKitResource(@"udate-top-bg")]];
        }else{
            cell.contentLabel.text = @"Write a self introduction to let more people know about you";
            cell.contentLabel.textColor = RGB(255, 138, 0);
        }
    }else if (indexPath.row == 1){
        //About Match
        NSInteger statue = model.userInfo.spareNum3rd;
        if(statue == 3){
            cell.statusImg.hidden = false;
            [cell.statusImg setImage:[UIImage imageNamed:TUIKitResource(@"hmhwookahmhrefued")]];
        }else if (statue == 2){
            cell.statusImg.hidden = false;
            [cell.statusImg setImage:[UIImage imageNamed:TUIKitResource(@"hmhwookahmhpending")]];
        }else{
            cell.statusImg.hidden = YES;
        }
        cell.titleLabel.text = @"About Match";
        if(![GlobalModel isNum:model.userInfo.tempStr8th] && model.userInfo.tempStr8th.length > 0){
            cell.contentLabel.text = model.userInfo.tempStr8th;
            cell.contentLabel.textColor = [UIColor whiteColor];
            //[UIColor colorWithPatternImage:[UIImage imageNamed:TUIKitResource(@"udate-top-bg")]];
        }else if(![GlobalModel isNum:model.userInfo.tempStr9th] && model.userInfo.tempStr9th.length > 0){
            cell.contentLabel.text = model.userInfo.tempStr9th;
            cell.contentLabel.textColor = [UIColor whiteColor];
            //[UIColor colorWithPatternImage:[UIImage imageNamed:TUIKitResource(@"udate-top-bg")]];
        }else{
            cell.contentLabel.text = @"Write down the idea of dating and let more people find you interesting.";
            cell.contentLabel.textColor = RGB(255, 138, 0);
        }
    }else if (indexPath.row == 2){
        cell.statusImg.hidden = true;
        cell.titleLabel.text = @"Contact";
        if(![GlobalModel isNum:model.userInfo.introduce] && model.userInfo.introduce.length > 0){
            cell.contentLabel.text = model.userInfo.introduce;
            cell.contentLabel.textColor = [UIColor whiteColor];
            //[UIColor colorWithPatternImage:[UIImage imageNamed:TUIKitResource(@"udate-top-bg")]];
        }else{
            cell.contentLabel.text = @"Write down the contact information let more people find you interesting.";
            cell.contentLabel.textColor = RGB(255, 138, 0);
        }
    }
    cell.editBtn.tag = indexPath.row;
    [cell.editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:1<<6];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)editBtnClick:(UIButton *)sender{
    if(self.sectionClickedBlock){
        NSString *text = @"";
        BOOL isPlace = NO;
        NeighborsSimpleCuteUserModel*model =[ NeighborsSimpleCuteUserModel getUserInfo];
        if(sender.tag == 0){
            //About me
            if(![GlobalModel isNum:model.userInfo.tempStr2nd] && model.userInfo.tempStr2nd.length > 0){
                text = model.userInfo.tempStr2nd;
            }else if(![GlobalModel isNum:model.userInfo.tempStr1st] && model.userInfo.tempStr1st.length > 0){
                text = model.userInfo.tempStr1st;
            }else{
                text = @"Write a self introduction to let more people know about you";
                isPlace = YES;
            }
        }else if (sender.tag == 1){
            //About Match
            if(![GlobalModel isNum:model.userInfo.tempStr8th] && model.userInfo.tempStr8th.length > 0){
                text = model.userInfo.tempStr8th;
            }else if(![GlobalModel isNum:model.userInfo.tempStr9th] && model.userInfo.tempStr9th.length > 0){
                text = model.userInfo.tempStr9th;
            }else{
                text = @"Write down the idea of dating and let more people find you interesting.";
                isPlace = YES;
            }
        }else if (sender.tag == 2){
            if(![GlobalModel isNum:model.userInfo.introduce] && model.userInfo.introduce.length > 0){
                text = model.userInfo.introduce;
            }else{
                text = @"Write down you contact";
                isPlace = YES;
            }
        }
        self.sectionClickedBlock(sender.tag,text,isPlace);
    }
}

- (void)getRedNumber{
    int count = 0;
    NeighborsSimpleCuteUserModel*model =[ NeighborsSimpleCuteUserModel getUserInfo];
    if(![GlobalModel isNum:model.userInfo.tempStr2nd] && model.userInfo.tempStr2nd.length > 0){
        count = count +1;
    }else if(![GlobalModel isNum:model.userInfo.tempStr1st] && model.userInfo.tempStr1st.length > 0){
        count = count +1;
    }
    if(![GlobalModel isNum:model.userInfo.tempStr8th] && model.userInfo.tempStr8th.length > 0){
        count = count +1;
    }else if(![GlobalModel isNum:model.userInfo.tempStr9th] && model.userInfo.tempStr9th.length > 0){
        count = count +1;
    }
    if(![GlobalModel isNum:model.userInfo.introduce] && model.userInfo.introduce.length > 0){
        count = count +1;
    }
    if(self.updateRedNumber){
        self.updateRedNumber(count);
    }
}

- (void)refreshData{
    [self.tableView reloadData];
}

@end

@interface EditPhotosView()
<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSInteger _page;
}

@end

@implementation EditPhotosView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.photoList = [NSMutableArray array];
        _page = 1;
        [self configurationUI];
        if(Is_IPhoneX){
            self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, Height_NavBar, 0);
        }
        
    }
    return self;
}

- (void)configurationUI{
    CGFloat btnWidth = IPHONE_WIDTH/3;
    UIImageView *topImg = [ViewInstance defindImageViewWithFrame:Setframe((btnWidth-20)/2, 0, 20, 10) image:[UIImage imageNamed:TUIKitResource(@"hmhwookahmhxiangshangjto")]];
    [self addSubview:topImg];
    //背景
    UIView *bgView = [ViewInstance defindViewWithFrame:Setframe(0, topImg.bottom, self.width, self.height-10) backgroundColor:HexString(@"#262626")];
    [self addSubview:bgView];
    UICollectionViewFlowLayout *lay = [UICollectionViewFlowLayout new];
    lay.itemSize = CGSizeMake((IPHONE_WIDTH-60)/3, 140);
    lay.sectionInset = UIEdgeInsetsZero;
    lay.minimumLineSpacing = 15;
    lay.minimumInteritemSpacing = 10;
    self.collectionView = [[UICollectionView alloc] initWithFrame:Setframe(15, 15, bgView.width-30, bgView.height-30) collectionViewLayout:lay];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsVerticalScrollIndicator = false;
    [self.collectionView registerClass:[EditPhotosCCell class] forCellWithReuseIdentifier:@"cell"];
    [bgView addSubview:self.collectionView];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestInterface:1];
    }];
    self.collectionView.mj_header = header;
    
//    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//        StrongSelf(self);
//        [self requestInterface:2];
//    }];
//    self.collectionView.mj_footer = footer;
    header.loadingView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    header.lastUpdatedTimeLabel.textColor = [UIColor whiteColor];
    header.stateLabel.textColor = [UIColor whiteColor];
//    footer.loadingView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
//    footer.stateLabel.textColor = [UIColor whiteColor];
    [self.collectionView.mj_header beginRefreshing];
    
}


#pragma mark Delegate OR DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(self.photoList.count == 0){
        return 1;
    }else if (self.photoList.count == 20){
        return 20;
    }else{
        return self.photoList.count+1;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *flag = @"cell";
    EditPhotosCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:flag forIndexPath:indexPath];
    if(indexPath.row == self.photoList.count){
        [cell.imgView setImage:[UIImage imageNamed:TUIKitResource(@"hmhadd_photohmh")]];
        cell.shadeView.hidden = true;
        cell.tipLabel.hidden = NO;
    }else{
        //[cell.imgView sd_setImageWithURL:self.photoList[indexPath.row] placeholderImage:[UIImage imageNamed:@"test"]];
        cell.dic = self.photoList[indexPath.row];
        cell.tipLabel.hidden = YES;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //最后一张添加照片，其他预览
    if(indexPath.row == self.photoList.count){
        //添加照片
        if(self.addPhotoClickedBlock){
            self.addPhotoClickedBlock();
        }
    }else{
        NSMutableArray *arr = [NSMutableArray array];
        for(int i=0;i<self.photoList.count;i++){
            NSString *imgUrl = self.photoList[i][@"imgUrl"];
            [arr addObject:imgUrl];
        }
        if(self.previewPhotoClickedBlock){
            self.previewPhotoClickedBlock(indexPath.row+1,arr);
        }
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((IPHONE_WIDTH-60)/3, 140);
}
- (void)requestInterface:(NSInteger)tag{
//    if(tag == 1){
//        //下啦刷新
//        _page = 1;
//    }else if (tag == 2){
//        //上啦加载
//        _page = _page+1;
//
//    }else{
//        return;;
//    }
    self.updateRedNumber(0);
    NeighborsSimpleCuteUserModel *model = [NeighborsSimpleCuteUserModel getUserInfo];
    NSInteger userid = model.account.userId;
    NSString *baseUrl    = [NSString stringWithFormat:@"%@%@/%ld",NSC_Base_Url,@"/api/relation/visitor",userid];
    NSLog(@"baseUrl:%@",baseUrl);
    [[NeighborsSimpleCuteNetworkTool sharedNetworkTool]POST:baseUrl parameters:@{} success:^(NeighborsSimpleCuteResposeModel * _Nonnull response) {
        NSLog(@"update:%@",response.data);
        [self.collectionView.mj_header endRefreshing];
//        [self.collectionView.mj_footer endRefreshing];
        if(response.code == 0){
            self.photoList = [NSMutableArray arrayWithArray:response.data[@"photos"]];
//            if(tag == 1){
//                self.photoList = [NSMutableArray arrayWithArray:response.data];
//            }else{
//                [self.photoList addObjectsFromArray:response.data];
//            }
            [self.collectionView reloadData];
            [self update];
//            if(self.updateRedNumber){
//                self.updateRedNumber(self.photoList.count);
//            }
        }
    } failure:^(NSError * _Nonnull error) {
        [self.collectionView.mj_header endRefreshing];
//        [self.collectionView.mj_footer endRefreshing];
    }];
}

- (void)update{
    if(self.photoList.count == 0){
        if(self.updateRedNumber){
            self.updateRedNumber(2);
        }
    }else if (self.photoList.count == 1){
        if(self.updateRedNumber){
            self.updateRedNumber(1);
        }
    }else{
        if(self.updateRedNumber){
            self.updateRedNumber(0);
        }
    }
}
@end

@interface EditDetailsView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSMutableArray *leftArr;
@property (nonatomic,strong) NSMutableArray *rightArr;
@end
@implementation EditDetailsView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configurationUI];
    }
    return self;
}

- (void)configurationUI{
    
    self.leftArr = [NSMutableArray array];
    self.rightArr = [NSMutableArray array];
    
    for(int i=0;i<14;i++){
        switch (i) {
            case 0:
            {
                //身高
                [self.leftArr addObject:@"Height"];
                NSString *text = [NeighborsSimpleCuteUserModel getUserInfo].userInfo.spareStr1st;
                if([GlobalModel isNum:text] || [text containsString:@"Please"]){
                    [self.rightArr addObject:@""];
                }else{
                    [self.rightArr addObject:text];
                }
            }
                break;
            case 1:
            {
                //体型
                [self.leftArr addObject:@"Body type"];
                NSString *text = [NeighborsSimpleCuteUserModel getUserInfo].userInfo.spareStr2nd;
                if([GlobalModel isNum:text]){
                    [self.rightArr addObject:@""];
                }else{
                    [self.rightArr addObject:text];
                }
            }
                break;
            case 2:
            {
                //眼睛颜色
                [self.leftArr addObject:@"Eye color"];
                NSString *text = [NeighborsSimpleCuteUserModel getUserInfo].userInfo.spareStr3rd;
                if([GlobalModel isNum:text]){
                    [self.rightArr addObject:@""];
                }else{
                    [self.rightArr addObject:text];
                }
            }
                break;
            case 3:
            {
                //头发颜色
                [self.leftArr addObject:@"Hair color"];
                NSString *text = [NeighborsSimpleCuteUserModel getUserInfo].userInfo.spareStr4th;
                if([GlobalModel isNum:text]){
                    [self.rightArr addObject:@""];
                }else{
                    [self.rightArr addObject:text];
                }
            }
                break;
            case 4:
            {
                //星座
                [self.leftArr addObject:@"Sign"];
                NSString *text = [NeighborsSimpleCuteUserModel getUserInfo].userInfo.spareStr5th;
                if([GlobalModel isNum:text]){
                    [self.rightArr addObject:@""];
                }else{
                    [self.rightArr addObject:text];
                }
            }
                break;
            case 5:
            {
                //职业
                [self.leftArr addObject:@"Occupation"];
                NSString *text = [NeighborsSimpleCuteUserModel getUserInfo].userInfo.spareStr8th;
                if([GlobalModel isNum:text]){
                    [self.rightArr addObject:@""];
                }else{
                    [self.rightArr addObject:text];
                }
            }
                break;
            case 6:
            {
                //教育
                [self.leftArr addObject:@"Education"];
                NSString *text = [NeighborsSimpleCuteUserModel getUserInfo].userInfo.spareStr9th;
                if([GlobalModel isNum:text]){
                    [self.rightArr addObject:@""];
                }else{
                    [self.rightArr addObject:text];
                }
            }
                break;
            case 7:
            {
                //收入
                [self.leftArr addObject:@"Income"];
                NSString *text = [NeighborsSimpleCuteUserModel getUserInfo].userInfo.spareStr11th;
                if([GlobalModel isNum:text]){
                    [self.rightArr addObject:@""];
                }else{
                    [self.rightArr addObject:text];
                }
            }
                break;
            case 8:
            {
                //吸烟
                [self.leftArr addObject:@"Smoking"];
                NSString *text = [NeighborsSimpleCuteUserModel getUserInfo].userInfo.spareStr14th;
                if([GlobalModel isNum:text] || [text containsString:@"You"]){
                    [self.rightArr addObject:@""];
                }else{
                    [self.rightArr addObject:text];
                }
            }
                break;
            case 9:
            {
                //饮酒
                [self.leftArr addObject:@"Drinking"];
                NSString *text = [NeighborsSimpleCuteUserModel getUserInfo].userInfo.spareStr15th;
                if([GlobalModel isNum:text] || [text containsString:@"You"]){
                    [self.rightArr addObject:@""];
                }else{
                    [self.rightArr addObject:text];
                }
            }
                break;
            case 10:
            {
                //语言
                [self.leftArr addObject:@"Language"];
                NSString *text = [NeighborsSimpleCuteUserModel getUserInfo].userInfo.spareStr7th;
                if([GlobalModel isNum:text]){
                    [self.rightArr addObject:@""];
                }else{
                    [self.rightArr addObject:text];
                }
            }
                break;
            case 11:
            {
                //个性
                [self.leftArr addObject:@"Personality"];
                NSString *text = [NeighborsSimpleCuteUserModel getUserInfo].userInfo.spareStr6th;
                if([GlobalModel isNum:text]){
                    [self.rightArr addObject:@""];
                }else{
                    [self.rightArr addObject:text];
                }
            }
                break;
            case 12:
            {
                //音乐
                [self.leftArr addObject:@"Music prefer"];
                NSString *text = [NeighborsSimpleCuteUserModel getUserInfo].userInfo.spareStr10th;
                if([GlobalModel isNum:text]){
                    [self.rightArr addObject:@""];
                }else{
                    [self.rightArr addObject:text];
                }
            }
                break;
            case 13:
            {
                //车
                [self.leftArr addObject:@"Car"];
                NSString *text = [NeighborsSimpleCuteUserModel getUserInfo].userInfo.spareStr12th;
                if([GlobalModel isNum:text]){
                    [self.rightArr addObject:@""];
                }else{
                    [self.rightArr addObject:text];
                }
            }
                break;
            default:
                break;
        }
    }
    
    CGFloat btnWidth = IPHONE_WIDTH/3;
    UIImageView *topImg = [ViewInstance defindImageViewWithFrame:Setframe(btnWidth+(btnWidth-20)/2, 0, 20, 10) image:[UIImage imageNamed:TUIKitResource(@"hmhwookahmhxiangshangjto")]];
    [self addSubview:topImg];
    
    //#262626
    UITableView *table = [[UITableView alloc] initWithFrame:Setframe(0, 10, self.width, self.height-10) style:(UITableViewStylePlain)];
    self.table = table;
    [self addSubview:table];
    table.delegate = self;
    table.dataSource = self;
    table.backgroundColor = HexString(@"#262626");
    table.rowHeight = 65;
    table.contentInset = UIEdgeInsetsMake(0, 0, NavigationHeight, 0);
}

#pragma mark Dlegate OR Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.leftArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *flag = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:flag];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:flag];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = MyFont(Font_Regular, 15);
        cell.detailTextLabel.font = MyFont(Font_Regular, 15);
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:TUIKitResource(@"hmhwookafanhui")]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = HexString(@"#262626");
    }
    cell.textLabel.text = self.leftArr[indexPath.row];
    if([self.rightArr[indexPath.row] length] == 0){
        cell.detailTextLabel.text = @"Add";
        cell.detailTextLabel.textColor = [UIColor whiteColor];
    }else{
        cell.detailTextLabel.text = self.rightArr[indexPath.row];
        cell.detailTextLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:TUIKitResource(@"udate-top-bg")]];
    }
    return cell;;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self showPiker:indexPath.row];
}

- (void)showPiker:(NSInteger)row{
    NSArray *arr ;
    NSInteger flag = 1;
    if(row == 0){
        arr = @[@"4' 5\" (135 cm)",@"4'6\" (137 cm)",@"4' 7\" (140 cm)",@"4' 8\" (142 cm)",@"4' 9\" (145 cm)",@"4' 10\" (147 cm)",@"4' 11\" (150 cm)",@"5' 0\" (152 cm)",@"5' 1\" (155 cm)",@"5' 2\" (157 cm)",@"5' 3\" (160 cm)",@"5' 4\" (163 cm)",@"5' 5\" (165 cm)",@"5' 6\" (168 cm)",@"5' 7\" (170 cm)",@"5' 8\" (173 cm)",@"5' 9\" (175 cm)",@"5' 10\" (178 cm)",@"5' 11\" (180 cm)",@"6' 1\" (183 cm)",@"6' 2\" (185 cm)",@"6' 3\" (188 cm)",@"6' 4\" (190 cm)",@"6' 5\" (193 cm)",@"6' 6\" (196 cm)",@"6' 7\" (198 cm)",@"6' 8\" (201 cm)",@"6' 9\" (203 cm)",@"6' 10\" (206 cm)",@"6' 11\" (211 cm)"];
        flag = 1;
    }else if (row == 1){
        arr = @[@"A few extra pounds",@"Athletic",@"Stocky",@"Full-figured",@"Average",@"Slim",@"Petite",@"Curvy",@"Fit"];
        flag = 1;
    }else if (row == 2){
        arr = @[@"Black",@"Blue",@"Brown",@"Gray",@"Green",@"Hazel",@"Other"];
        flag = 1;
    }else if (row == 3){
        arr = @[@"Black",@"Blue",@"Brown",@"Gray",@"Green",@"Hazel",@"Other"];
        flag = 1;
    }else if (row == 4){
        arr = @[@"Aries",@"Taurus",@"Gemini",@"Cancer",@"Leo",@"Virgo",@"Libra",@"Scorpio",@"Sagittarius",@"Capricorn",@"Aquarius",@"Pisces"];
        flag = 1;
    }else if (row == 5){
        arr = @[@"Student",@"Teacher",@"Model",@"Artistic",@"Musical",@"Writer",@"Fashion ",@"Actor",@"Secretarial",@"Administrative",@"Design",@"Management",@"Civil Service",@"Self Employed",@"Entrepreneur",@"Sales",@"Marketing",@"Retired",@"inance",@"Investor",@"Accounting",@"Technical",@"Science",@"Engineering",@"Other"];
        flag = 1;
    }else if (row == 6){
        arr = @[@"High school",@"Some college",@"Current college student",@"Associate's / 2-Year Degree",@"Bachelor's / 4-Year Degree",@"Current grad school student",@"Graduate / Master's Degree",@"PhD. / Post Doctoral",@"Other"];
        flag = 1;
    }else if (row == 7){
        arr = @[@"Less than $250,000",@"$250,001 to $500,000",@"$500,001 to $750,000",@"$750,001 to $1000,000",@"$1000,001 to $2000,000",@"More than $2000,000"];
        flag = 1;
    }else if (row == 8){
        arr = @[@"Doesn't smoke",@"Smoke socially",@"Smoke regularly",@"Trying to quit"];
        flag = 1;
    }else if (row == 9){
        arr = @[@"Doesn't drink",@"Drink socially",@"Drink regularly",@"Trying to quit"];
        flag = 1;
    }else if (row == 10){
        arr = @[@"English",@"Chinese",@"Czech",@"Danish",@"Dutch",@"French",@"German",@"Greek",@"Hebrew",@"Italian",@"Japanese",@"Korean",@"Norwegian",@"Polish",@"Portuguese",@"Sign Language",@"Spanish",@"Swedish",@"Other"];
        flag = 2;
    }else if (row == 11){
        arr = @[@"Adventurous",@"Artistic",@"Confident",@"Compassionate",@"Independent",@"Social",@"Political",@"Romantic",@"Old-fashioned",@"Trustworthy"];
        flag = 2;
    }else if (row == 12){
        arr = @[@"Alternative",@"Classical",@"Classic Rock",@"Country",@"Elvis",@"Electronic / Dance Music",@"Folk Rock",@"Gospel",@"Heavy Metal",@"Jazz / Blues",@"Pop / Top 40",@"Punk",@"Rap / Hip Hop",@"Rock n' Roll",@"R&B / Soul",@"Women Who Rock"];
        flag = 2;
    }else if (row == 13){
        arr = @[@"Acura",@"Aston Martin",@"Audi",@"Bentley",@"BMW",@"Cadillac",@"Ferrari",@"GMC",@"Infiniti",@"Jaguar",@"Lamborghini",@"Land Rover",@"Lexus",@"Limousine",@"Lincoln",@"Maserati",@"McLaren",@"Mercedes-Benz",@"Porsche",@"Rolls-Royce",@"Saab",@"Tesla",@"Volvo",@"Other"];
        flag = 2;
    }
    WeakSelf2(self);
    [EditMyPickerView showWithData:arr flag:flag tipText:self.leftArr[row] block:^(NSArray * _Nonnull arr) {
        StrongSelf(self);
        [self.rightArr replaceObjectAtIndex:row withObject:[arr componentsJoinedByString:@" | "]];
        [self.table reloadData];
        [self requestInterface:row string:self.rightArr[row]];
        [self autoSelectNext];
        [self getRedNumber];
        
    }];
}

- (void)requestInterface:(NSInteger)row string:(NSString *)text{
    NSDictionary *param;
    switch (row) {
        case 0:
        {
            //身高
            param = @{@"spareStr1st":text};
        }
            break;
        case 1:
        {
            //体型
            param = @{@"spareStr2nd":text};
        }
            break;
        case 2:
        {
            //眼睛颜色
            param = @{@"spareStr3rd":text};
        }
            break;
        case 3:
        {
            //头发颜色
            param = @{@"spareStr4th":text};
        }
            break;
        case 4:
        {
            //星座
            param = @{@"spareStr5th":text};
        }
            break;
        case 5:
        {
            //职业
            param = @{@"spareStr8th":text};
        }
            break;
        case 6:
        {
            //教育
            param = @{@"spareStr9th":text};
        }
            break;
        case 7:
        {
            //收入
            param = @{@"spareStr11th":text};
        }
            break;
        case 8:
        {
            //吸烟
            param = @{@"spareStr14th":text};
        }
            break;
        case 9:
        {
            //饮酒
            param = @{@"spareStr15th":text};
        }
            break;
        case 10:
        {
            //语言
            param = @{@"spareStr7th":text};
        }
            break;
        case 11:
        {
            //个性
            param = @{@"spareStr6th":text};
        }
            break;
        case 12:
        {
            //音乐
            param = @{@"spareStr10th":text};
        }
            break;
        case 13:
        {
            //车
            param = @{@"spareStr12th":text};
        }
            break;
        default:
            break;
    }
        NSString *baseUrl    = [NSString stringWithFormat:@"%@%@",NSC_Base_Url,@"api/account/user/update"];
        [[NeighborsSimpleCuteNetworkTool sharedNetworkTool]POST:baseUrl parameters:param success:^(NeighborsSimpleCuteResposeModel * _Nonnull response) {
            if(response.code == 0){
                NeighborsSimpleCuteUserModel *model = [NeighborsSimpleCuteUserModel getUserInfo];
                switch (row) {
                    case 0:
                    {
                        //身高
                        model.userInfo.spareStr1st = text;
                    }
                        break;
                    case 1:
                    {
                        //体型
                        model.userInfo.spareStr2nd = text;
                    }
                        break;
                    case 2:
                    {
                        //眼睛颜色
                        model.userInfo.spareStr3rd = text;
                    }
                        break;
                    case 3:
                    {
                        //头发颜色
                        model.userInfo.spareStr4th = text;
                    }
                        break;
                    case 4:
                    {
                        //星座
                        model.userInfo.spareStr5th = text;
                    }
                        break;
                    case 5:
                    {
                        //职业
                        model.userInfo.spareStr8th = text;
                    }
                        break;
                    case 6:
                    {
                        //教育
                        model.userInfo.spareStr9th = text;
                    }
                        break;
                    case 7:
                    {
                        //收入
                        model.userInfo.spareStr11th = text;
                    }
                        break;
                    case 8:
                    {
                        //吸烟
                        model.userInfo.spareStr14th = text;
                    }
                        break;
                    case 9:
                    {
                        //饮酒
                        model.userInfo.spareStr15th = text;
                    }
                        break;
                    case 10:
                    {
                        //语言
                        model.userInfo.spareStr7th = text;
                    }
                        break;
                    case 11:
                    {
                        //个性
                        model.userInfo.spareStr6th = text;
                    }
                        break;
                    case 12:
                    {
                        //音乐
                        model.userInfo.spareStr10th = text;
                    }
                        break;
                    case 13:
                    {
                        //车
                        model.userInfo.spareStr12th = text;
                    }
                        break;
                    default:
                        break;
                }
                [NeighborsSimpleCuteUserModel save:model];
            }
            
        } failure:^(NSError * _Nonnull error) {
            
        }];
}

- (void)autoSelectNext{
    for(int i=0;i<self.rightArr.count;i++){
        if([self.rightArr[i] length] == 0){
            [self showPiker:i];
            return;;
        }
    }
}

- (void)getRedNumber{
    int count = 0;
    for(int i=0;i<self.rightArr.count;i++){
        if([self.rightArr[i] length] > 0){
            count = count+1;
        }
    }
    if(self.updateRedNumber){
        self.updateRedNumber(count);
    }
}

//选择
- (void)selectItemAction:(UIButton *)sender {
    if(self.itemSelectClickedBlock){
        self.itemSelectClickedBlock(sender.tag);
        [sender setTitleColor:HexString(@"#B07F42") forState:0];
    }
}

@end

@interface NeighborsSimpleCuteBase2Controller ()
@end
@implementation NeighborsSimpleCuteBase2Controller
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = NSC_BGThemColor;
    [self setupBaseUI];
}
-(void)setupBaseUI
{
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appence = [[UINavigationBarAppearance alloc]init];
        [appence configureWithOpaqueBackground];
        NSDictionary * attributes = @{
                                   NSForegroundColorAttributeName:[UIColor whiteColor],
                                    NSFontAttributeName:[UIFont boldSystemFontOfSize:18]
                                      };
        [appence setTitleTextAttributes:attributes];
        appence.backgroundColor = NSC_MainThemColor;
        self.navigationController.navigationBar.barTintColor = NSC_MainThemColor;
        self.navigationController.navigationBar.standardAppearance = appence;
        self.navigationController.navigationBar.scrollEdgeAppearance = appence;
        [self.navigationController.navigationBar setTranslucent:NO];
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
        [self setNeedsStatusBarAppearanceUpdate];
    }else{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
            {
                self.automaticallyAdjustsScrollViewInsets = NO;
                self.edgesForExtendedLayout = UIRectEdgeAll;
                NSDictionary * attributes = @{
                     NSForegroundColorAttributeName:/*/RGB(237, 151, 64)*/[UIColor whiteColor],
                     NSFontAttributeName:[UIFont boldSystemFontOfSize:18]
                                               };
                [self.navigationController.navigationBar setTitleTextAttributes:attributes];
                self.navigationController.navigationBar.barTintColor = NSC_MainThemColor;
                [self.navigationController.navigationBar setTranslucent:NO];
                [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
                self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
                [self setNeedsStatusBarAppearanceUpdate];
        }
    }
    [self setNSCBackwardButton];
}

-(void)setNSCBackwardButton
{
    NSArray *viewControllers = [self.navigationController viewControllers];
    if (viewControllers.count > 1) {
        UIImage *image =[UIImage imageNamed:TUIKitResource(@"n_back")];
        UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [leftBtn setImage:image forState:UIControlStateNormal];
        leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
        leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [leftBtn addTarget:self action:@selector(onNECLeftBackBtn:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    }
}
-(void)onNECLeftBackBtn:(UIButton *)btn
{
    NSArray *viewControllers = [self.navigationController viewControllers];
    // 根据viewControllers的个数来判断此控制器是被present的还是被push的
    if (1 <= viewControllers.count && 0 < [viewControllers indexOfObject:self])
    {
         [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (float)NeighborsSimpleCuteProjectGetLabelHeightWithText:(NSString *)text width:(float)width font: (float)font
{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    return rect.size.height;
}

- (void)NeighborsSimpleCuteSetLeftButton:(UIImage *)leftImg
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:leftImg forState:UIControlStateNormal];
    // button size
    btn.frame = CGRectMake(0, 0, 40, 40);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0.0, -5, 0.0, 5.0);
    // button target
    [btn addTarget:self action:@selector(onNeighborsSimpleCuteLeftBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = barItem;
}

- (void)NeighborsSimpleCuteSetRightButton:(UIImage *)rightImg
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:rightImg forState:UIControlStateNormal];
    // button size
    btn.frame = CGRectMake(0, 0, 40, 40);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
    // button target
    [btn addTarget:self action:@selector(onNeighborsSimpleCuteRightBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barItem;
}

- (void)onNeighborsSimpleCuteLeftBackBtn:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)onNeighborsSimpleCuteRightBackBtn:(UIButton *)btn
{
    
}
-(NSMutableString *)getRandWithLetters
{
    NSMutableString *changeString;
    NSMutableArray *araay = [[NSMutableArray alloc]initWithObjects:@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];//存放多个数，以备随机取,也可以加上大写字母和其他符号
    NSMutableString* getStr = [[NSMutableString alloc]initWithCapacity:5];
    changeString = [[NSMutableString alloc]initWithCapacity:6];//申请内存空间
    for(int i = 0; i < 6; i++) {
    NSInteger index =arc4random()%([araay count]-1);//循环六次，得到一个随机数，作为下标值取数组里面的数放到一个可变字符串里，在存放到自身定义的可变字符串
    getStr = araay[index];
    changeString= (NSMutableString*)[changeString stringByAppendingString:getStr];
    }
    NSLog(@"%@",changeString);
    return changeString;
}
@end

@interface EditInputController ()<UITextViewDelegate>
@property (nonatomic,strong) EaseTextView *field;
@property (nonatomic,strong) UILabel *limitLabel;
@end

@implementation EditInputController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if(self.index == 1){
        self.title = @"About me";
    }else if (self.index == 2){
        self.title = @"About Match";
    }else if (self.index == 3){
        self.title = @"Contact";
    }
    UIButton *but = [ViewInstance defindButOnlyTileWithFrame:Setframe(0, 0, 50, NavigationHeight-StatusBarHeight) title:@"Save" titleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:TUIKitResource(@"udate-top-bg")]] titleFont:MyFont(Font_Regular, 18)];
    [but addTarget:self action:@selector(saveAction) forControlEvents:1<<6];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:but];
    
    [self defindContentUI];
}

- (void)defindContentUI{
    UIView *view = [ViewInstance defindViewWithFrame:Setframe(5, 10, Screen_Width-10, 300) backgroundColor:HexString(@"#363636")];
    ViewBorderRadius(view, 5, 0, [UIColor clearColor]);
    [self.view addSubview:view];
    
    EaseTextView *field = [[EaseTextView alloc] initWithFrame:Setframe(0, 0, view.width, 260)];
    [view addSubview:field];
    field.placeHolder = @"Input Text";
    field.placeHolderTextColor = HexString(@"#C6C6C6");
    field.font = MyFont(Font_Regular, 15);
    field.textColor = [UIColor whiteColor];
    //textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:TUIKitResource(@"udate-top-bg")]];
    field.delegate = self;
    if(self.isPalceholder){
        field.placeHolder = self.text;
    }else{
        field.text = self.text;
    }
    if(self.index == 1){
        field.placeHolder = @"Write a self introduction to let more people know about you";
    }else if(self.index == 2){
        field.placeHolder = @"Write down the idea of dating and let more people find you interesting.";
    }else if (self.index == 3){
        field.placeHolder = @"Write down the contact information let more people find you interesting.";
    }
    self.field = field;
    field.backgroundColor = HexString(@"#363636");
    
    UILabel *label = [ViewInstance defindLabelWithFrame:Setframe(view.width-105, 260, 100, 40) text:self.isPalceholder?@"0/200":[NSString stringWithFormat:@"%ld/200",self.text.length] textColor:HexString(@"#C6C6C6") textAlignment:NSTextAlignmentRight font:MyFont(Font_Regular, 15)];
    [view addSubview:label];
    self.limitLabel = label;
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger maxFontNum = 200;//最大输入限制
    NSInteger length = self.field.text.length;
    NSString *toBeString = textView.text;
    // 获取键盘输入模式
    NSString *lang = [[UIApplication sharedApplication] textInputMode].primaryLanguage;
    if ([lang isEqualToString:@"zh-Hans"]) { // zh-Hans代表简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textView markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > maxFontNum) {
                textView.text = [toBeString substringToIndex:maxFontNum];//超出限制则截取最大限制的文本
                self.limitLabel.text = [NSString stringWithFormat:@"%ld/200",maxFontNum];
            } else {
                self.limitLabel.text = [NSString stringWithFormat:@"%ld/200",toBeString.length];
            }
        }
    } else {// 中文输入法以外的直接统计
        if (toBeString.length > maxFontNum) {
            textView.text = [toBeString substringToIndex:maxFontNum];
            self.limitLabel.text = [NSString stringWithFormat:@"%ld/200",maxFontNum];
        } else {
            self.limitLabel.text = [NSString stringWithFormat:@"%ld/200",toBeString.length];
        }
    }
}

- (void)saveAction{
//    if(self.field.text.length == 0){
//        [SVProgressHUD showInfoWithStatus:@"Please Input Text!!"];
//        return;
//    }
    if([self.field.text isEqual:self.text]){
        [self.navigationController popViewControllerAnimated:YES];
        return;;
    }
    NSDictionary *param;
    if(self.index == 1){
        param = @{@"spareNum1st":@"2",
                  @"tempStr2nd":self.field.text
        };
    }else if(self.index == 2){
        param = @{@"spareNum3rd":@"2",
                  @"tempStr8th":self.field.text
        };
    }else if(self.index == 3){
        param = @{@"introduce":self.field.text
        };
    }
    NSString *baseUrl    = [NSString stringWithFormat:@"%@%@",NSC_Base_Url,@"api/account/user/update"];
    [SVProgressHUD show];
    [[NeighborsSimpleCuteNetworkTool sharedNetworkTool]POST:baseUrl parameters:param success:^(NeighborsSimpleCuteResposeModel * _Nonnull response) {
        [SVProgressHUD dismiss];
        if(response.code == 0){
            NeighborsSimpleCuteUserModel *model = [NeighborsSimpleCuteUserModel getUserInfo];
            if(self.index == 1){
                model.userInfo.tempStr2nd = self.field.text;
                model.userInfo.spareNum1st = 2;
            }else if(self.index == 2){
                model.userInfo.tempStr8th = self.field.text;
                model.userInfo.spareNum3rd = 2;
            }else if(self.index == 3){
                model.userInfo.introduce = self.field.text;
            }
            [NeighborsSimpleCuteUserModel save:model];
            
            if(self.saveBlock){
                self.saveBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:@"Failed"];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"Failed"];
    }];
}

@end

@interface EditPhotoShowController ()
<UICollectionViewDelegate,UICollectionViewDataSource>{
    NSString *_pre;
}

@property (nonatomic,strong) UICollectionView *collectionView;
@end

@implementation EditPhotoShowController
- (void)viewDidLoad {
    [super viewDidLoad];
    _pre = [NeighborsSimpleCuteUserModel getUserInfo].appClient.spare17th;
    if(self.titleStr != nil){
        self.title = self.titleStr;
    }else{
        self.title = [NSString stringWithFormat:@"%ld/%ld",self.index,_photos.count];
    }
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(IPHONE_WIDTH, IPHONE_HEIGHT-NavigationHeight);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT-NavigationHeight) collectionViewLayout:layout];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.collectionView registerClass:[EditPhotoShowCell class] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.pagingEnabled = YES;
    if(self.titleStr == nil){
        self.collectionView.backgroundColor = [UIColor blackColor];
    }else{
        self.collectionView.backgroundColor = HexString(@"#F5F5F5");
    }
    [self.view addSubview:self.collectionView];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.index-1 inSection:0] atScrollPosition:(UICollectionViewScrollPositionLeft) animated:NO];
    
    
    UIButton *but = [ViewInstance defindButOnlyTileWithFrame:Setframe(0, 0, 40, NavigationHeight-StatusBarHeight) title:@"More" titleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:TUIKitResource(@"udate-top-bg")]] titleFont:MyFont(Font_Regular, 15)];
    [but addTarget:self action:@selector(deleteAction) forControlEvents:1<<6];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:but];
    
    [self.collectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
}

- (UIImage*) imageWithColor:(UIColor*)color
{
    CGSize imageSize = CGSizeMake(1, 1);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

#pragma mark Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photos.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    EditPhotoShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.valueObj = [[NSString alloc] initWithFormat:@"%@/%@",_pre,self.photos[indexPath.row]];
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self setTitle];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self setTitle];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self setTitle];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if([keyPath isEqualToString:@"contentOffset"]){
        [self setTitle];
    }
}

- (void)setTitle{
    NSArray *paths = [self.collectionView indexPathsForVisibleItems];
    if (paths.count == 1) {
        self.title = [NSString stringWithFormat:@"%ld/%ld",[paths[0] row] + 1,_photos.count];
    }
}

- (void)deleteAction{
    WeakSelf2(self);
    [DeleteView showWithBlock:^{
        StrongSelf(self);
        NSArray *paths = [self.collectionView indexPathsForVisibleItems];
        if (paths.count == 1) {
            NSInteger indexRow = [paths[0] row];
            [self.photos removeObjectAtIndex:indexRow];
            [self.collectionView reloadData];
            self.title = [NSString stringWithFormat:@"%ld/%ld",indexRow == self->_photos.count?indexRow:indexRow +1,self->_photos.count];
            if (self.photoDeleteBlock) {
                self.photoDeleteBlock([paths[0] row]);
            }
            if (self->_photos.count == 0) {
                [self dismissAction];
            }
        }
    }];
}

- (void)dismissAction{
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc{
    [self.collectionView removeObserver:self forKeyPath:@"contentOffset"];
}
@end

@interface DeleteView ()
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,copy) void (^confirmBlock) (void);
@end

@implementation DeleteView

+ (void)showWithBlock:(void (^) (void))block{
    DeleteView *view = [[DeleteView alloc] initWithFrame:Setframe(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT)];
    [KWindow addSubview:view];
    view.confirmBlock = block;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
        
        UIView *bottomView = [[UIView alloc] initWithFrame:Setframe(0, self.height, self.width, 83+50 + (Is_IPhoneX?34:0))];
        [self addSubview:bottomView];
        self.bottomView = bottomView;

        NSArray *arr = @[@"Delete",@"Cancle"];
        for(int i=0;i<arr.count;i++){
            UIButton *but = [ViewInstance defindButOnlyTileWithFrame:i==0?Setframe(13.5, 0, self.width-27, 50):Setframe(13.5, 50+25, self.width-27, 50) title:arr[i] titleColor:i==0?[UIColor whiteColor]:[UIColor colorWithPatternImage:[UIImage imageNamed:TUIKitResource(@"udate-top-bg")]] titleFont:MyFont(Font_Regular, 15)];
            [bottomView addSubview:but];
            [but addTarget:self action:i==0?@selector(confirm):@selector(cancle) forControlEvents:1<<6];
            ViewBorderRadius(but, 10, 0, [UIColor clearColor]);
            but.backgroundColor = HexString(@"#282828");
        }
        
[UIView animateWithDuration:0.25 animations:^{
    self.bottomView.mj_y = self.height-self.bottomView.height;
}];

    }
    return self;
}

- (void)cancle{
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomView.mj_y = self.height;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)confirm{
    if(self.confirmBlock){
        self.confirmBlock();
    }
    [self cancle];
}

@end

@interface MyDefindButton ()

@end

@implementation MyDefindButton

- (instancetype)init{
    if (self = [super init]) {
        _insertPadding = 2;//默认间距为2
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGRect titleF = self.titleLabel.frame;
    CGRect imageF = self.imageView.frame;
    if (titleF.size.height == 0) {
        CGFloat height = self.height-imageF.size.height-_insertPadding;
        titleF = Setframe(titleF.origin.x, titleF.origin.y, titleF.size.width, height);
    }
    
    switch (self.myDefindType) {
        case UIMyDefindButtonImageTypeNormal:{
            
            imageF.origin.x = self.width/2-((titleF.size.width + imageF.size.width+_insertPadding)/2);
            
            self.imageView.frame = imageF;
            
            titleF.origin.x = CGRectGetMaxX(imageF) + _insertPadding;
            self.titleLabel.frame = titleF;
            
        }
            
            break;
            
        case UIMyDefindButtonImageTypeTop:{
            
            CGRect newImageRect;
            
            newImageRect.origin.x = self.width/2-(imageF.size.width/2);
            
            newImageRect.origin.y = self.height/2 - ((imageF.size.height+_insertPadding+titleF.size.height)/2);
            
            newImageRect.size.width = imageF.size.width;
            
            newImageRect.size.height = imageF.size.height;
            
            self.imageView.frame = newImageRect;
            
            self.titleLabel.frame = CGRectMake(0, self.imageView.bottom+_insertPadding, self.width, titleF.size.height);
            
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            
        }
            break;
        case UIMyDefindButtonImageTypeRight:{
            
            titleF.origin.x = self.width/2-((titleF.size.width + imageF.size.width+_insertPadding)/2);
            
            self.titleLabel.frame = titleF;
            
            imageF.origin.x = CGRectGetMaxX(titleF) + _insertPadding;
            self.imageView.frame = imageF;
            
        }
            break;
            
        case UIMyDefindButtonImageTypeBottom:{
            
            CGRect newTitleRect;
            
            newTitleRect.origin.x = self.width/2-(titleF.size.width/2);
            
            newTitleRect.origin.y = self.height/2 - ((imageF.size.height+_insertPadding+titleF.size.height)/2);
            
            newTitleRect.size.width = titleF.size.width;
            
            newTitleRect.size.height = titleF.size.height;
            
            self.titleLabel.frame = CGRectMake(0, newTitleRect.origin.y, self.width, newTitleRect.size.height);
            
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            self.imageView.frame = CGRectMake(self.width/2-(imageF.size.width/2), self.titleLabel.bottom+_insertPadding, imageF.size.width, imageF.size.height);
            
        }
            break;
            
        case UIMyDefindButtonImageTypeRightRight:{
            imageF.origin.x = self.width-imageF.size.width;
            self.imageView.frame = imageF;
            
            titleF.origin.x = self.width-(titleF.size.width+imageF.size.width+_insertPadding);
            self.titleLabel.frame = titleF;
        }
            break;
        case UIMyDefindButtonImageTypeRightLeft:{
            titleF.origin.x = 0;
            self.titleLabel.frame = titleF;
            
            imageF.origin.x = titleF.size.width + _insertPadding;
            self.imageView.frame = imageF;
        }
            break;
        case UIMyDefindButtonImageTypeRightCenter:{
            titleF.origin.x = self.width/2-(titleF.size.width/2);
            self.titleLabel.frame = titleF;
            
            imageF.origin.x = CGRectGetMaxX(titleF) + _insertPadding;
            self.imageView.frame = imageF;
        }
            break;
        case UIMyDefindButtonImageTypeNormalLeft:{
            imageF.origin.x = 0;
            self.imageView.frame = imageF;
            
            titleF.origin.x = imageF.size.width + _insertPadding;
            self.titleLabel.frame = titleF;
        }
            break;
        case UIMyDefindButtonImageTypeNormalRight:{
            titleF.origin.x = self.width-titleF.size.width;
            self.titleLabel.frame = titleF;
            
            imageF.origin.x = self.width-(titleF.size.width+imageF.size.width+_insertPadding);
            self.imageView.frame = imageF;
        }
            break;
        default:
            break;
    }
    
}

@end

@interface UITextField (ToolKit)

@end

@implementation UITextField (ToolKit)

@dynamic leftPadding;
@dynamic rightPadding;

- (void)setLeftPadding:(CGFloat)leftPadding{
    
    self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftPadding, 0)];
    
    self.leftViewMode = UITextFieldViewModeAlways;
    
}

- (void)setRightPadding:(CGFloat)rightPadding{
    
    self.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rightPadding, 0)];
    
    self.rightViewMode = UITextFieldViewModeAlways;
    
}

- (void)setTextFieldPlaceHolder:(NSString *)placeholder holderColor:(UIColor *)color{
    
    self.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName:color}];
    
}

@end

@interface NeighborsSimpleCuteSettingBaseProfileController()
<TZImagePickerControllerDelegate>

@property (nonatomic,strong) UITextField *nameField;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSString *age;
@property (nonatomic,strong) NSString *location;

@property (nonatomic,strong) UILabel *maskView;
@property (nonatomic,strong) UIButton *editBut;

@property (nonatomic,strong) UIImageView *userImageView;
@property (nonatomic,strong) MyDefindButton *sexBut;
@property (nonatomic,strong) MyDefindButton *ageBut;
@property (nonatomic,strong) MyDefindButton *locationBut;
@property (nonatomic,copy)NSString *qiniuToken;
@property (nonatomic,copy)NSString *pictureUrl;
@end
@implementation NeighborsSimpleCuteSettingBaseProfileController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = NSC_BGThemColor;
    self.navigationItem.title = @"Base Profile";
    [self NeighborsSimpleCuteSetLeftButton:[UIImage imageNamed:TUIKitResource(@"n_back")]];
    [self setupSettingUI];
}
- (void)onNeighborsSimpleCuteLeftBackBtn:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)setupSettingUI{
    //NSC_BGThemColor2
    UIImageView *headImgView = [ViewInstance defindImageViewWithFrame:Setframe((Screen_Width-118)/2, 50, 118, 118) image:[UIImage imageNamed:TUIKitResource(@"hmhmine_defualthmh")]];
    [self.view addSubview:headImgView];
    //NSC_BGThemColor2
    headImgView.contentMode = UIViewContentModeScaleAspectFill;
    ViewBorderRadius(headImgView, 118/2, 4, HexString(@"#282828"));
    self.userImageView = headImgView;
    {
        self.maskView = [ViewInstance defindLabelWithFrame:Setframe(0, 0, 118, 118) text:@"Pending" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter font:MyFont(Font_Regular, 15)];
        [headImgView addSubview:self.maskView];
        self.maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
//        self.maskView.hidden = YES;
        
        self.editBut = [ViewInstance defindButOnlyImageWithFrame:Setframe(headImgView.right-50, headImgView.bottom-50, 50, 50) image:[UIImage imageNamed:TUIKitResource(@"hmhwookabianjitwoo")]];
        [self.view addSubview:self.editBut];
        [self.editBut addTarget:self action:@selector(updateHeadClick) forControlEvents:1<<6];
    }
    
    CGFloat topHeight = headImgView.bottom+50;
    NSArray *titles = @[@"Username",@"Gender",@"Age",@"Location"];
    for (int i = 0; i < titles.count; i++) {
        UIView *view = [ViewInstance defindViewWithFrame:Setframe(15, topHeight+75*i, IPHONE_WIDTH-30, 60) backgroundColor:HexString(@"#363636")];
        ViewBorderRadius(view, 5, 0, WhiteColor);
        [self.view addSubview:view];
        UILabel *left = [ViewInstance defindLabelWithFrame:Setframe(15, 0, 100, 60) text:titles[i] textColor:WhiteColor textAlignment:NSTextAlignmentLeft font:MyFont(Font_Regular, 16)];
        [view addSubview:left];
        if(i == 0){
            MyDefindButton *btn = [[MyDefindButton alloc] initWithFrame:Setframe(left.right+10, 0, view.width-left.right-22, 60)];
            [btn setTitle:@"Add" forState:0];
            [btn setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:TUIKitResource(@"udate-top-bg")]] forState:0];
            [btn setImage:[UIImage imageNamed:TUIKitResource(@"")] forState:0];
            btn.titleLabel.font = MyFont(Font_Regular, 15);
            btn.insertPadding = 8;
            btn.myDefindType = UIMyDefindButtonImageTypeRightRight;
            btn.tag = i;
            [view addSubview:btn];
            [btn setTitle:[NeighborsSimpleCuteUserModel getUserInfo].userInfo.nickName forState:UIControlStateNormal];
            
        }else {
            MyDefindButton *btn = [[MyDefindButton alloc] initWithFrame:Setframe(left.right+10, 0, view.width-left.right-22, 60)];
            [btn setTitle:@"Add" forState:0];
            [btn setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:TUIKitResource(@"udate-top-bg")]] forState:0];
            [btn setImage:[UIImage imageNamed:TUIKitResource(@"hmhwookafanhui")] forState:0];
            btn.titleLabel.font = MyFont(Font_Regular, 15);
            btn.insertPadding = 8;
            btn.myDefindType = UIMyDefindButtonImageTypeRightRight;
            btn.tag = i;
            [btn addTarget:self action:@selector(selectItemAction:) forControlEvents:1<<6];
            [view addSubview:btn];
            
    
            if(i == 1){
//                self.sex = self.model.sex;
//                [btn setTitle:self.model.sex forState:0];
                self.sexBut = btn;
            }else if(i == 2){
//                self.age = self.model.age;
//                [btn setTitle:self.model.age forState:0];
                self.ageBut = btn;
            }else if(i == 3){
//                self.location = self.model.location;]
//                [btn setTitle:self.model.location forState:0];
                self.locationBut = btn;
            }
        }
    }
    
    //审核状态
    if([NeighborsSimpleCuteUserModel getUserInfo].userInfo.imgStatus == 2){
        //审核中
        self.maskView.hidden = NO;
        self.maskView.text = @"Pending";
        self.maskView.textColor = [UIColor whiteColor];
    }else if([NeighborsSimpleCuteUserModel getUserInfo].userInfo.imgStatus == 3){
        //拒绝
        self.maskView.hidden = NO;
        self.maskView.text = @"Refuse";
        self.maskView.textColor = [UIColor redColor];
    }else{
        self.maskView.hidden = YES;
    }
    //图片
    NSString *pre = [NeighborsSimpleCuteUserModel getUserInfo].appClient.spare17th;
    if (![GlobalModel isNum:[NeighborsSimpleCuteUserModel getUserInfo].userInfo.tempStr7th]) {
        [headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",pre,[NeighborsSimpleCuteUserModel getUserInfo].userInfo.tempStr7th]] placeholderImage:[UIImage imageNamed:TUIKitResource(@"hmhmine_defualthmh")]];
    }else if (![GlobalModel isNum:[NeighborsSimpleCuteUserModel getUserInfo].userInfo.imgUrl]) {
        [headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",pre,[NeighborsSimpleCuteUserModel getUserInfo].userInfo.imgUrl]] placeholderImage:[UIImage imageNamed:TUIKitResource(@"hmhmine_defualthmh")]];
    }
    //name
//    self.nameField.text = [NeighborsSimpleCuteUserModel getUserInfo].userInfo.nickName;
//    self.nameField.userInteractionEnabled = NO;
    
    //性别
    NSInteger gender = [NeighborsSimpleCuteUserModel getUserInfo].userInfo.gender;
    if(gender == 1){
        [self.sexBut setTitle:@"Male" forState:UIControlStateNormal];
    }else if(gender == 2){
        [self.sexBut setTitle:@"Female" forState:UIControlStateNormal];
    }else{
        [self.sexBut setTitle:@"" forState:UIControlStateNormal];
    }
    //年龄
    NSInteger age = [NeighborsSimpleCuteUserModel getUserInfo].userInfo.age;
    if(age < 18){
        [self.ageBut setTitle:@"18" forState:UIControlStateNormal];
    }else{
        [self.ageBut setTitle:[NSString stringWithFormat:@"%ld",age] forState:UIControlStateNormal];
    }
    //地址
    NSString *locationStr = @"";
    if(![GlobalModel isNum:[NeighborsSimpleCuteUserModel getUserInfo].userInfo.city]){
        locationStr = [NeighborsSimpleCuteUserModel getUserInfo].userInfo.city;
    }else if(![GlobalModel isNum:[NeighborsSimpleCuteUserModel getUserInfo].userInfo.province]){
        locationStr = [NeighborsSimpleCuteUserModel getUserInfo].userInfo.province;
    }else if(![GlobalModel isNum:[NeighborsSimpleCuteUserModel getUserInfo].userInfo.country]){
        locationStr = [NeighborsSimpleCuteUserModel getUserInfo].userInfo.country;
    }
    [self.locationBut setTitle:locationStr forState:UIControlStateNormal];
    
}

//切换头像
- (void)updateHeadClick{
    [self actionUplodateImage];
}
//选择
- (void)selectItemAction:(UIButton *)sender {
    if(sender.tag == 1){
        //性别
        [EditMyPickerView showWithData:@[@"Male",@"Female"] flag:1 tipText:@"Gender" block:^(NSArray * _Nonnull arr) {
            NSString *str = [arr firstObject];
            NSDictionary *parame;
            NeighborsSimpleCuteUserModel *model = [NeighborsSimpleCuteUserModel getUserInfo];
            if([str isEqualToString:@"Male"]){
                parame = @{@"gender":@"1",@"spareNum2nd":@"0",@"imgStatus":@"2"};
                model.userInfo.gender = 1;
            }else if ([str isEqualToString:@"Female"]){
                parame = @{@"gender":@"2",@"spareNum2nd":@"0",@"imgStatus":@"2"};
                model.userInfo.gender = 2;
            }
            [NeighborsSimpleCuteUserModel save:model];
            [self.sexBut setTitle:str forState:0];
            [self requestInterface:parame];
        }];
    }else if(sender.tag == 2){
        //年龄
        NSMutableArray *arr = [NSMutableArray array];
        for(int i=18;i<100;i++){
            [arr addObject:[NSString stringWithFormat:@"%d",i]];
        }
        [EditMyPickerView showWithData:[NSArray arrayWithArray:arr] flag:1 tipText:@"Age" block:^(NSArray * _Nonnull arr) {
            NSString *str = [arr firstObject];
            [self.ageBut setTitle:str forState:UIControlStateNormal];
            [self requestInterface:@{@"age":str}];
            NeighborsSimpleCuteUserModel *model = [NeighborsSimpleCuteUserModel getUserInfo];
            model.userInfo.age = [str integerValue];
            [NeighborsSimpleCuteUserModel save:model];
        }];
    }else if(sender.tag == 3){
        //位置
        NeighborsSimpleCuteLocationShowView *locationShowView = [[NeighborsSimpleCuteLocationShowView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT)];
        [locationShowView setNeighborsSimpleCuteLocationShowViewSelectBlock:^(NeighborsSimpleCuteResetCountryModel * _Nonnull countryModel, NeighborsSimpleCuteResetCountryModel * _Nonnull statemodel, NeighborsSimpleCuteResetCountryModel * _Nonnull cityModel) {
            NeighborsSimpleCuteUserModel *model = [NeighborsSimpleCuteUserModel getUserInfo];
            model.userInfo.city = cityModel.name;
            model.userInfo.province = statemodel.name;
            model.userInfo.country = countryModel.name;
            [NeighborsSimpleCuteUserModel save:model];
            NSString *locationStr = @"";
            if(![GlobalModel isNum:[NeighborsSimpleCuteUserModel getUserInfo].userInfo.city]){
                locationStr = [NeighborsSimpleCuteUserModel getUserInfo].userInfo.city;
            }else if(![GlobalModel isNum:[NeighborsSimpleCuteUserModel getUserInfo].userInfo.province]){
                locationStr = [NeighborsSimpleCuteUserModel getUserInfo].userInfo.province;
            }else if(![GlobalModel isNum:[NeighborsSimpleCuteUserModel getUserInfo].userInfo.country]){
                locationStr = [NeighborsSimpleCuteUserModel getUserInfo].userInfo.country;
            }
            [self.locationBut setTitle:locationStr forState:UIControlStateNormal];
                NSMutableDictionary *param = [NSMutableDictionary dictionary];
                param[@"country"]    = countryModel.name;
                param[@"countryId"]  = @(countryModel.id);
                param[@"tempStr6th"] = countryModel.code;
                param[@"province"]   = statemodel.name;
                param[@"provinceId"] = @(statemodel.id);
                param[@"tempStr5th"] = statemodel.code;
                param[@"city"]       = cityModel.name;
                param[@"cityId"]     = @(cityModel.id);
            [self requestInterface:param];
        }];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        NSCParameterAssert(window);
        [window addSubview:locationShowView];
    }
}
- (void)requestInterface:(NSDictionary *)param{
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    param[@"country"]    = self.countryModel.name;
//    param[@"countryId"]  = @(self.countryModel.id);
//    param[@"tempStr6th"] = self.countryModel.code;
//    param[@"province"]   = self.stateModel.name;
//    param[@"provinceId"] = @(self.stateModel.id);
//    param[@"tempStr5th"] = self.stateModel.code;
//    param[@"city"]       = self.cityModel.name;
//    param[@"cityId"]     = @(self.cityModel.id);
//    param[@"gender"]     = self.genderStr;
//    param[@"age"]        = self.age_tf.text;
    NSString *baseUrl    = [NSString stringWithFormat:@"%@%@",NSC_Base_Url,@"api/account/user/update"];
    NSLog(@"baseUrl:%@",baseUrl);
    NSLog(@"param:%@",param);
    [SVProgressHUD show];
    [[NeighborsSimpleCuteNetworkTool sharedNetworkTool]POST:baseUrl parameters:param success:^(NeighborsSimpleCuteResposeModel * _Nonnull response) {
        NSLog(@"update:%@",response.data);
        [SVProgressHUD dismiss];
        if (response.code == 0) {
            [SVProgressHUD showInfoWithStatus:response.msg];
        }else{
            [SVProgressHUD showInfoWithStatus:response.msg];
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showInfoWithStatus:error.localizedDescription];
        return;
    }];
}

/// uploadimage
/// @param gesture uplodate image
-(void)actionUplodateImage
{
    [self.view endEditing:YES];
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    [imagePickerVc setAllowPreview:NO];
    [imagePickerVc setNaviBgColor:[UIColor blackColor]];
    [imagePickerVc setAllowPickingVideo:NO];
    [imagePickerVc setIsSelectOriginalPhoto:NO];
    imagePickerVc.allowTakePicture = YES;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        self.userImageView.image = photos[0];
        [self uploadImageWithImage:photos[0]];
       // [self uploadImageToQNFilePath:[self getImagePath:photos[0]]];
        
    }];
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
- (void)saveImage:(UIImage *)image {
   NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
   NSString *filePath = [[paths objectAtIndex:0]stringByAppendingPathComponent:
                         [NSString stringWithFormat:@"n_add_sened_img.png"]];  // 保存文件的名称
   BOOL result =[UIImagePNGRepresentation(image)writeToFile:filePath   atomically:YES]; // 保存成功会返回YES
   if (result == YES) {
       NSLog(@"Save Success");
   }
}

//照片获取本地路径转换
- (NSString *)getImagePath:(UIImage *)Image {
    NSString *filePath = nil;
    NSData *data = nil;
    if (UIImagePNGRepresentation(Image) == nil) {
        data = UIImageJPEGRepresentation(Image, 1.0);
    } else {
        data = UIImagePNGRepresentation(Image);
    }
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
 
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
 
    //把刚刚图片转换的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *ImagePath = [[NSString alloc] initWithFormat:@"/theFirstImage.png"];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:ImagePath] contents:data attributes:nil];
 
    //得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc] initWithFormat:@"%@%@", DocumentsPath, ImagePath];
    NSLog(@"filePath:%@",filePath);
    return filePath;
}
/// 获取七牛token
/// 上传图片
/// @param filePath 上传图片
- (void)uploadImageWithImage:(UIImage *)image
{
       NSString *urlStr  = [NSString stringWithFormat:@"%@%@",NSC_Base_Url,@"api/qiniu/upload"];
       [SVProgressHUD showWithStatus:@"uploading..."];
       AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
       [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
       manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
       manager.requestSerializer = [AFJSONRequestSerializer serializer];
       AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
       response.removesKeysWithNullValues = YES;//去除空值
       manager.responseSerializer = response;//申明返回的结果是json
       //                                                               NeighborsSimpleCuteUserModel *usermodel = [NeighborsSimpleCuteUserModel getUserInfo];
       NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:NeighborsSimple_Token];
       NSLog(@"token:%@",token);
       [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
       NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
       formatter.dateFormat=@"yyyyMMddHHmmss";
       NSString *str=[formatter stringFromDate:[NSDate date]];
       NSString *fileName=[NSString stringWithFormat:@"%@%@.jpg",str,[self getRandWithLetters]];
       NSMutableDictionary *param = [NSMutableDictionary dictionary];
       param[@"fileName"] = fileName;
       NSLog(@"param:%@",param);
       [manager POST:urlStr parameters:param headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
           NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
           [formData appendPartWithFileData:imageData name:@"picFile" fileName:fileName mimeType:@"image/jpg"];
       } progress:^(NSProgress * _Nonnull uploadProgress) {
       } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           [SVProgressHUD dismiss];
           NSLog(@"responseObject:%@",responseObject);
           [self actionUpdateImageWithImageUrl:responseObject[@"data"]];
       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
           NSLog(@"error:%@",error);
           [SVProgressHUD dismiss];
           [SVProgressHUD showErrorWithStatus:@"Request failed"];
           return;
       }];
}
-(void)actionUpdateImageWithImageUrl:(NSString *)picurl
{
    NSLog(@"1111picurlpicurlpicurlpicurlpicurlpicurl:%@",picurl);
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"imgStatus"] = @"2";
    param[@"imgUrl"] = picurl;
    param[@"tempStr7th"] = picurl;
    NSString *baseUrl = [NSString stringWithFormat:@"%@%@",NSC_Base_Url,@"api/account/user/update"];
    NSLog(@"param:%@",param);
    NSLog(@"baseUrl:%@",baseUrl);
    [SVProgressHUD show];
    [[NeighborsSimpleCuteNetworkTool sharedNetworkTool]POST:baseUrl parameters:param success:^(NeighborsSimpleCuteResposeModel * _Nonnull response) {
        NSLog(@"update:%@",response.data);
        [SVProgressHUD dismiss];
        if (response.code == 0) {
            [SVProgressHUD showInfoWithStatus:@"Successfully modified"];
            NeighborsSimpleCuteUserModel *model = [NeighborsSimpleCuteUserModel getUserInfo];
            model.userInfo.imgUrl = picurl;
            model.userInfo.tempStr7th = picurl;
            //状态是审核中
            model.userInfo.imgStatus = 2;
            [NeighborsSimpleCuteUserModel save:model];
        }else{
            [SVProgressHUD showInfoWithStatus:response.msg];
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:error.localizedDescription];
        return;
    }];
}

@end

@interface NeighborsSimpleCuteSettingMineController ()
<UIScrollViewDelegate,TZImagePickerControllerDelegate>

@property (nonatomic,strong) MyDefindButton *photosBtn;
@property (nonatomic,strong) MyDefindButton *detailsBtn;
@property (nonatomic,strong) MyDefindButton *aboutBtn;
@property (nonatomic,strong) UILabel *photosCount;
@property (nonatomic,strong) UILabel *detailsCount;
@property (nonatomic,strong) UILabel *aboutCount;

@property (nonatomic,assign) NSInteger selectIndex;

@property (nonatomic,strong) UIScrollView *contentScroller;
@property (nonatomic,strong) EditPhotosView *mView;
@property (nonatomic,strong) EditDetailsView *mView2;
@property (nonatomic,strong) EditAboutView *mView3;

@property (nonatomic,strong) UIImageView *headImgView;
@property (nonatomic,strong) UILabel *maskView;
@property (nonatomic,strong) MyDefindButton *nameBut;
@property (nonatomic,strong) UILabel *infoLabel;

@property (nonatomic,strong) NSString *qiniuToken;
@end

@implementation NeighborsSimpleCuteSettingMineController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self settingData];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HexString(@"#1b1b1b");
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.offset(0);
        make.height.offset(NavigationHeight);
    }];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btn setImage:[UIImage imageNamed:TUIKitResource(@"n_back")] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0.0, 5, 0.0, 5.0);
    [btn addTarget:self action:@selector(onNeighborsSimpleCuteLeftBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.mas_equalTo(topView).offset(8);
        make.width.offset(80);
        make.height.offset(50);
    }];
    [self setupSettingUI];
    NSLog(@"%@",[NeighborsSimpleCuteUserModel getUserInfo].tokenDto.token);
}

- (void)onNeighborsSimpleCuteLeftBackBtn:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)setupSettingUI{
    UIImageView *headImgView = [ViewInstance defindImageViewWithFrame:Setframe((Screen_Width-118)/2, NavigationHeight, 118, 118) image:[UIImage imageNamed:TUIKitResource(@"hmhmine_defualthmh")]];
    headImgView.userInteractionEnabled = true;
    [headImgView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(updateInfoClick)]];
    [self.view addSubview:headImgView];
    self.headImgView = headImgView;
    ViewBorderRadius(headImgView, 118/2, 4, HexString(@"#282828"));
    headImgView.contentMode = UIViewContentModeScaleAspectFill;
    {
        self.maskView = [ViewInstance defindLabelWithFrame:Setframe(0, 0, 118, 118) text:@"Pending" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter font:MyFont(Font_Regular, 15)];
        [headImgView addSubview:self.maskView];
        self.maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        
        UIButton *editBut = [ViewInstance defindButOnlyImageWithFrame:Setframe(headImgView.right-50, headImgView.bottom-50, 50, 50) image:[UIImage imageNamed:TUIKitResource(@"hmhwookabianjitwoo")]];
        [self.view addSubview:editBut];
        [editBut addTarget:self action:@selector(updateInfoClick) forControlEvents:1<<6];
    }
    
    MyDefindButton *nameBtn = [[MyDefindButton alloc] initWithFrame:Setframe(50, headImgView.bottom, Screen_Width-100, 24)];
    [nameBtn setTitle:@"" forState:0];
    [nameBtn setTitleColor:WhiteColor forState:0];
    nameBtn.titleLabel.font = MyFont(Font_Bold, 18);
    [nameBtn setImage:[UIImage imageNamed:TUIKitResource(@"hmhwookahyico")] forState:0];
    nameBtn.insertPadding = 5;
    nameBtn.myDefindType = UIMyDefindButtonImageTypeRight;
    [self.view addSubview:nameBtn];
    self.nameBut = nameBtn;
    
    UILabel *infoLabel = [ViewInstance defindLabelWithFrame:Setframe(20, nameBtn.bottom+10, Screen_Width-40, 20) text:@"" textColor:WhiteColor textAlignment:NSTextAlignmentCenter font:MyFont(Font_Regular, 15)];
    [self.view addSubview:infoLabel];
    self.infoLabel = infoLabel;
    
    CGFloat btnWidth = Screen_Width/3;
    MyDefindButton *photosBtn = [[MyDefindButton alloc] initWithFrame:Setframe(0, infoLabel.bottom+30, btnWidth, 50)];
    [photosBtn setTitle:@"Photos" forState:0];
    [photosBtn setTitleColor:WhiteColor forState:0];
    [photosBtn setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:TUIKitResource(@"udate-top-bg")]] forState:1<<2];
    photosBtn.titleLabel.font = MyFont(Font_Regular, 12);
    [photosBtn setImage:[UIImage imageNamed:TUIKitResource(@"hmhwookahmhphoto")] forState:0];
    [photosBtn setImage:[UIImage imageNamed:TUIKitResource(@"hmhwookahmhpho")] forState:1<<2];
    photosBtn.insertPadding = 5;
    photosBtn.myDefindType = UIMyDefindButtonImageTypeTop;
    photosBtn.tag = 0;
    [photosBtn addTarget:self action:@selector(itemSelectAction:) forControlEvents:1<<6];
    [self.view addSubview:photosBtn];
    self.photosBtn = photosBtn;
    self.photosBtn.selected = YES;
    self.photosCount = [ViewInstance defindLabelWithFrame:Setframe(photosBtn.right-(btnWidth/2)+8, infoLabel.bottom+20, 20, 20) text:@"2" textColor:WhiteColor textAlignment:NSTextAlignmentCenter font:MyFont(Font_Regular, 12)];
    ViewBorderRadius(self.photosCount, 10, 0, WhiteColor);
    self.photosCount.backgroundColor = HexString(@"#FB1F1A");
    [self.view addSubview:self.photosCount];
    
    MyDefindButton *detailsBtn = [[MyDefindButton alloc] initWithFrame:Setframe(btnWidth, infoLabel.bottom+30, btnWidth, 50)];
    [detailsBtn setTitle:@"Details" forState:0];
    [detailsBtn setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:TUIKitResource(@"udate-top-bg")]] forState:1<<2];
    [detailsBtn setTitleColor:WhiteColor forState:0];
    detailsBtn.titleLabel.font = MyFont(Font_Regular, 12);
    [detailsBtn setImage:[UIImage imageNamed:TUIKitResource(@"hmhwookahmhdetails")] forState:0];
    [detailsBtn setImage:[UIImage imageNamed:TUIKitResource(@"hmhwookahmhmdetai")] forState:1<<2];
    detailsBtn.insertPadding = 5;
    detailsBtn.myDefindType = UIMyDefindButtonImageTypeTop;
    detailsBtn.tag = 1;
    [detailsBtn addTarget:self action:@selector(itemSelectAction:) forControlEvents:1<<6];
    [self.view addSubview:detailsBtn];
    self.detailsBtn = detailsBtn;
    self.detailsCount = [ViewInstance defindLabelWithFrame:Setframe(detailsBtn.right-(btnWidth/2)+8, infoLabel.bottom+20, 20, 20) text:@"0" textColor:WhiteColor textAlignment:NSTextAlignmentCenter font:MyFont(Font_Regular, 12)];
    ViewBorderRadius(self.detailsCount, 10, 0, WhiteColor);
    self.detailsCount.backgroundColor = HexString(@"#FB1F1A");
    [self.view addSubview:self.detailsCount];
    
    MyDefindButton *aboutBtn = [[MyDefindButton alloc] initWithFrame:Setframe(btnWidth*2, infoLabel.bottom+30, btnWidth, 50)];
    [aboutBtn setTitle:@"About" forState:0];
    [aboutBtn setTitleColor:WhiteColor forState:0];
    [aboutBtn setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:TUIKitResource(@"udate-top-bg")]] forState:1<<2];
    aboutBtn.titleLabel.font = MyFont(Font_Regular, 12);
    [aboutBtn setImage:[UIImage imageNamed:TUIKitResource(@"hmhwookahmhabout")] forState:0];
    [aboutBtn setImage:[UIImage imageNamed:TUIKitResource(@"hmhwookahmhshowab")] forState:1<<2];
    aboutBtn.insertPadding = 5;
    aboutBtn.myDefindType = UIMyDefindButtonImageTypeTop;
    aboutBtn.tag = 2;
    [aboutBtn addTarget:self action:@selector(itemSelectAction:) forControlEvents:1<<6];
    [self.view addSubview:aboutBtn];
    self.aboutBtn = aboutBtn;
    self.aboutCount = [ViewInstance defindLabelWithFrame:Setframe(aboutBtn.right-(btnWidth/2)+8, infoLabel.bottom+20, 20, 20) text:@"0" textColor:WhiteColor textAlignment:NSTextAlignmentCenter font:MyFont(Font_Regular, 12)];
    ViewBorderRadius(self.aboutCount, 10, 0, WhiteColor);
    self.aboutCount.backgroundColor = HexString(@"#FB1F1A");
    [self.view addSubview:self.aboutCount];
    
    self.contentScroller = [[UIScrollView alloc] initWithFrame:Setframe(0, photosBtn.bottom, IPHONE_WIDTH, IPHONE_HEIGHT-photosBtn.bottom)];
    [self.view addSubview:self.contentScroller];
    self.contentScroller.showsHorizontalScrollIndicator = NO;
    self.contentScroller.contentSize = CGSizeMake(IPHONE_WIDTH*3, 0);
    self.contentScroller.pagingEnabled = YES;
    self.contentScroller.scrollEnabled = NO;
    self.contentScroller.delegate = self;
    self.contentScroller.bounces = NO;
    
    for (int i = 0; i < 3; i++) {
        if(i == 0){
            EditPhotosView *view = [[EditPhotosView alloc] initWithFrame:Setframe(self.contentScroller.width*i, 0, self.contentScroller.width, self.contentScroller.height)];
            [self.contentScroller addSubview:view];
            self.mView = view;
            WeakSelf2(self);
            view.addPhotoClickedBlock = ^{
                StrongSelf(self);
                [self addPhotoAction];
            };
            view.previewPhotoClickedBlock = ^(NSInteger index, NSArray * _Nonnull list) {
                StrongSelf(self);
                EditPhotoShowController *vc = [EditPhotoShowController new];
                vc.index = index;
                vc.photos = [NSMutableArray arrayWithArray:list];
                [self.navigationController pushViewController:vc animated:YES];
                vc.photoDeleteBlock = ^(NSInteger index) {
                    [self deletePhoto:index];
                };
            };
            view.updateRedNumber = ^(NSInteger count) {
                StrongSelf(self);
                if(count == 0){
                    self.photosCount.hidden = YES;
                }else{
                    self.photosCount.hidden = NO;
                    self.photosCount.text = [NSString stringWithFormat:@"%ld",count];
                }
            };
        }else if(i == 1){
            EditDetailsView *view2 = [[EditDetailsView alloc] initWithFrame:Setframe(self.contentScroller.width*i, 0, self.contentScroller.width, self.contentScroller.height)];
            [self.contentScroller addSubview:view2];
            self.mView2 = view2;
            WeakSelf2(self);
            view2.itemSelectClickedBlock = ^(NSInteger index) {
                StrongSelf(self);
                [self itemSelectClickedAction:index];
            };
            view2.updateRedNumber = ^(NSInteger count) {
                StrongSelf(self);
                count = 14-count;
                if(count == 0){
                    self.detailsCount.hidden = YES;
                }else{
                    self.detailsCount.hidden = NO;
                    self.detailsCount.text = [NSString stringWithFormat:@"%ld",count];
                }
            };
            [view2 getRedNumber];
        }else if(i == 2){
            EditAboutView *view3 = [[EditAboutView alloc] initWithFrame:Setframe(self.contentScroller.width*i, 0, self.contentScroller.width, self.contentScroller.height)];
            [self.contentScroller addSubview:view3];
            self.mView3 = view3;
            WeakSelf2(self);
            view3.sectionClickedBlock = ^(NSInteger index,NSString *text,BOOL isPlace) {
                StrongSelf(self);
                [self sectionClickAction:index text:text isPlace:isPlace];
            };
            view3.updateRedNumber = ^(NSInteger count) {
                StrongSelf(self);
                count = 3-count;
                if(count == 0){
                    self.aboutCount.hidden = YES;
                }else{
                    self.aboutCount.hidden = NO;
                    self.aboutCount.text = [NSString stringWithFormat:@"%ld",count];
                }
            };
            [view3 getRedNumber];
        }
    }
    
    //跳转到指定状态
    self.selectIndex = 0;
    [self.contentScroller setContentOffset:CGPointMake(0, 0) animated:YES];
}

//切换选中item
- (void)itemSelectAction:(UIButton *)sender {
    if(self.selectIndex == sender.tag){
        return;
    }
    sender.selected = YES;
    self.selectIndex = sender.tag;
    if(sender.tag == 0){
        self.detailsBtn.selected = NO;
        self.aboutBtn.selected = NO;
    }else if(sender.tag == 1){
        self.photosBtn.selected = NO;
        self.aboutBtn.selected = NO;
    }else if(sender.tag == 2){
        self.photosBtn.selected = NO;
        self.detailsBtn.selected = NO;
    }
    [self.contentScroller setContentOffset:CGPointMake(IPHONE_WIDTH*self.selectIndex, 0) animated:YES];
}

//修改资料
- (void)updateInfoClick{
    NeighborsSimpleCuteSettingBaseProfileController *profilevc = [[NeighborsSimpleCuteSettingBaseProfileController alloc]init];
    profilevc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:profilevc animated:NO];
}

//添加照片
- (void)addPhotoAction {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    [imagePickerVc setAllowPreview:NO];
    [imagePickerVc setNaviBgColor:[UIColor blackColor]];
    [imagePickerVc setAllowPickingVideo:NO];
    [imagePickerVc setIsSelectOriginalPhoto:NO];
    imagePickerVc.allowTakePicture = YES;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
//        self.first_img.image = photos[0];
//        //[self.first_btn setBackgroundImage:photos[0] forState:UIControlStateNormal];
//        [self.first_btn setTitle:@"" forState:UIControlStateNormal];
//        self.isFirst = YES;
        //先上传，在获取网络路径，再刷新
        [self saveImage:photos[0]];
        [self uploadImageToQNFilePath:[self getImagePath:photos[0]] image:photos[0]];
    }];
    imagePickerVc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

//Details select
- (void)itemSelectClickedAction:(NSInteger)index {
    
}

//about edit
- (void)sectionClickAction:(NSInteger)index text:(NSString *)text isPlace:(BOOL)isPlace{
    EditInputController *vc  =[EditInputController new];
    vc.index = index+1;
    vc.text = text;
    vc.isPalceholder = isPlace;
    [self.navigationController pushViewController:vc animated:YES];
    WeakSelf2(self);
    vc.saveBlock = ^{
        StrongSelf(self);
        [self.mView3 getRedNumber];
        [self.mView3 refreshData];
    };
    
}

- (void)settingData{
    //审核状态
    if([NeighborsSimpleCuteUserModel getUserInfo].userInfo.imgStatus == 2){
        //审核中
        self.maskView.hidden = NO;
        self.maskView.text = @"Pending";
        self.maskView.textColor = [UIColor whiteColor];
    }else if([NeighborsSimpleCuteUserModel getUserInfo].userInfo.imgStatus == 3){
        //拒绝
        self.maskView.hidden = NO;
        self.maskView.text = @"Refuse";
        self.maskView.textColor = [UIColor redColor];
    }else{
        self.maskView.hidden = YES;
    }
    //图片
    NSString *pre = [NeighborsSimpleCuteUserModel getUserInfo].appClient.spare17th;
    if (![GlobalModel isNum:[NeighborsSimpleCuteUserModel getUserInfo].userInfo.tempStr7th]) {
        [self.headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",pre,[NeighborsSimpleCuteUserModel getUserInfo].userInfo.tempStr7th]] placeholderImage:[UIImage imageNamed:TUIKitResource(@"hmhmine_defualthmh")]];
    }else if (![GlobalModel isNum:[NeighborsSimpleCuteUserModel getUserInfo].userInfo.imgUrl]) {
        [self.headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",pre,[NeighborsSimpleCuteUserModel getUserInfo].userInfo.imgUrl]] placeholderImage:[UIImage imageNamed:TUIKitResource(@"hmhmine_defualthmh")]];
    }
    
    //姓名
    [self.nameBut setTitle:[NeighborsSimpleCuteUserModel getUserInfo].userInfo.nickName forState:UIControlStateNormal];
    if([NeighborsSimpleCuteUserModel getUserInfo].userInfo.memberLevel == 0){
        [self.nameBut setImage:nil forState:UIControlStateNormal];
    }else{
        [self.nameBut setImage:[UIImage imageNamed:TUIKitResource(@"hmhwookahyico")] forState:0];
    }
    //地址信息
    NSString *desc = @"";
    desc = [NSString stringWithFormat:@"%ld, ",[NeighborsSimpleCuteUserModel getUserInfo].userInfo.age];
    desc = [NSString stringWithFormat:@"%@%@",desc,[NeighborsSimpleCuteUserModel getUserInfo].userInfo.gender==1?@"Male, ":[NeighborsSimpleCuteUserModel getUserInfo].userInfo.gender==2?@"Female, ":@""];
    if(![GlobalModel isNum:[NeighborsSimpleCuteUserModel getUserInfo].userInfo.city]){
        desc = [NSString stringWithFormat:@"%@%@",desc,[NeighborsSimpleCuteUserModel getUserInfo].userInfo.city];
    }else if(![GlobalModel isNum:[NeighborsSimpleCuteUserModel getUserInfo].userInfo.province]){
        desc = [NSString stringWithFormat:@"%@%@",desc,[NeighborsSimpleCuteUserModel getUserInfo].userInfo.province];
    }else if(![GlobalModel isNum:[NeighborsSimpleCuteUserModel getUserInfo].userInfo.country]){
        desc = [NSString stringWithFormat:@"%@%@",desc,[NeighborsSimpleCuteUserModel getUserInfo].userInfo.country];
    }
    self.infoLabel.text = desc;
}

- (void)saveImage:(UIImage *)image {
   NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
   NSString *filePath = [[paths objectAtIndex:0]stringByAppendingPathComponent:
                         [NSString stringWithFormat:@"n_add_sened_img.png"]];  // 保存文件的名称
   BOOL result =[UIImagePNGRepresentation(image)writeToFile:filePath   atomically:YES]; // 保存成功会返回YES
   if (result == YES) {
       NSLog(@"Save Success");
   }
}

//照片获取本地路径转换
- (NSString *)getImagePath:(UIImage *)Image {
    NSString *filePath = nil;
    NSData *data = nil;
    if (UIImagePNGRepresentation(Image) == nil) {
        data = UIImageJPEGRepresentation(Image, 1.0);
    } else {
        data = UIImagePNGRepresentation(Image);
    }
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
 
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
 
    //把刚刚图片转换的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *ImagePath = [[NSString alloc] initWithFormat:@"/theFirstImage.png"];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:ImagePath] contents:data attributes:nil];
 
    //得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc] initWithFormat:@"%@%@", DocumentsPath, ImagePath];
    NSLog(@"filePath:%@",filePath);
    return filePath;
}

#pragma mark Network
/// 上传图片
/// @param filePath 上传图片
- (void)uploadImageToQNFilePath:(NSString *)filePath image:(UIImage *)image
{
    NSString *urlStr  = [NSString stringWithFormat:@"%@%@",NSC_Base_Url,@"api/qiniu/upload"];
        [SVProgressHUD showWithStatus:@"uploading..."];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html", nil];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
        response.removesKeysWithNullValues = YES;//去除空值
        manager.responseSerializer = response;//申明返回的结果是json
        //                                                               NeighborsSimpleCuteUserModel *usermodel = [NeighborsSimpleCuteUserModel getUserInfo];
        NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:NeighborsSimple_Token];
        NSLog(@"token:%@",token);
        [manager.requestSerializer setValue:token forHTTPHeaderField:@"token"];
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        formatter.dateFormat=@"yyyyMMddHHmmss";
        NSString *str=[formatter stringFromDate:[NSDate date]];
        NSString *fileName=[NSString stringWithFormat:@"%@%@.jpg",str,[self getRandWithLetters]];
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        param[@"fileName"] = fileName;
        NSLog(@"param:%@",param);
        [manager POST:urlStr parameters:param headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            [formData appendPartWithFileData:imageData name:@"picFile" fileName:fileName mimeType:@"image/jpg"];
        } progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [SVProgressHUD dismiss];
            NSLog(@"responseObject:%@",responseObject);
            [self actionUpdateImage:responseObject[@"data"]];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"error:%@",error);
            [SVProgressHUD dismiss];
            [SVProgressHUD showErrorWithStatus:@"Request failed"];
            return;
        }];

}
-(void)actionUpdateImage:(NSString *)imgString
{
    //获取最大编号
    NSInteger maxCode = 0;
    for(int i=0;i<self.mView.photoList.count;i++){
        NSInteger code = [self.mView.photoList[i][@"imgCode"] integerValue];
        if(code >maxCode){
            maxCode = code;
        }
    }
    maxCode = maxCode+1;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"imgCode"] = @(maxCode);
    param[@"imgUrl"] = imgString;
    param[@"isCover"] = @"1";
    NSString *baseUrl = [NSString stringWithFormat:@"%@%@",NSC_Base_Url,@"api/photo/upload"];
    [SVProgressHUD show];
    [[NeighborsSimpleCuteNetworkTool sharedNetworkTool]POST:baseUrl parameters:param success:^(NeighborsSimpleCuteResposeModel * _Nonnull response) {
        NSLog(@"update:%@",response.data);
        [SVProgressHUD dismiss];
        if (response.code == 0) {
            [SVProgressHUD showInfoWithStatus:@"Success"];
            NSDictionary *dic = @{@"imgCode":@(maxCode),@"imgUrl":imgString,@"reviewStatus":@(2)};
            [self.mView.photoList addObject:dic];
            [self.mView.collectionView reloadData];
            [self.mView update];
        }else{
            [SVProgressHUD showInfoWithStatus:response.msg];
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:error.localizedDescription];
        return;
    }];
}

- (void)deletePhoto:(NSInteger)index{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.mView.photoList[index][@"imgUrl"] forKey:@"imgUrl"];
    NSString *baseUrl = [NSString stringWithFormat:@"%@%@",NSC_Base_Url,@"api/photo/delete"];
    [SVProgressHUD show];
    [[NeighborsSimpleCuteNetworkTool sharedNetworkTool] POST:baseUrl parameters:param success:^(NeighborsSimpleCuteResposeModel * _Nonnull response) {
        NSLog(@"update:%@",response.data);
        [SVProgressHUD dismiss];
        if (response.code == 0) {
            
            [self.mView.photoList removeObjectAtIndex:index];
            [self.mView.collectionView reloadData];
            [self.mView update];
            
        }else{
            [SVProgressHUD showInfoWithStatus:response.msg];
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:error.localizedDescription];
        return;
    }];
}
@end
