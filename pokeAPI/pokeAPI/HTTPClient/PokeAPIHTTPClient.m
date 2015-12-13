//
//  PokeAPIHTTPClient.m
//  pokeAPI
//
//  Created by Felipe on 12/13/15.
//  Copyright © 2015 FelipeSalinas. All rights reserved.
//

#import "PokeAPIHTTPClient.h"

static NSString * const pokeAPIURLString = @"http://pokeapi.co/api/v1/";

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

- (void)loadPokemonList:(NSDictionary *)params withComplition:(void (^)(BOOL, id, NSError *))complition {
    
    [self GET:@"pokemon" parameters:@{@"limit":@"5"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (complition) {
            NSLog(@"%@",responseObject);
            complition(YES,responseObject,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (complition) {
            NSLog(@"%@",error);
            complition(NO,nil,error);
        }
    }];
}

@end
