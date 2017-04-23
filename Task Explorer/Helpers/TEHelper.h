//
//  TEHelper.h
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEHelper : NSObject

/**
 Check if string containt at least 1 non space character
 
 @param string target string to check
 @return YES if string is nil, or just contains spaces and new lines. NO otherwise
 */
+(BOOL) isEmptyString:(NSString*) string;
@end
