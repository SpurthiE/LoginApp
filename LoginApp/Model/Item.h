//
//  Item.h
//  LoginApp
//
//  Created by spurthi.eshwarappa on 10/03/22.
//
@interface Item : NSObject
//properties
@property NSString *name;
@property NSString *topic;

//initializers
// Item *item = [[Item alloc] init];
// item.name =
// item.topic =
// Item *item = [[Item alloc] initWithName: @"" topic: @""];
-(instancetype)initWithName: (NSString *)name andWithTopic: (NSString *)topic;
//methods

+(NSArray *)fetchItems ;// [Item fetchItems]; // returns an array of items

@end
