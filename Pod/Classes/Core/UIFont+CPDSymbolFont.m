//
//  Created by CocoaPods on TODAYS_DATE.
//  Copyright (c) 2014 PROJECT_OWNER. All rights reserved.
//

#import "UIFont+CPDSymbolFont.h"

NSString *const kHRSymbolFontFamilyName = @"icons";

@implementation UIFont (CPDSymbolFont)

+ (instancetype)cpd_symbolFontWithSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:kHRSymbolFontFamilyName size:size];
    return font;
}

@end
