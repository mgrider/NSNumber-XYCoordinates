//
//  NSNumber+XYCoordinates.m
//  NSNumberPoint
//
//  Created by Martin Grider on 1/18/14.
//  Copyright (c) 2014 Abstract Puzzle.
//

#import "NSNumber+XYCoordinates.h"


#define NSNXY_SHIFT_VALUE 16
#define NSNXY_OFFSET 65535

/*
 2^1 = 2
 2^2 = 4
 2^3 = 8
 2^4 = 16
 2^5 = 32
 2^6 = 64
 2^7 = 128
 2^8 = 256
 2^9 = 512
 2^10 = 1024
 2^11 = 2048
 2^12 = 4096
 2^13 = 8192
 2^14 = 16384
 2^15 = 32768
 2^16 = 65536
 2^17 = 131072
 */


@implementation NSNumber (XYCoordinates)


+ (NSNumber*)numberWithX:(int)x andY:(int)y
{
	// this doesn't work for negative numbers
	if (x <= -1 || y <= -1) {
		return @(-1);
	}
	// or number above 32767
	if (x > NSNXY_UPPER_BOUNDS || y > NSNXY_UPPER_BOUNDS) {
		return @(-1);
	}
	// finally the actual constructor
	int i = x;
	i += (y << NSNXY_SHIFT_VALUE);
	return @(i);
}

- (int)xValue
{
	if ([self intValue] <= -1) {
		return -1;
	}
	return [self intValue] & NSNXY_OFFSET;
}

- (int)yValue
{
	if ([self intValue] <= -1) {
		return -1;
	}
	return ([self intValue] >> NSNXY_SHIFT_VALUE);
}

- (NSNumber*)xAndY:(int)y
{
	return [NSNumber numberWithX:[self intValue] andY:y];
}


@end
