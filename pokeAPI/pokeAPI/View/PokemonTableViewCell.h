//
//  PokemonTableViewCell.h
//  pokeAPI
//
//  Created by Felipe on 12/14/15.
//  Copyright © 2015 FelipeSalinas. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PokemonTableViewCellDelegate <NSObject>

-(void)addFavorite:(NSString *)productID;

@end

@interface PokemonTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *pokemonLabel;
@property (strong, nonatomic) IBOutlet UIButton *favoriteButton;

@property (nonatomic) NSString *pokemonID;

@property (nonatomic, assign) id<PokemonTableViewCellDelegate> delegate;

@end
