//
//  TEHelper.m
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import "TEHelper.h"

@implementation TEHelper

/**
 Check if string containt at least 1 non space character
 
 @param string target string to check
 @return YES if string is nil, or just contains spaces and new lines. NO otherwise
 */
+(BOOL) isEmptyString:(NSString*) string{
    NSString *trim = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return (trim == nil || [trim length] == 0);
}

/**
 Simple error handling by displaying everything to user.
 
 @param error error to show
 @param viewController the view controller to show this error message in
 */
+(void) showError:(NSError*) error inViewController:(UIViewController*) viewController{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:viewController.title message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okAction];
    [viewController presentViewController:alertController animated:YES completion:nil];
}


/**
 Placeholder for missing image
 
 @return placeholder for missing image
 */
+(UIImage*) imagePlaceholder{
    return [UIImage imageNamed:@"Placeholder"];
}


/**
 Resize a uiimage to a different size

 @param image image to resize
 @param newSize new size of result
 @return a UIImage with new size
 */
+(UIImage *) imageByResizeImage:(UIImage*)image toSize:(CGSize)newSize{
    CGFloat scale = [[UIScreen mainScreen]scale];
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


+(CGSize) sizeThatCoverSize:(CGSize) size withAspectOf:(CGSize) referenceSize{
    if (referenceSize.height < 0.001 || referenceSize.width < 0.001) {
        return size;
    }
    
    CGFloat height = size.height;
    CGFloat width = size.width;
    CGFloat convertWidth = height * referenceSize.width / referenceSize.height;
    CGFloat convertHeight = referenceSize.height * width / referenceSize.width;
    if (convertWidth > width) {
        return CGSizeMake(convertWidth, height);
    }
    else {
        return CGSizeMake(width, convertHeight);
    }
}
@end
