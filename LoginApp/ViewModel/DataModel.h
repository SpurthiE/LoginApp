//
//  DataModel.h
//  LoginApp
//
//  Created by spurthi.eshwarappa on 16/03/22.
//
#import <UIKit/UIKit.h>

@interface DataModel: NSObject
- (void)fetchdata: (void (^)(NSMutableArray *, NSError *))completionBlock;
@end

