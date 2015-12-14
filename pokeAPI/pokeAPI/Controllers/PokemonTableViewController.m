//
//  PokemonTableViewController.m
//  pokeAPI
//
//  Created by Felipe on 12/13/15.
//  Copyright © 2015 FelipeSalinas. All rights reserved.
//

#import "PokemonTableViewController.h"

@interface PokemonTableViewController ()

@end

@implementation PokemonTableViewController

 NSString *pathURL = @"/api/v1/pokemon/?limit=30";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadPokemon:pathURL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadPokemon:(NSString *)newPathURL {
    [[PokeAPIHTTPClient sharedInstance] loadPokemonList:newPathURL withComplition:^(BOOL success, id response, NSError *error) {
        if (success) {
            pathURL = response[@"newURL"];
            NSLog(@"NEW URL: %@",pathURL);
            
        }else {
            NSLog(@"Response: %@",error);
        }
    }];
}

- (void)saveObjects:(NSArray *)newObject {
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

@end
