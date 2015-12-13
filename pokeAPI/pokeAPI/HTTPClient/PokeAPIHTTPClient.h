//
//  PokeAPIHTTPClient.h
//  pokeAPI
//
//  Created by Felipe on 12/13/15.
//  Copyright © 2015 FelipeSalinas. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface PokeAPIHTTPClient : AFHTTPSessionManager

+ (PokeAPIHTTPClient *)sharedInstance;
- (instancetype)initWithBaseURL:(NSURL *)url;

- (void) loadPokemonList:(NSDictionary *)params
     withComplition:(void(^)(BOOL success,id response, NSError *error))complition;

@end
