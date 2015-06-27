//
//  MovieCell.m
//  RottenFruit
//
//  Created by Jhih-Yan Lin on 6/19/15.
//  Copyright (c) 2015 Jhih-Yan Lin. All rights reserved.
//

#import "MovieCell.h"

@implementation MovieCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) prepareForReuse {
    [super prepareForReuse];
    self.postView.image = nil;
}

@end
