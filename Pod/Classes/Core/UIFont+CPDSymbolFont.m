//
//  Created by CocoaPods on TODAYS_DATE.
//  Copyright (c) 2014 PROJECT_OWNER. All rights reserved.
//

#import "UIFont+CPDSymbolFont.h"
@import CoreText;

@interface CPDBundleKey : NSObject
@end
@implementation CPDBundleKey
@end

NSString *const kCPDSymbolFontFamilyName = @"icons";

@implementation UIFont (CPDSymbolFont)

+ (instancetype)cpd_symbolFontWithSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:kCPDSymbolFontFamilyName size:size];
    if (!font) {
        NSBundle* bundle = [NSBundle bundleForClass:[CPDBundleKey class]];
        NSString *fontPath = [bundle pathForResource:kCPDSymbolFontFamilyName ofType:@"ttf"];
        NSData *inData = [NSData dataWithContentsOfFile:fontPath];
        CFErrorRef error;
        CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)inData);
        CGFontRef cgFont = CGFontCreateWithDataProvider(provider);
        if (! CTFontManagerRegisterGraphicsFont(cgFont, &error)) {
            CFStringRef errorDescription = CFErrorCopyDescription(error);
            NSLog(@"Failed to load font: %@", errorDescription);
            CFRelease(errorDescription);
        }
        CFRelease(cgFont);
        CFRelease(provider);
        font = [UIFont fontWithName:kCPDSymbolFontFamilyName size:size];
    }
    return font;
}

@end
