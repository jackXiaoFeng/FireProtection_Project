//
//  SZTCard.m
//  ble_nfc_sdk
//
//  Created by sahmoL on 16/6/23.
//  Copyright © 2016年 Lochy. All rights reserved.
//

#import "SZTCard.h"

@implementation SZTCard
//选择深圳通余额/交易记录文件
+(NSData *)getSelectMainFileCmdByte{
    Byte bytes[] = {0x00, (Byte)0xa4, 0x04, 0x00, 0x07, 0x50, 0x41, 0x59, 0x2e, 0x53, 0x5a, 0x54, 0x00};
    return [NSData dataWithBytes:bytes length:13];
}
//获取余额APDU指令
+(NSData *)getBalanceCmdByte{
    Byte bytes[] = {(Byte)0x80, (Byte)0x5c, 0x00, 0x02, 0x04};
    return [NSData dataWithBytes:bytes length:5];
}
//获取交易记录APDU指令
+(NSData *)getTradeCmdByte:(Byte)n {
    Byte bytes[] = {(Byte)0x00, (Byte)0xB2, n, (Byte)0xC4, 0x00};
    return [NSData dataWithBytes:bytes length:5];
}

+(NSString *)getBalance:(NSData *)apduData{
    Byte *bytes = (Byte *)[apduData bytes];
    if ((apduData != nil) && (apduData.length == 6) && (bytes[4] == (Byte)0x90) && (bytes[5] == (Byte)0x00)) {
        long balance = ((long) (bytes[1] & 0x00ff) << 16)
        | ((long) (bytes[2] & 0x00ff) << 8)
        | ((long) (bytes[3] & 0x00ff));
        
        return [NSString stringWithFormat:@"%ld.%ld", balance/100, (balance % 100)];
    }
    return nil;
}
+(NSString *)getTrade:(NSData *)apduData{
    Byte *bytes = (Byte *)[apduData bytes];
    if ((apduData.length == 25) && (bytes[24] == 0x00) && (bytes[23] == (Byte) 0x90)) {
        long money = ((long) (bytes[5] & 0x00ff) << 24)
        | ((long) (bytes[6] & 0x00ff) << 16)
        | ((long) (bytes[7] & 0x00ff) << 8)
        | ((long) (bytes[8] & 0x00ff));
        
        NSString* optStr;
        if ((bytes[9] == 6) || (bytes[9] == 9)) {
            optStr = @"扣款";
        } else {
            optStr = @"充值";
        }
        return [NSString stringWithFormat:@"%02x%02x.%02x.%02x %02x:%02x:%02x %@ %ld.%ld 元",
                bytes[16],
                bytes[17],
                bytes[18],
                bytes[19],
                bytes[20],
                bytes[21],
                bytes[22],
                optStr,
                money / 100,
                money % 100];
    }
    return nil;
}
@end
