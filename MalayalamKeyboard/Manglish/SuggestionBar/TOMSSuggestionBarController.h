//
//  TOMSSuggestionBarController.h
//  TOMSSuggestionBarExample
//
//  Created by Tom König on 15/06/14.
//  Copyright (c) 2014 TomKnig. All rights reserved.
//


@import UIKit;
@class TOMSSuggestionBarView;
@class TOMSSuggestionBar;

@interface TOMSSuggestionBarController : UICollectionViewController

- (instancetype)initWithSuggestionBarView:(TOMSSuggestionBarView *)suggestionBarView;

- (void)suggestableTextDidChange:(NSString *)context;

- (void)didSelectSuggestionAtIndexPath:(NSIndexPath *)indexPath;

@property (nonatomic, weak) TOMSSuggestionBar *suggestionBar;

@end
