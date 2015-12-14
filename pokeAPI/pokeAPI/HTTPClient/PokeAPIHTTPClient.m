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
            NSLog(@"%@",responseObject);
            NSDictionary *newObjects = responseObject[@"objects"];
            NSMutableArray *pokemons = [NSMutableArray array];
            for (NSDictionary *newItem in newObjects) {
                [pokemons addObject:[self saveNewItems:newItem]];
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

- (Pokemon *)saveNewItems:(NSDictionary *)newPokemon {
    Pokemon *newItem = [[Pokemon alloc] init];
    
    newItem.objID = newItem[@"pkdx_id"];
    newItem.name = newItem[@"name"];
    newItem.nationalID = newItem[@"national_id"];
    newItem.created = newItem[@"created"];
    newItem.modified = newItem[@"modified"];
    newItem.abilities = newItem[@"abilities"];
    newItem.evolutions = newItem[@"evolutions"];
    newItem.descriptions = newItem[@"descriptions"];
    newItem.moves = newItem[@"moves"];
    newItem.types = newItem[@"types"];
    newItem.catchRate = newItem[@"catchRate"];
    newItem.hp = newItem[@"hp"];
    newItem.attack = newItem[@"attack"];
    newItem.defense = newItem[@"defense"];
    newItem.speed = newItem[@"speed"];
    newItem.height = newItem[@"height"];
    newItem.weight = newItem[@"weight"];
    newItem.maleFemale = newItem[@"maleFemale"];
    
    [newItem save];
    
    return newItem;
}

@end
