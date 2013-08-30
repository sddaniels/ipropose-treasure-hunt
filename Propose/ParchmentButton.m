//
//  ParchmentButton.m
//  Propose
//
//  Created by Shea Daniels on 12/13/11.
//  Copyright (c) 2011 Fubzy. All rights reserved.
//

#import "ParchmentButton.h"

@implementation ParchmentButton

- (void) init3dEffect {
    
    CALayer *layer = self.layer;
    
    layer.cornerRadius = 8.0f;
    layer.masksToBounds = NO;
    layer.borderWidth = 1.0f;
    layer.borderColor = [UIColor colorWithRed:0.4196f green:0.2392f blue:0.0784f alpha:0.4f].CGColor;    
}

- (void) initOutline {
    
    outline = [CALayer layer];
    
    [outline setFrame:CGRectMake(self.layer.bounds.origin.x, 
                                 self.layer.bounds.origin.y + 1, 
                                 self.layer.bounds.size.width, 
                                 self.layer.bounds.size.height)];
    outline.backgroundColor = [UIColor clearColor].CGColor;
    outline.cornerRadius = 8.0f;
    outline.borderWidth = 1.0f;
    outline.borderColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.6f].CGColor;
    
    [self.layer addSublayer:outline];
}

- (void) initHighlight {
    
    highlight = [CALayer layer];
    
    [highlight setFrame:CGRectMake(self.layer.bounds.origin.x, 
                                 self.layer.bounds.origin.y + 1, 
                                 self.layer.bounds.size.width, 
                                 self.layer.bounds.size.height)];
    highlight.backgroundColor = [UIColor colorWithRed:0.4196f green:0.2392f blue:0.0784f alpha:0.1f].CGColor;
    highlight.cornerRadius = 8.0f;
    highlight.hidden = YES;
    
    [self.layer addSublayer:highlight];    
}

- (void) initLayers {
    
    [self.titleLabel setFont:[UIFont fontWithName:@"UglyQua-Italic" size:17]];
    
    [self init3dEffect];
    [self initOutline];
    [self initHighlight];
}

- (void) awakeFromNib {
    
    [self initLayers];
}

- (id) initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        [self initLayers];
    }
    
    return self;
}

- (void) setHighlighted:(BOOL)highlighted {
    
    highlight.hidden = !highlighted;
    [super setHighlighted:highlighted];
}

@end
