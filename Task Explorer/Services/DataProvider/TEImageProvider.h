//
//  TEImageProvider.h
//  Task Explorer
//
//  Created by Tinh Thach Hinh on 23/4/17.
//  Copyright © 2017 Hinh Tinh Thach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol TEImageProvider <NSObject>
/**
 Download a photo from server given an endpoint
 
 @param photoEndpoint the photo endpoint of the url to download. If FEConfigurations enable for caching. A cached version will be returned if downloaded this before.
 @param success success callback block
 @param fail fail callback block
 */
-(void) downloadImageForEndpoint:(NSString*) photoEndpoint
                         success:(void (^)(UIImage *image)) success
                            fail:(void (^)(NSError *error)) fail;
@end
