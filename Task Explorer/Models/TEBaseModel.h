//
//  TEBaseModel.h
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEBaseModel : NSObject

/**
 Initialize from a dictionary with automatic parsing
 
 @param dictionary the dictionary to initialized from
 @param error return pointer for error from parsing
 @return instance of this class
 */
-(instancetype) initWithDictionary:(NSDictionary*) dictionary error:(NSError**) error;


/**
 Initialize from an array with automatic parsing
 
 @param  array the array to init this object
 @param  error return pointer for error from parsing
 @return instance of this class
 */
-(instancetype) initWithArray:(NSArray*) array error:(NSError**) error;

#pragma mark - to be override

/**
 Return the key map between json key vs this object property name. By default we set property name using camel case and JSON tag from server as snake case.
 Child class can override this if there is mismatch between object property name and json tag.
 
 @return the key map between json key vs this object property name
 */
-(NSMutableDictionary *)getKeyMap;


/**
 Return the name of the property of type array that should be used when we initWithArray

 @return the name of the property of type array that should be used when we initWithArray
 */
-(NSString*) getArrayPropertyNameForArrayParsing;

/**
 if there is a property of type array, return the class of that array's elements
 
 @param arrayName name of that property
 @return class of the array's elements
 */
-(Class) getClassForArrayName:(NSString*) arrayName;
@end
