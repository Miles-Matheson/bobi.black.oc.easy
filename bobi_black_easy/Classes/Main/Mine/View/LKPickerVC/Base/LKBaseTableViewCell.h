//
//  LKBaseTableViewCell.h
//  cltios
//
//  Created by zjlk32 on 2021/4/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LKBaseTableViewCell : UITableViewCell
@property(nonatomic,strong)NSIndexPath *indexpath;
+(id)createCellWithTheTableView:(UITableView *)tableView AndTheIndexPath:(NSIndexPath *)indexPath;
-(void)setContentUI;
@end

NS_ASSUME_NONNULL_END
