//
//  TEDataToObjectParser.h
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TEDataToObjectParser <NSObject>
/**
 Parse data into object asynchronously
 
 @param data        the input data to parse
 @param targetClass the target class of the result
 @param complete    the completion block to be called after parsing complete. This may not be called on main thread.
 */
-(void) parseData:(NSData*) data intoObjectOfClass:(Class) targetClass complete:(void (^)(id resultObject, NSError *parseError)) complete;
@end
