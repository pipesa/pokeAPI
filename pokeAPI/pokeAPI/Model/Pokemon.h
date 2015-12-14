//
//  Pokemon.h
//  pokeAPI
//
//  Created by Felipe on 12/13/15.
//  Copyright © 2015 FelipeSalinas. All rights reserved.
//

#import <Realm/Realm.h>

@interface Pokemon : RLMObject

@property NSString * objID;
@property NSString * name;
@property NSString * nationalID;
@property NSString * created;
@property NSString * modified;
@property NSString * abilities;
@property NSString * evolutions;
@property NSString * descriptions;
@property NSString * moves;
@property NSString * types;
@property NSString * catchRate;
@property NSString * hp;
@property NSString * attack;
@property NSString * defense;
@property NSString * speed;
@property NSString * height;
@property NSString * weight;
@property NSString * maleFemale;

- (void)save;
- (void)remove;
- (void)removeAllObjects;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<Pokemon>
RLM_ARRAY_TYPE(Pokemon)
