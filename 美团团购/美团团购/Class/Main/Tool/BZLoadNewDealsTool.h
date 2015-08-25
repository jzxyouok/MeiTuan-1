//
//  BZLoadNewDealsTool.h
//  美团团购
//
//  Created by 尚承教育 on 15/7/21.
//  Copyright (c) 2015年 魔力包. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BZLoadNewDealsParamsModel.h"
#import "BZLoadNewDealsResultModel.h"

@interface BZLoadNewDealsTool : NSObject



- (void)loadNewDealsWithParms:(BZLoadNewDealsParamsModel *)params success:(void(^)(BZLoadNewDealsResultModel *result))success failure:(void(^)(NSError *error))failure;

@end
