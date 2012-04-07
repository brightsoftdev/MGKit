//
//  NSArray_DeepMutableCopy.m
//
//  Created by Matt Gemmell on 02/05/2008.
//  Copyright 2008 Instinctive Code. All rights reserved.
//

#import "NSArray+MGExtensions.h"


@implementation NSArray (MGExtensions)


- (NSMutableArray *)MGKit_deepMutableCopy;
{
    NSMutableArray *newArray;
    NSUInteger index, count;
	
    count = [self count];
    newArray = [[NSMutableArray allocWithZone:[self zone]] initWithCapacity:count];
    for (index = 0; index < count; index++) {
        id anObject;
		
        anObject = [self objectAtIndex:index];
        if ([anObject respondsToSelector:@selector(deepMutableCopy)]) {
            anObject = [anObject MGKit_deepMutableCopy];
            [newArray addObject:anObject];
            [anObject release];
        } else if ([anObject respondsToSelector:@selector(mutableCopyWithZone:)]) {
            anObject = [anObject mutableCopyWithZone:nil];
            [newArray addObject:anObject];
            [anObject release];
        } else {
            [newArray addObject:anObject];
        }
    }
	
    return newArray;
}


@end
