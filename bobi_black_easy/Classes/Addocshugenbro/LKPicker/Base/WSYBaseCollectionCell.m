//
//  WSYBaseCollectionCell.m
//  WSYPickerProject
//
//  Created by zjlk32 on 2021/10/18.
//

#import "WSYBaseCollectionCell.h"

@implementation WSYBaseCollectionCell
+(id)creatTheCollectView:(UICollectionView *)collectView AndTheIndexPath:(NSIndexPath *)indexpath {
    NSString  *idenfier = NSStringFromClass([self classForCoder]);
    [collectView registerClass:[self classForCoder] forCellWithReuseIdentifier:idenfier];
    WSYBaseCollectionCell  *cell = [collectView dequeueReusableCellWithReuseIdentifier:idenfier forIndexPath:indexpath];
    cell.indexpath = indexpath;
    return cell;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self setContentUI];
    }
    return  self;
}
-(void)setContentUI{
    
}
@end
