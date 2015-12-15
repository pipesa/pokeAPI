//
//  PokemonTableViewController.m
//  pokeAPI
//
//  Created by Felipe on 12/13/15.
//  Copyright © 2015 FelipeSalinas. All rights reserved.
//

#import "PokemonTableViewController.h"

@interface PokemonTableViewController ()

@property (strong, nonatomic) NSString *pathURL;
@property (strong, nonatomic) RLMResults *pokemonArray;

@end

@implementation PokemonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerTableViewCell];
    
    [self loadPokemon:[self pathURL]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadPokemon:(NSString *)newPathURL {
    
    [self startSpinner];
    
    RLMResults * oldObjects = [Pokemon allObjects];
    
    if ([oldObjects count] > 0) {
        [self setPathURL:[NSString stringWithFormat:@"/api/v1/pokemon/?limit=30&offset=%lu",(unsigned long)[oldObjects count]]];
        [self setPokemonArray:oldObjects];
        self.tableView.tableFooterView = [[UIView alloc] init];
        [[self tableView] reloadData];
    }else {
        [self setPathURL:@"/api/v1/pokemon/?limit=30"];
        [self loadObjectsFromAPI:[self pathURL]];
    }
}

- (void)loadObjectsFromAPI:(NSString *)newPathURL {
    [[PokeAPIHTTPClient sharedInstance] loadPokemonList:newPathURL withComplition:^(BOOL success, id response, NSError *error) {
        if (success) {
            [self setPathURL:response[@"newURL"]];
            [self setPokemonArray:response[@"objects"]];
            self.tableView.tableFooterView = [[UIView alloc] init];
            [[self tableView] reloadData];
        }else {
            NSLog(@"Error: %@",error);
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([[self pokemonArray] count] > 0) {
        return [[self pokemonArray] count];
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PokemonTableViewCell *pokemonCell = [self.tableView dequeueReusableCellWithIdentifier:@"PokemonTableViewCell"];
    
    Pokemon *currentPokemon = [[self pokemonArray] objectAtIndex:indexPath.row];
    
    pokemonCell.delegate = self;
    [pokemonCell.pokemonLabel setText:currentPokemon.name];
    pokemonCell.pokemonID = currentPokemon.objID;
    
    if ([[currentPokemon isFavorite] isEqualToString:@"1"]) {
        [pokemonCell.favoriteButton setImage:[UIImage imageNamed:@"Star-On"] forState:UIControlStateNormal];
    }else {
        [pokemonCell.favoriteButton setImage:[UIImage imageNamed:@"Star-Off"] forState:UIControlStateNormal];
    }
    
    return pokemonCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Pokemon *currentPokemon = [[self pokemonArray] objectAtIndex:indexPath.row];
    
    DetailTableViewController *detailTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailTableViewController"];
    
    detailTableViewController.pokemonDetail = currentPokemon;
    
    [self.navigationController pushViewController:detailTableViewController animated:YES];
}

#pragma mark - Spinner

- (void) startSpinner {
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    spinner.frame = CGRectMake(0, 0, 44, 44);
    self.tableView.tableFooterView = spinner;
}

#pragma mark - Register Cells

- (void)registerTableViewCell{
    [self.tableView registerNib:[UINib nibWithNibName:@"PokemonTableViewCell" bundle:nil] forCellReuseIdentifier:@"PokemonTableViewCell"];
}

#pragma mark - Pokemon Cell Delegate
-(void)addFavorite:(NSString *)productID {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"objID = %@",productID];
    Pokemon *currentPokemon = [[Pokemon objectsWithPredicate:pred] firstObject];
    
    if ([[currentPokemon isFavorite] isEqualToString:@"1"]) {
        currentPokemon.isFavorite = @"0";
    }else {
        currentPokemon.isFavorite = @"1";
    }
    
    [realm commitWriteTransaction];
    
    [[self tableView] reloadData];
}

@end
