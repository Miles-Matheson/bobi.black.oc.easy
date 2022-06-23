//
//  WsyShoseProx.h
//  Woko
//
//  Created by 王树银 on 2022/4/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface wsyShoseModel : NSObject

@property(nonatomic,assign)BOOL       canEdit;
@property(nonatomic,strong)NSString    * imgUrl;
@property(nonatomic,copy)NSData       * imgData;
@property(nonatomic,strong)UIImage     * imgName;

@end

@protocol wsyShoseProtocol <NSObject>

@optional

-(void)openThePicRouterWithIndexPath:(NSIndexPath*)indexPath withBlock:(void (^)(void))block;
@end

@interface WsyShoseProx : NSObject

@property(nonatomic,assign)NSInteger  maxNum;

@property(nonatomic,strong)UIImage  *placeImg;

@property(nonatomic,assign)CGSize   picSize;

@property(nonatomic,weak)id<wsyShoseProtocol>delegate;

@property(nonatomic,strong)NSMutableArray   *dataArray;

//选择图片
-(void)shosePicWithIndexPath:(NSIndexPath *)indexPath withBlock:(void(^)(void))block;

//点击选择图片

-(void)dealWithThePicWithIndexPath:(NSIndexPath *)indexPath AndTheImage:(UIImage *)image;


//删除图片
-(void)deleteThePicWithIndexPath:(NSIndexPath *)indexPath withBlock:(void (^)(void))block;


@end

NS_ASSUME_NONNULL_END
