//
//  FavoritesTableViewController.m
//  pokeAPI
//
//  Created by Felipe on 12/13/15.
//  Copyright © 2015 FelipeSalinas. All rights reserved.
//

#import "FavoritesTableViewController.h"

@interface FavoritesTableViewController ()

@property (strong, nonatomic) RLMResults *favoritesArray;

@end

@implementation FavoritesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self registerTableViewCell];
}

-(void)viewWillAppear:(BOOL)animated {
    [self loadFavorites];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadFavorites {
    
    [self startSpinner];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"isFavorite = %@",@"1"];
    RLMResults * favoritesPokemon = [Pokemon objectsWithPredicate:pred];
    
    if ([favoritesPokemon count] > 0) {
        [self setFavoritesArray:favoritesPokemon];
        self.tableView.backgroundView = [[UIView alloc] init];
        [[self tableView] reloadData];
    }else {
        UILabel *messageLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,
                                                                        self.tableView.bounds.size.width,
                                                                        self.tableView.bounds.size.height)];
        messageLbl.text = @"You do not have favorite Pokemons!";
        messageLbl.textAlignment = NSTextAlignmentCenter;
        [messageLbl sizeToFit];
        
        self.tableView.backgroundView = messageLbl;
        
        [[self tableView] reloadData];
    }
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([[self favoritesArray] count] > 0) {
        return [[self favoritesArray] count];
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PokemonTableViewCell *pokemonCell = [self.tableView dequeueReusableCellWithIdentifier:@"PokemonTableViewCell"];
    
    Pokemon *currentPokemon = [[self favoritesArray] objectAtIndex:indexPath.row];
    
    pokemonCell.delegate = self;
    [pokemonCell.pokemonLabel setText:currentPokemon.name];
    pokemonCell.pokemonID = currentPokemon.objID;
    
    [pokemonCell.favoriteButton setHidden:YES];
    
    return pokemonCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Pokemon *currentPokemon = [[self favoritesArray] objectAtIndex:indexPath.row];
    
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
    
}

@end
