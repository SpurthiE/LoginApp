//
//  DataModel.m
//  LoginApp
//
//  Created by spurthi.eshwarappa on 16/03/22.
//

#import <Foundation/Foundation.h>
#import "DataModel.h"

@implementation DataModel    
- (void)fetchdata: (void (^)(NSMutableArray *, NSError *))completionBlock {
    NSString *urlString = @"https://randomuser.me/api/?results=5";
    NSURL *url = [NSURL URLWithString:urlString];
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            completionBlock(nil, error);
        } else {
            NSError *error;
            NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            if (!jsonDict) {
                completionBlock(nil, error);
            } else {
                NSMutableArray *results = jsonDict[@"results"];
                NSLog(@"%@",results);
                completionBlock(results, nil);
            }
        }
    }]resume];
}

@end
