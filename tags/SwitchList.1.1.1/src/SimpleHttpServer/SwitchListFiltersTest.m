//
//
//  SwitchListFiltersTest.m
//  SwitchList
//
//  Created by bowdidge on 8/26/2011
//
// Copyright (c)2011 Robert Bowdidge,
// All rights reserved.
// 
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions
// are met:
// 1. Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
// 2. Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in the
//    documentation and/or other materials provided with the distribution.
// 
// THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
// OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
// HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
// LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
// OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
// SUCH DAMAGE.
//
#import "SwitchListFiltersTest.h"

@implementation SwitchListFilterReplaceRandom 
- (id) setRandomValues: (int*) randomValues {
	currentRandom_ = 0;
	randomValues_ = randomValues;
	consumedTooManyValues_ = NO;
}

- (int) getRandomValue: (int) max {
	if (randomValues_[currentRandom_] != -1) {
		return randomValues_[currentRandom_++];
	}
	// When out, return 0.
	consumedTooManyValues_ = YES;
	return 0;
}

- (BOOL) consumedTooManyValues {
	return consumedTooManyValues_;
}

@end

@implementation SwitchListFiltersTest
- (void) setUp {
	switchListFilter_ = [[SwitchListFilterReplaceRandom alloc] init];
}

- (void) tearDown {
	[switchListFilter_ release];
}

- (void) testAppendEmsp {
	int randomValues[3] = {1, 1, -1};
	SwitchListFilterReplaceRandom *switchListFilter = [[[SwitchListFilterReplaceRandom alloc] init] autorelease];
	[switchListFilter setRandomValues: randomValues];
	
	STAssertEqualObjects(@"ABC&emsp;", [switchListFilter jitterString: @"ABC"], @"Failed to append emsp");
	STAssertFalse([switchListFilter consumedTooManyValues], @"Too many calls to random");

}


- (void) testAppendEnsp {
	int randomValues[3] = {2, 1, -1};
	[switchListFilter_ setRandomValues: randomValues];
	
	STAssertEqualObjects(@"ABC&ensp;", [switchListFilter_ jitterString: @"ABC"], @"Failed to append ensp");
	STAssertFalse([switchListFilter_ consumedTooManyValues], @"Too many calls to random");
}

- (void) testAppendNbsp {
	int randomValues[3] = {0, 1, -1};
	[switchListFilter_ setRandomValues: randomValues];
	
	STAssertEqualObjects(@"ABC&nbsp;", [switchListFilter_ jitterString: @"ABC"], @"Failed to append nbsp");
	STAssertFalse([switchListFilter_ consumedTooManyValues], @"Too many calls to random");
}

- (void) testPrependEmsp {
	int randomValues[3] = {1, 0, -1};
	[switchListFilter_ setRandomValues: randomValues];
	
	STAssertEqualObjects(@"&emsp;ABC", [switchListFilter_ jitterString: @"ABC"], @"Failed to prepend emsp");
	STAssertFalse([switchListFilter_ consumedTooManyValues], @"Too many calls to random");
}

- (void) testPrependEnsp {
	int randomValues[3] = {2, 0, -1};
	[switchListFilter_ setRandomValues: randomValues];
	
	STAssertEqualObjects(@"&ensp;ABC", [switchListFilter_ jitterString: @"ABC"], @"Failed to prepend ensp");
	STAssertFalse([switchListFilter_ consumedTooManyValues], @"Too many calls to random");
}

- (void) testPrependNbsp {
	int randomValues[3] = {0, 0, -1};
	[switchListFilter_ setRandomValues: randomValues];
	
	STAssertEqualObjects(@"&nbsp;ABC", [switchListFilter_ jitterString: @"ABC"], @"Failed to prepend nbsp");
	STAssertFalse([switchListFilter_ consumedTooManyValues], @"Too many calls to random");
}


- (void) testChangeSpacesWithSpaces {
	int randomValues2[3] = {0, 2, -1};
	[switchListFilter_ setRandomValues: randomValues2];
	
	STAssertEqualObjects(@"A&nbsp; BC", [switchListFilter_ jitterString: @"A BC"], @"Failed to append emsp");
	STAssertFalse([switchListFilter_ consumedTooManyValues], @"Too many calls to random");
	
	int randomValues3[3] = {0, 2, -1};
	[switchListFilter_ setRandomValues: randomValues3];
	
	STAssertEqualObjects(@"ABC&nbsp; ", [switchListFilter_ jitterString: @"ABC "], @"Failed to append emsp");
	STAssertFalse([switchListFilter_ consumedTooManyValues], @"Too many calls to random");

	int randomValues4[3] = {0, 2, -1};
	[switchListFilter_ setRandomValues: randomValues4];
	
	STAssertEqualObjects(@"&nbsp; ABC ", [switchListFilter_ jitterString: @" ABC "], @"Failed to append emsp");
	STAssertFalse([switchListFilter_ consumedTooManyValues], @"Too many calls to random");
}


@end