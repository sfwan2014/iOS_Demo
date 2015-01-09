
//  AutoSizing.m
//  FinancialIPAD
//
//  Created by mac on 1/21/14.
//  Copyright (c) 2014 CYTX. All rights reserved.
//

#import "CATextLayer+AutoSizing.h"
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@implementation CATextLayer (AutoSizing)

- (void)adjustBoundsToFit
{
    NSAttributedString *as;
    self.string = self.string ? self.string : @"";
    if([self.string isKindOfClass:[NSAttributedString class]]) {
        as = self.string;
#if ! __has_feature(objc_arc)
        [as retain];
#endif
    } else {
        
        UIFont* outfont;
        CFTypeRef layerfont = self.font;
        
        if(layerfont && [(__bridge id) layerfont isKindOfClass:[NSString class]]) {
            outfont = [UIFont fontWithName:(__bridge NSString*)layerfont size:self.fontSize];
        } else {
            CFTypeID ftypeid = CFGetTypeID(layerfont);
            if(ftypeid == CTFontGetTypeID()) {
                CFStringRef fname = CTFontCopyPostScriptName(layerfont);
                outfont = [UIFont fontWithName:(__bridge NSString*)fname size:self.fontSize];
                CFRelease(fname);
            }
            else if (ftypeid == CGFontGetTypeID()) {
                CFStringRef fname = CGFontCopyPostScriptName(layerfont);
                outfont = [UIFont fontWithName:(__bridge NSString*)fname size:self.fontSize];
                CFRelease(fname);
                
            }
            else { // It's undefined, and defaults to Helvetica
                outfont = [UIFont systemFontOfSize:self.fontSize];
            }
        }
        
        as = [[NSAttributedString alloc] initWithString:self.string attributes:@{NSFontAttributeName: outfont}];
    }
    
    CGRect f = self.frame;
    f.size = [as size];
    self.frame = f;
    
#if ! __has_feature(objc_arc)
    [as release];
#endif
}

@end
