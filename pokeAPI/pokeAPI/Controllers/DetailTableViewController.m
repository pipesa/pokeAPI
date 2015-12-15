//
//  DetailTableViewController.m
//  pokeAPI
//
//  Created by Felipe on 12/14/15.
//  Copyright © 2015 FelipeSalinas. All rights reserved.
//

#import "DetailTableViewController.h"

@interface DetailTableViewController ()

@end

@implementation DetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailCell" forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Name";
            cell.detailTextLabel.text = self.pokemonDetail.name;
            break;
        case 1:
            cell.textLabel.text = @"Catch rate";
            cell.detailTextLabel.text = self.pokemonDetail.catchRate;
            break;
        case 2:
            cell.textLabel.text = @"Attack";
            cell.detailTextLabel.text = self.pokemonDetail.attack;
            break;
        case 3:
            cell.textLabel.text = @"Defense";
            cell.detailTextLabel.text = self.pokemonDetail.defense;
            break;
        case 4:
            cell.textLabel.text = @"Speed";
            cell.detailTextLabel.text = self.pokemonDetail.speed;
            break;
        case 5:
            cell.textLabel.text = @"Height";
            cell.detailTextLabel.text = self.pokemonDetail.height;
            break;
        case 6:
            cell.textLabel.text = @"Weight";
            cell.detailTextLabel.text = self.pokemonDetail.weight;
            break;
        default:
            cell.textLabel.text = @"Gender";
            cell.detailTextLabel.text = self.pokemonDetail.maleFemale;
            break;
    }
    
    return cell;
}

#pragma mark - Share option

- (IBAction)shareDetail:(id)sender {
    NSString *emailTitle = self.pokemonDetail.name.capitalizedString;
    
    NSString *messageBody = [NSString stringWithFormat:@"Name: %@\r\n Catch rate: %@\r\n Attack: %@\r\n DefenseL %@\r\n Speed: %@\r\n Height: %@\r\n Weight: %@\r\n Gender: %@",self.pokemonDetail.name,self.pokemonDetail.catchRate,self.pokemonDetail.attack,self.pokemonDetail.defense,self.pokemonDetail.speed,self.pokemonDetail.height,self.pokemonDetail.weight,self.pokemonDetail.maleFemale];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    if ([MFMailComposeViewController canSendMail]) {
        mc.mailComposeDelegate = self;
        [mc setSubject:emailTitle];
        [mc setMessageBody:messageBody isHTML:NO];
        
        [self presentViewController:mc animated:YES completion:NULL];
    }
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
