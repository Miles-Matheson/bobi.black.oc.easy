//
//  WsyShoseProx.m
//  Woko
//
//  Created by 王树银 on 2022/4/24.
//

#import "WsyShoseProx.h"
#import "BobiEasyHeader.h"

@implementation wsyShoseModel

@end

@implementation WsyShoseProx

-(instancetype)init{
    if (self == [super init]) {
        _placeImg = [UIImage mm_xcassetImageNamed:@"wsy_camer"];
        wsyShoseModel  *model = [[wsyShoseModel alloc]init];
        model.canEdit = false;
        model.imgName = _placeImg;
        _dataArray  = [NSMutableArray arrayWithArray:@[model]];
    }
    return self;
}

-(void)setPlaceImg:(UIImage *)placeImg{
    _placeImg = placeImg;
}
////选择图片
-(void)shosePicWithIndexPath:(NSIndexPath *)indexPath withBlock:(void (^)(void))block{
    if (_delegate && [_delegate respondsToSelector:@selector(openThePicRouterWithIndexPath:withBlock:)]) {
        [_delegate openThePicRouterWithIndexPath:indexPath withBlock:block];
    }
}

-(void)dealWithThePicWithIndexPath:(NSIndexPath *)indexPath AndTheImage:(UIImage *)image{
    wsyShoseModel  *model = [self.dataArray objcetSafeGetIndex:indexPath.row];
    NSInteger  index = indexPath.row;
    if (model.canEdit == false) {
        if (index == self.maxNum - 1) {
            model.canEdit = true;
            model.imgName = image;
        }else{
            wsyShoseModel  *addMoel = [[wsyShoseModel alloc]init];
            addMoel.canEdit = true;
            addMoel.imgName = image;
            [self.dataArray insertObject:addMoel atIndex:index];
        }
    }else{
            model.imgName = image;
            [self.dataArray replaceObjectAtIndex:index withObject:model];
    }
}

//删除某一个图片
-(void)deleteThePicWithIndexPath:(NSIndexPath *)indexPath withBlock:(void (^)(void))block{
    if (self.dataArray.count == self.maxNum) {
        wsyShoseModel  *model = [[wsyShoseModel alloc]init];
        model.canEdit = false;
        model.imgName = self.placeImg;
        wsyShoseModel  *lastModel = [self.dataArray lastObject];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        if (lastModel.canEdit == true) {
            [self.dataArray addObject:model];
        }
        if (block) {
            block();
        }
    }else{
        [self.dataArray removeObjectAtIndex:indexPath.row];
        if (block) {
            block();
        }
    }
}

@end
