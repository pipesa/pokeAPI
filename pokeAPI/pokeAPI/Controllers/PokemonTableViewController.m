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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[PokeAPIHTTPClient sharedInstance] loadPokemonList:nil withComplition:^(BOOL success, id response, NSError *error) {
        if (success) {
            NSLog(@"Response: %lu",[response[@"objects"] count]);
        }else {
            NSLog(@"Response: %@",error);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
