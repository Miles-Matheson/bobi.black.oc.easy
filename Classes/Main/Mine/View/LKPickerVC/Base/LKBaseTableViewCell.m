//
//  LKBaseTableViewCell.m
//  cltios
//
//  Created by zjlk32 on 2021/4/1.
//

#import "LKBaseTableViewCell.h"

@implementation LKBaseTableViewCell

+(id)createCellWithTheTableView:(UITableView *)tableView AndTheIndexPath:(NSIndexPath *)indexPath {
    NSString  *identifier = NSStringFromClass([self classForCoder]);
    [tableView registerClass:[self classForCoder] forCellReuseIdentifier:identifier];
    LKBaseTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.indexpath = indexPath;
    return  cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.contentView.bounds].CGPath;
        [self setContentUI];
    }
    return  self;
}

-(void)setContentUI {
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
