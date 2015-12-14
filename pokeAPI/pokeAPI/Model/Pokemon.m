//
//  Pokemon.m
//  pokeAPI
//
//  Created by Felipe on 12/13/15.
//  Copyright © 2015 FelipeSalinas. All rights reserved.
//

#import "Pokemon.h"

@implementation Pokemon

- (void)save
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:self];
    [realm commitWriteTransaction];
}

- (void)remove
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteObject:self];
    [realm commitWriteTransaction];
}

- (void)removeAllObjects
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
}


// Specify default values for properties
+ (NSDictionary *)defaultPropertyValues
{
    return @{@"objID":@"",
             @"name":@"",
             @"nationalID":@"",
             @"created":@"",
             @"modified":@"",
             @"abilities":@"",
             @"evolutions":@"",
             @"descriptions":@"",
             @"moves":@"",
             @"types":@"",
             @"catchRate":@"",
             @"hp":@"",
             @"attack":@"",
             @"defense":@"",
             @"speed":@"",
             @"height":@"",
             @"weight":@"",
             @"maleFemale":@""};
}

// Specify properties to ignore (Realm won't persist these)
+ (NSArray *)ignoredProperties
{
    return @[];
}

+ (NSString *)primaryKey {
    return @"objID";
}

@end
