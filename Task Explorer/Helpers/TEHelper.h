//
//  TEHelper.h
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TEHelper : NSObject

/**
 Check if string containt at least 1 non space character
 
 @param string target string to check
 @return YES if string is nil, or just contains spaces and new lines. NO otherwise
 */
+(BOOL) isEmptyString:(NSString*) string;


/**
 Simple error handling by displaying everything to user.
 
 @param error error to show
 @param viewController the view controller to show this error message in
 */
+(void) showError:(NSError*) error inViewController:(UIViewController*) viewController;

/**
 Placeholder for missing image
 
 @return placeholder for missing image
 */
+(UIImage*) imagePlaceholder;

/**
 Resize a uiimage to a different size
 
 @param image image to resize
 @param newSize new size of result
 @return a UIImage with new size
 */
+(UIImage *) imageByResizeImage:(UIImage*)image toSize:(CGSize)newSize;
+(CGSize) sizeThatCoverSize:(CGSize) size withAspectOf:(CGSize) referenceSize;
@end
