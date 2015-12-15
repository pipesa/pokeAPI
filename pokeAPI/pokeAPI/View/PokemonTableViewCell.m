//
//  PokemonTableViewCell.m
//  pokeAPI
//
//  Created by Felipe on 12/14/15.
//  Copyright © 2015 FelipeSalinas. All rights reserved.
//

#import "PokemonTableViewCell.h"

@implementation PokemonTableViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UINib *nibFile = [UINib nibWithNibName:@"PokemonTableViewCell" bundle:nil];
        self = [[nibFile instantiateWithOwner:self options:nil] firstObject];
    }
    return self;
}

-(id)init{
    
    self = [super init];
    if (self) {
        // Initialization code
        UINib *nibFile = [UINib nibWithNibName:@"PokemonTableViewCell" bundle:nil];
        self = [[nibFile instantiateWithOwner:self options:nil] firstObject];
    }
    return self;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)tappedFavoriteAction:(UIButton *)pokemon{
    if ([self.delegate respondsToSelector:@selector(addFavorite:)]) {
        [self.delegate addFavorite:self.pokemonID];
    }
}

@end
