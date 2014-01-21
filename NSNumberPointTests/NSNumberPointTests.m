//
//  NSNumberPointTests.m
//  NSNumberPointTests
//
//  Created by Martin Grider on 1/18/14.
//  Copyright (c) 2014 Abstract Puzzle. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSNumber+XYCoordinates.h"


#define ITTERATION_TESTS_X 10
#define ITTERATION_TESTS_Y 10


@interface NSNumberPointTests : XCTestCase

@end


@implementation NSNumberPointTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNSNumberPoints
{
	// basic assignment
	NSNumber *number = [NSNumber numberWithX:3 andY:2];
	XCTAssertTrue([number xValue] == 3, @"basic assignment failed.");
	XCTAssertTrue([number yValue] == 2, @"basic assignment failed.");

	// getting slightly higher numbers in reverse order
	number = [NSNumber numberWithX:598 andY:204];
	XCTAssertTrue([number yValue] == 204, @"basic assignment failed.");
	XCTAssertTrue([number xValue] == 598, @"basic assignment failed.");
}

- (void)testNumberOne
{
	// 1
	NSNumber *number = [NSNumber numberWithX:1 andY:1];
	XCTAssertTrue([number xValue] == 1, @"1 failed.");
	XCTAssertTrue([number yValue] == 1, @"1 failed.");
}

- (void)testNumberZero
{
	NSNumber *number = [NSNumber numberWithX:0 andY:0];
	XCTAssertTrue([number xValue] == 0, @"0 failed.");
	XCTAssertTrue([number yValue] == 0, @"0 failed.");

	number = [NSNumber numberWithX:3 andY:0];
	XCTAssertTrue([number xValue] == 3, @"0 failed.");
	XCTAssertTrue([number yValue] == 0, @"0 failed.");

	number = [NSNumber numberWithX:0 andY:3934];
	XCTAssertTrue([number xValue] == 0, @"0 failed.");
	XCTAssertTrue([number yValue] == 3934, @"0 failed.");
	XCTAssertTrue([number xValue] == 0, @"0 failed.");
	XCTAssertTrue([number yValue] == 3934, @"0 failed.");
}

- (void)testAlternativeConstructor
{
	NSNumber *coord = [@4 xAndY:5];
	XCTAssertTrue([coord xValue] == 4, @"alternative constructor failed.");
	XCTAssertTrue([coord yValue] == 5, @"alternative constructor failed.");
}

- (void)testNegativeNumbers
{
//	NSNumber *number = [NSNumber numberWithX:-10 andY:-540];
//	XCTAssertTrue([number xValue] == -1, @"negative error failed.");
//	XCTAssertTrue([number yValue] == -1, @"negative error failed.");
//	XCTAssertTrue([number intValue] == -1, @"negative error failed.");
	NSNumber *number = [NSNumber numberWithX:10 andY:-540];
	XCTAssertTrue([number xValue] == 10, @"negative error failed.");
	XCTAssertTrue([number yValue] == -540, @"negative error failed.");
	number = [NSNumber numberWithX:-10 andY:-540];
	XCTAssertTrue([number xValue] == -10, @"negative error failed.");
	XCTAssertTrue([number yValue] == -540, @"negative error failed.");
	number = [NSNumber numberWithX:-10 andY:540];
	XCTAssertTrue([number xValue] == -10, @"negative error failed.");
	XCTAssertTrue([number yValue] == 540, @"negative error failed.");
}

- (void)testUpperBounds
{
	NSNumber *number = [NSNumber numberWithX:32767 andY:32767];
	XCTAssertTrue([number xValue] == 32767, @"upper bounds checking for x failed.");
	XCTAssertTrue([number yValue] == 32767, @"upper bounds checking for y failed.");

	number = [NSNumber numberWithX:32768 andY:32768];
	XCTAssertTrue([number xValue] == -1, @"upper bounds checking for x failed.");
	XCTAssertTrue([number yValue] == -1, @"upper bounds checking for y failed.");

	number = [NSNumber numberWithX:-32768 andY:-32768];
	XCTAssertTrue([number xValue] == -1, @"upper bounds checking for -x failed.");
	XCTAssertTrue([number yValue] == -1, @"upper bounds checking for -y failed.");

	number = [NSNumber numberWithX:-32767 andY:-32767];
	XCTAssertTrue([number xValue] == -32767, @"upper bounds checking for -x failed.");
	XCTAssertTrue([number yValue] == -32767, @"upper bounds checking for -y failed.");
}

- (void)testOneMillion
{
	NSNumber *number;
	NSMutableArray *yArray = [NSMutableArray arrayWithCapacity:ITTERATION_TESTS_Y];
	NSMutableArray *xArray = [NSMutableArray arrayWithCapacity:ITTERATION_TESTS_X];
	for (int x = 0; x < ITTERATION_TESTS_X; x++) {
		for (int y = 0; y < ITTERATION_TESTS_Y; y++) {
			number = [NSNumber numberWithX:x andY:y];
			[xArray addObject:number];
		}
		[yArray addObject:xArray];
		xArray = [NSMutableArray arrayWithCapacity:ITTERATION_TESTS_X];
	}
	int x,y;
	for (NSArray *subArray in yArray) {
		for (NSNumber *xyNum in subArray) {
			x = [xyNum xValue];
			y = [xyNum yValue];
		}
	}
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:yArray];
	NSLog(@"NSNumber+XYCoordinates - size of %i objects in multi-dimensional array is %lu",(ITTERATION_TESTS_X * ITTERATION_TESTS_Y), (unsigned long)[data length]);
}

- (void)testCGPointStringComparison
{
	CGPoint point;
	NSString *pointString;
	NSMutableArray *yArray = [NSMutableArray arrayWithCapacity:ITTERATION_TESTS_X];
	NSMutableArray *xArray = [NSMutableArray arrayWithCapacity:ITTERATION_TESTS_Y];
	for (int x = 0; x < ITTERATION_TESTS_X; x++) {
		for (int y = 0; y < ITTERATION_TESTS_Y; y++) {
			point = CGPointMake(x, y);
			pointString = NSStringFromCGPoint(point);
			[xArray addObject:pointString];
		}
		[yArray addObject:xArray];
		xArray = [NSMutableArray arrayWithCapacity:ITTERATION_TESTS_X];
	}
	int x,y;
	for (NSArray *subArray in yArray) {
		for (NSString *xyString in subArray) {
			point = CGPointFromString(xyString);
			x = point.x;
			y = point.y;
		}
	}
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:yArray];
	NSLog(@"CGPointToNSString - size of %i string objects in multidimensional array is %lu", (ITTERATION_TESTS_X * ITTERATION_TESTS_Y), (unsigned long)[data length]);
}

- (void)testDictionaryComparison
{
	NSNumber *number;
	NSMutableDictionary *xyDict = [NSMutableDictionary dictionaryWithCapacity:(ITTERATION_TESTS_X * ITTERATION_TESTS_Y)];
	for (int x = 0; x < ITTERATION_TESTS_X; x++) {
		for (int y = 0; y < ITTERATION_TESTS_Y; y++) {
			number = [NSNumber numberWithX:x andY:y];
			[xyDict setObject:number forKey:number];
		}
	}
	int x,y;
	for (NSNumber *key in xyDict) {
		x = [key xValue];
		y = [key yValue];
	}
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:xyDict];
	NSLog(@"NSDictionary - size of %i objects in NSDictionary is %lu",(ITTERATION_TESTS_X * ITTERATION_TESTS_Y), (unsigned long)[data length]);
}

- (void)testNSSetComparison
{
	NSNumber *number;
	NSMutableSet *xySet = [NSMutableSet setWithCapacity:(ITTERATION_TESTS_X * ITTERATION_TESTS_Y)];
	for (int x = 0; x < ITTERATION_TESTS_X; x++) {
		for (int y = 0; y < ITTERATION_TESTS_Y; y++) {
			number = [NSNumber numberWithX:x andY:y];
			[xySet addObject:number];
		}
	}
	int x,y;
	for (NSNumber *setValue in xySet) {
		x = [setValue xValue];
		y = [setValue yValue];
	}
	NSData *data = [NSKeyedArchiver archivedDataWithRootObject:xySet];
	NSLog(@"NSSet - size of %i objects in set is %lu",(ITTERATION_TESTS_X * ITTERATION_TESTS_Y), (unsigned long)[data length]);
}


@end
