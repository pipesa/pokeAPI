//
//  Pokemon.h
//  pokeAPI
//
//  Created by Felipe on 12/13/15.
//  Copyright © 2015 FelipeSalinas. All rights reserved.
//

#import <Realm/Realm.h>

@interface Pokemon : RLMObject

@property NSString * email;
@property NSString * firstName;
@property NSString * lastName;
@property NSString * objID;
@property NSString * identifier;
@property NSString * password;
@property NSString * address;
@property NSDate * birthdate;
@property NSString * cellphone;
@property NSString * phone;
@property NSString * fbid;
@property NSString * gender;
@property NSString * paymentType;
@property NSString * token;

- (void)save;
- (void)remove;
- (void)removeAllObjects;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<Pokemon>
RLM_ARRAY_TYPE(Pokemon)
