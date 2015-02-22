//
//  SearchQuestionsViewController.m
//  BurgerMenuWithEverythingOnIt
//
//  Created by cm2y on 2/18/15.
//  Copyright (c) 2015 cm2y. All rights reserved.
//

#import "SearchQuestionsViewController.h"
#import "NetworkControllerToStackOverflow.h"
#import "Question.h"
#import "QuestionCell.h"

@interface SearchQuestionsViewController () <UISearchBarDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong,nonatomic) NSArray *questions;

@end

@implementation SearchQuestionsViewController

- (void)viewDidLoad {
    NSLog(@" SearchQuestionsViewController > viewDidLoad fired");
    
    
    [super viewDidLoad];
    self.searchBar.delegate = self;
    self.searchBar.text = @"Not finished homework yet!";
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // Do any additional setup after loading the view.

}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@" SearchQuestionsViewController > searchBarSearchButtonClicked fired");
    
    NSLog(@"The text entered is @%@",searchBar.text);
    
    [self.searchBar resignFirstResponder];
    
    [[NetworkControllerToStackOverflow sharedService] fetchQuestionsWithSearchTerm:searchBar.text completionHandler:^(NSArray *results, NSString *error) {
        
        self.questions = results;
        if (error) {
            //show alert view
        }
        [self.tableView reloadData];
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@" SearchQuestionsViewController > tableView: numberOfRowsInSection fired");
    return self.questions.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@" SearchQuestionsViewController > tableView: cellForRowAtIndexPath fired");
    
    QuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QUESTION_CELL"
                                                         forIndexPath:indexPath];
    cell.avatarImageView.image = nil;
    Question *question = self.questions[indexPath.row];
    cell.titleTextView.text = question.title;
    if (!question.image) {
        [[NetworkControllerToStackOverflow sharedService] fetchUserImage:question.avatarURL completionHandler:^(UIImage *image) {
            question.image = image;
            cell.avatarImageView.image = image;
        }];
    } else {
        cell.avatarImageView.image = question.image;
    }
    return cell;
}

@end
