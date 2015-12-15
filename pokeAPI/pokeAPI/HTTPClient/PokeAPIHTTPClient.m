//
//  PokeAPIHTTPClient.m
//  pokeAPI
//
//  Created by Felipe on 12/13/15.
//  Copyright © 2015 FelipeSalinas. All rights reserved.
//

#import "PokeAPIHTTPClient.h"

static NSString * const pokeAPIURLString = @"http://pokeapi.co";

@implementation PokeAPIHTTPClient

+ (PokeAPIHTTPClient *)sharedInstance
{
    static PokeAPIHTTPClient *_sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:pokeAPIURLString]];
    });
    
    return _sharedInstance;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    return self;
}

- (void)loadPokemonList:(NSString *)pathURL withComplition:(void (^)(BOOL, id, NSError *))complition {
    
    [self GET:pathURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (complition) {
            NSDictionary *newObjects = responseObject[@"objects"];
            NSMutableArray *pokemons = [NSMutableArray array];
            for (NSDictionary *newItem in newObjects) {
                if (newItem[@"pkdx_id"] != nil) {
                    NSPredicate *pred = [NSPredicate predicateWithFormat:@"objID = %@",
                                         [NSString stringWithFormat:@"%@",newItem[@"pkdx_id"]]];
                    RLMResults *oldPokemon = [Pokemon objectsWithPredicate:pred];
                    if ([oldPokemon count] == 0) {
                        [pokemons addObject:[self saveNewItems:newItem]];
                    }
                }
            }
            
            NSDictionary *newResponse = @{@"newURL":responseObject[@"meta"][@"next"] ? responseObject[@"meta"][@"next"]:@"",
                                          @"objects":pokemons};
            
            complition(YES,newResponse,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (complition) {
            NSLog(@"%@",error);
            complition(NO,nil,error);
        }
    }];
}

/**
 *  Save each pokemon object obtained from API
 *
 *  @param newPokemon Dictionary with pokemon information
 *
 *  @return Pokemon object
 */
- (Pokemon *)saveNewItems:(NSDictionary *)newPokemon {
    
    Pokemon *newItem = [[Pokemon alloc] init];
    
    newItem.objID = [NSString stringWithFormat:@"%@",newPokemon[@"pkdx_id"]];
    newItem.name = newPokemon[@"name"] ? newPokemon[@"name"]:@"";
    newItem.nationalID = [NSString stringWithFormat:@"%@",newPokemon[@"national_id"]];
    newItem.created = [NSString stringWithFormat:@"%@",newPokemon[@"created"]];
    newItem.modified = [NSString stringWithFormat:@"%@",newPokemon[@"modified"]];
    newItem.abilities = [NSString stringWithFormat:@"%@",newPokemon[@"abilities"]];
    newItem.evolutions = [NSString stringWithFormat:@"%@",newPokemon[@"evolutions"]];
    newItem.descriptions = [NSString stringWithFormat:@"%@",newPokemon[@"descriptions"]];
    newItem.moves = [NSString stringWithFormat:@"%@",newPokemon[@"moves"]];
    newItem.types = [NSString stringWithFormat:@"%@",newPokemon[@"types"]];
    newItem.catchRate = [NSString stringWithFormat:@"%@",newPokemon[@"national_id"]];
    newItem.hp = [NSString stringWithFormat:@"%@",newPokemon[@"hp"]];
    newItem.attack = [NSString stringWithFormat:@"%@",newPokemon[@"attack"]];
    newItem.defense = [NSString stringWithFormat:@"%@",newPokemon[@"defense"]];
    newItem.speed = [NSString stringWithFormat:@"%@",newPokemon[@"speed"]];
    newItem.height = [NSString stringWithFormat:@"%@",newPokemon[@"height"]];
    newItem.weight = [NSString stringWithFormat:@"%@",newPokemon[@"weight"]];
    newItem.maleFemale = [NSString stringWithFormat:@"%@",newPokemon[@"male_female_ratio"]];
    newItem.isFavorite = @"0";
    
    [newItem save];
    
    return newItem;
}

@end
