//
//  LKPickerBackView.m
//  cltios
//
//  Created by zjlk32 on 2021/8/4.
//

#import "LKPickerBackView.h"
#import "LKPickerTableViewCell.h"
#import "NSArray+SafeIndex.h"

@interface LKPickerBackView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy)NSString  *selctTitle;

@property(nonatomic,strong)UILabel  *headtitLab;

@property(nonatomic,assign)NSInteger  index;

@end

@implementation LKPickerBackView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self initTheSubViews];
    }
    return self;
}

-(instancetype)init{
    if (self == [super init]) {
        self.backgroundColor = [UIColor clearColor];
        [self initTheSubViews];
    }
    return self;
}

-(void)initTheSubViews{
    _selctTitle = @"";
    _index = 0;
    [self addSubview:self.headV];
    [self addSubview:self.tableV];
}

-(void)setStyle:(LKWSYPickerStyleType)style{
    _style = style;
//    switch (_style) {
//        case LKWSYPickerStyle_sheet:
//        {
//            self.headV.hidden = false;
//        }
//            break;
//        case LKWSYPickerStyle_center:
//        {
////            self.headV.hidden = true;
////            UIView  *contentV = [_delegate lkwsyPickerViewCustomBackContentView];
////            contentV.center = self.center;
//        }
//            break;
//        default:
//            break;
//    }
}


-(void)setType:(LKWSYPickerType)type{
    _type = type;
    switch (_type) {
        case LKWSYPickerType_custom:
        {
            self.tableV.hidden = true;
            self.pickerV.hidden = true;
            
            if (_delegate && [_delegate respondsToSelector:@selector(lkwsyPickerViewCustomBackContentView)]) {
                UIView  *contentV = [_delegate lkwsyPickerViewCustomBackContentView];
                float sizeWith = contentV.frame.size.width;
                float sizeHeight = contentV.frame.size.height;
                [self addSubview:contentV];
                switch (_style) {
                    case LKWSYPickerStyle_center:
                    {
                        self.headV.hidden =true;
                        contentV.center = self.center;
                        contentV.bounds = CGRectMake(0, 0, sizeWith, sizeHeight);
                    }
                        break;
                    case LKWSYPickerStyle_sheet:
                    {
                        self.headV.hidden = false;

                    }
                        break;
                    default:
                        break;
                }
         }
        }
            break;
        case LKWSYPickerType_picker:
            {
                self.tableV.hidden = true;
                self.pickerV.hidden = true;
            }
            break;
        case LKWSYPickerType_tableV:
            {
              _tableV.hidden = false;
              _pickerV.hidden = true;
            }
            break;
        default:
            break;
    }
}


-(void)setDataSource:(id<LKWSYPickerDataSource>)dataSource{
    _dataSource = dataSource;
}
-(void)setDelegate:(id<LKWSYPickerDelegate>)delegate{
    _delegate = delegate;
    if (_delegate && [_delegate lkwsyPickerType]) {
        [self setType:[_delegate lkwsyPickerType]];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(lkwsyPickerStyleType)]) {
        [self setStyle:[_delegate lkwsyPickerStyleType]];
    }
}

-(void)beSureBtnAction{
    if (_block) {
        _block(_selctTitle ,_index);
    }
}

-(void)setDataArray:(NSMutableArray<NSString *> *)dataArray{
    _dataArray = dataArray;
    [_tableV reloadData];
}

-(UIView *)headV{
    if (!_headV) {
        _headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
        UIButton  *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [cancelBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        cancelBtn.frame = CGRectMake(self.frame.size.width - 40, 20,15,15);
        [_headV addSubview:cancelBtn];
        [cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
        UILabel  *headtitLab = [[UILabel alloc]initWithFrame:CGRectMake(40, 20, self.frame.size.width - 80, 20)];
        headtitLab.textColor = [UIColor blackColor];
        headtitLab.font = [UIFont boldSystemFontOfSize:15];
        [_headV addSubview:headtitLab];
    }
    return _headV;;
}

-(void)cancelBtnAction{
    
    
}

-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, self.frame.size.width, self.frame.size.height - 40) style:UITableViewStylePlain];
        _tableV.backgroundColor = [UIColor whiteColor];
        _tableV.delegate = self;
        _tableV.dataSource = self;
    }
    return _tableV;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LKPickerTableViewCell  *cell = [LKPickerTableViewCell createCellWithTheTableView:tableView AndTheIndexPath:indexPath];
//    cell.acountModel = [_dataArray objcetSafeGetIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        _index = indexPath.row;
        _selctTitle = [_dataArray objcetSafeGetIndex:indexPath.row];
    if (_block) {
        _block(_selctTitle ,_index);
    }
}

-(void)lkpickerViewWithData:(NSArray *)dataArr AndTheSelectedWithBlock:(void (^)(NSString * _Nonnull, NSInteger))block{
    [self setDataArray:[NSMutableArray arrayWithArray:dataArr]];
    _selctTitle = [_dataArray firstObject];
    _index = 0;
    [_tableV reloadData];
    self.block = block;
}


@end
