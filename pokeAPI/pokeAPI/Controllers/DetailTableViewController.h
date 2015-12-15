//
//  DetailTableViewController.h
//  pokeAPI
//
//  Created by Felipe on 12/14/15.
//  Copyright © 2015 FelipeSalinas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface DetailTableViewController : UITableViewController<MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) Pokemon *pokemonDetail;

@end
