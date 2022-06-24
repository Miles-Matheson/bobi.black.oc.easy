//
//  WSYBaseCollectionCell.h
//  WSYPickerProject
//
//  Created by zjlk32 on 2021/10/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WSYBaseCollectionCell : UICollectionViewCell

@property(nonatomic,strong)NSIndexPath  *indexpath;
+(id)creatTheCollectView:(UICollectionView *)collectView AndTheIndexPath:(NSIndexPath *)indexpath;
-(void)setContentUI;
@end

NS_ASSUME_NONNULL_END
