//
//  CargoTableCell.m
//  SwitchList for iPad
//
//  Created by Robert Bowdidge on 9/9/12.
//  Copyright (c) 2012 Robert Bowdidge. All rights reserved.
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

#import "CargoTableCell.h"

#import "Cargo.h"

@implementation CargoTableCell

// Fills in all values for the cell based on the cargo object.
- (void) fillInAsCargo: (Cargo*) cargo {
    NSArray *RATE_UNITS_LABEL_ARRAY = [NSArray arrayWithObjects: @"day", @"week", @"month", nil];
    struct CargoRate rate = [cargo cargoRate];
    self.cargoName.text = [cargo name];
    
    NSMutableString *kindString = [NSMutableString stringWithFormat: @"%d cars per %@",
                                   rate.rate, [RATE_UNITS_LABEL_ARRAY objectAtIndex: rate.units]];
    [kindString appendFormat: @", %@", [cargo carType]];
    self.cargoKind.text = kindString;
    self.cargoDescription.text = [cargo description];
    cargoIcon.hidden = NO;
}

// Fills in all values for the cell based on the cargo object.
- (void) fillInAsAddCell {
    cargoName.text = @"Add Cargo";
    cargoKind.text = @"";
    cargoDescription.text = @"";
    cargoIcon.hidden = YES;
}

@synthesize cargoName;
@synthesize cargoKind;
@synthesize cargoDescription;
@synthesize cargoIcon;
@end
