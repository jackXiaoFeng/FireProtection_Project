 

#import "NSString+Utils.h"


@implementation NSString (Utils)

+ (NSString *) stringWithEncoding:(NSString *) URLString {
    
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   
    return (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)URLString,
                                            NULL,
                                            (CFStringRef)@"!*'();:@+$,/%#[]",
                                            kCFStringEncodingUTF8));
}


+ (BOOL) isNull:(NSString *)string {
    if (nil == string) {
        return YES;
    }
    
    if(NULL == string){
        return YES;
    }
    
    if([@"null" isEqualToString:string]){
        return YES;
    }
    
    if([@"(null)" isEqualToString:string]){
        return YES;
    }
    
    if([@"NSNull" isEqualToString:NSStringFromClass([string class])]) {
        return YES;
    }
    
    
    if([@"" isEqualToString:string]){
        return YES;
    }
    
    if([@"NSString" isEqualToString:NSStringFromClass([string class])]) {
        NSString *tempStr = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if([@"" isEqualToString:tempStr]){
            return YES;
        }
    }
    
    
    return NO;
}

+ (BOOL) isPrefixZN:(NSString *) content {
    
    if ( ![NSString isNull:content] ) {
        
        NSString *parten = @"^[a-z].*";
        NSError* error = NULL;
        
        NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:parten options:nil error:&error];
        
        NSArray* match = [reg matchesInString:content options:NSMatchingCompleted range:NSMakeRange(0, [content length])];
        
        if (match.count != 0) {
            return NO;
        }
    }
    
    return YES;
}


+ (NSString *) ridSpace:(NSString *) content {
    if ([NSString isNull:content]) {
        return content;
    }
    return [content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


+ (BOOL) isPureInt:(NSString*)string {
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}


+ (NSString *) replaceWithString:(NSString *) sourceString  needReplaceStr:(NSString * ) needReplaceStr replaceTargetStr:(NSString *)  replaceTargetStr {
    
    if ([NSString isNull:sourceString]) {
        return nil;
    }
    
    NSMutableString *sourceString_m = [NSMutableString stringWithString:sourceString];
    sourceString = [sourceString_m stringByReplacingOccurrencesOfString:needReplaceStr withString:replaceTargetStr];
    return sourceString;
}

- (BOOL) isFloat
{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

@end
