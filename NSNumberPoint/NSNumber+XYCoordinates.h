//
//  NSNumber+XYCoordinates.h
//  NSNumberPoint
//
//  Created by Martin Grider on 1/18/14.
//  Copyright (c) 2014 Abstract Puzzle.
//

#import <Foundation/Foundation.h>


#define NSNXY_UPPER_BOUNDS 32767


@interface NSNumber (XYCoordinates)


+ (NSNumber*)numberWithX:(int)x andY:(int)y;
- (int)xValue;
- (int)yValue;

// this is so you can write NSNumber *coord = [@4 xAndY:5]
- (NSNumber*)xAndY:(int)y;


@end
