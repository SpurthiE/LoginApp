//
//  Item.m
//  LoginApp
//
//  Created by spurthi.eshwarappa on 10/03/22.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@implementation Item

- (instancetype)initWithName:(NSString *)name andWithTopic:(NSString *)topic {
    if (self = [super init]) {
        // initialize all properties here....
        self.name = name;
        self.topic = topic;
    }
    return self;
}

+ (NSArray *)fetchItems {
    return @[
        [[Item alloc] initWithName:@"Coffee with Facebook Engineer" andWithTopic:@"Informational Interview"],
        [[Item alloc] initWithName:@"Phone interview with Snap" andWithTopic:@"2nd Interview"],
        [[Item alloc] initWithName:@"Review Hash Tables" andWithTopic:@"DSA"],
        [[Item alloc] initWithName:@"Push app to TestFlight" andWithTopic:@"iOS app development"]
    ];
}
@end
