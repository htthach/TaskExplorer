//
//  TEJSONParser.m
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TEJSONParser.h"
#import "TEBaseModel.h"

static int const TE_PARSING_ERROR_CODE_UNKNOWN_TARGET_CLASS     = 407;
static NSString * const TE_PARSING_ERROR_DOMAIN                 = @"com.taskrexplorer.ios.jsonparser";
@implementation TEJSONParser

/**
 Parse data into object asynchronously
 
 @param data        the input data to parse
 @param targetClass the target class of the result
 @param complete    the completion block to be called after parsing complete.
 */
-(void) parseData:(NSData*) data intoObjectOfClass:(Class) targetClass complete:(void (^)(id resultObject, NSError *parseError)) complete{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //step 1 nsdata to json
        NSError *parseError = nil;
        id responseJson = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
        if(parseError){
            if (complete) {
                complete(nil, parseError);
            }
            return;
        }
        
        //step 2 json to object
        id responseObject = [self parsedObjectFromJsonObject:responseJson basedOnType:targetClass error:&parseError];
        
        if (complete) {
            complete(responseObject, parseError);
        }
        
    });
}

/**
 *  Parse a json object into an object of expected type if possible
 *
 *  @param jsonObject     the json object, usually NSDictionary or NSArray
 *  @param expectedType   the Class of the expected return
 *  @param parseError     the error to return
 *  @return the parsed object of the expected return type
 */
-(id) parsedObjectFromJsonObject:(id) jsonObject basedOnType:(Class) expectedType error:(NSError **)parseError{
    if ([jsonObject isKindOfClass:expectedType]){
        //already of correct object type,
        return jsonObject;
    }
    
    //if caller expect FEBaseModel response and json object is dictionary => we can parse it
    if ([expectedType isSubclassOfClass:[TEBaseModel class]]) {
        
        if ([jsonObject isKindOfClass:[NSDictionary class]]) {
            TEBaseModel *parsedObject = [[expectedType alloc] initWithDictionary:jsonObject error:parseError];
            return parsedObject;
        }
        else if ([jsonObject isKindOfClass:[NSArray class]]){
            TEBaseModel *parsedObject = [[expectedType alloc] initWithArray:jsonObject error:parseError];
            return parsedObject;
        }
    }

    //we don't know how to parse
    *parseError = [NSError errorWithDomain:TE_PARSING_ERROR_DOMAIN code:TE_PARSING_ERROR_CODE_UNKNOWN_TARGET_CLASS userInfo:[NSDictionary dictionaryWithObject:@"Unknown target class for parsing" forKey:NSLocalizedDescriptionKey]];
    return nil;
}
@end
