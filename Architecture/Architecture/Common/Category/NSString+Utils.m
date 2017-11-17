 

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

//Unicode转UTF-8

+ (NSString*) replaceUnicode:(NSString*)aUnicodeString

{
    
    NSString *tempStr1 = [aUnicodeString stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                           
                                                           mutabilityOption:NSPropertyListImmutable
                           
                                                                     format:NULL
                           
                                                           errorDescription:NULL];
    
    
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
    
}



+(NSString *) utf8ToUnicode:(NSString *)string

{
    NSUInteger length = [string length];
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    for (int i = 0;i < length; i++)
    {
        unichar _char = [string characterAtIndex:i];
        //不够4位直接用0补齐4位16进制数
        [s appendFormat:@"\\u%04X",_char];
    }
    
    return s;
    
}

+(NSString *) allUtf8ToUnicode:(NSString *)string

{
    
    NSUInteger length = [string length];
    
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    
    for (int i = 0;i < length; i++)
        
    {
        
        //unichar _char = [string characterAtIndex:i];
        
        //判断是否为英文和数字
        //
        //        if (_char <= '9' && _char >= '0')
        //
        //        {
        //
        //            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
        //
        //        }
        //
        //        else if(_char >= 'a' && _char <= 'z')
        //
        //        {
        //
        //            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
        //
        //
        //
        //        }
        //
        //        else if(_char >= 'A' && _char <= 'Z')
        //
        //        {
        //
        //            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i, 1)]];
        //
        //        }
        //
        //        else
        //
        //        {
        
        [s appendFormat:@"\\u%x",[string characterAtIndex:i]];
        
        //        }
        
    }
    
    return s;
    
}

+ (NSString*) deleteCharactersInJsonStr:(NSString*)jsonStrTem

{
    NSMutableString *jsonStr = [NSMutableString stringWithString:jsonStrTem];
    NSString *character = nil;
    for (int i = 0; i < jsonStr.length; i ++) {
        character = [jsonStr substringWithRange:NSMakeRange(i, 1)];
        if ([character isEqualToString:@"\\"])
            [jsonStr deleteCharactersInRange:NSMakeRange(i, 1)];
    }
    
    return jsonStr;
}

@end
