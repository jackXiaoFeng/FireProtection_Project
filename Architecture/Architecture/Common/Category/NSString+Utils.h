/**
 *
 * Copyrigth (c),1999-2015,Caimiao.Co.,Ltd.<br/>
 * FileName: <br/>
 * ClassName: <br/>
 *
 * @author:MengXinfa,Email:<a href="mailto:m-java@163.com">m-java@163.com</a> <br/>
 *                            Date: 2015- <br/>
 *                            Descriptin:    <br/>
 *
 *
 *                                          <br/>
 *                            Others:<br/>
 */

#import <Foundation/Foundation.h>

@interface NSString (Utils)
/*
 * 字符串中的汉字，特殊字符进行编码转换，转换的特殊字符有
 *  "!*'();:@+$,/%#[]"
 *
 *
 */
+ (NSString *) stringWithEncoding:(NSString *) URLString;

/*
 * 判断字符串是否null | "" | " " | nil
 * 存在以上情况返回:YES
 * 不存在返回:NO
 */
+ (BOOL) isNull:(NSString *)string;
/*
 * 验证字符串是否是中文
 *  ^[u4e00-u9fa5]
 */
+ (BOOL) isPrefixZN:(NSString *)content;

/**
 *
 *
 * FileName: <br/>
 * ClassName: <br/>
 *
 * @author:MengXinfa,Email:<a href="mailto:m-java@163.com">m-java@163.com</a> <br/>
 *                            Date:  <br/>
 *                            Descriptin:    <br/>
 *
 *   去除字符串两边空格
 *                                          <br/>
 *                            Others:<br/>
 */
+ (NSString *) ridSpace:(NSString *) content;


 


/**
 * Date:             </br>
 * Author:Mengxianfa </br>
 * Descriptin:
 *  验证一个字符串是否是数值型
 *
 * </br>
 *
 * @param
 * @return  
 */
+ (BOOL) isPureInt:(NSString*)string;


/**
 * Date:             </br>
 * Author:Mengxianfa </br>
 * Descriptin:
 *   替换字符串的特殊字符
 *
 * </br>
 *
 * @param
 * @return
 */
+ (NSString *) replaceWithString:(NSString *) sourceString  needReplaceStr:(NSString * ) needReplaceStr replaceTargetStr:(NSString *)  replaceTargetStr;

/**
 * Date:             </br>
 * Author:Mengxianfa </br>
 * Descriptin:
 *   判断是否是浮点型
 *
 * </br>
 *
 * @param
 * @return
 */
- (BOOL) isFloat;

@end
