//
//  RestAPI.h
//  ppmdeck
//
//  Created by Gereldyn Quizora on 14/02/2016.
//  Copyright © 2016 Gereldyn Quizora. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RestAPI;

@protocol RestAPIDelegate
    - (void)getReceivedData:(NSMutableData *)data sender:(RestAPI *)sender;
@end


@interface RestAPI : NSObject
-(void) httpRequest:(NSMutableURLRequest *) request;

@property (nonatomic, weak) id <RestAPIDelegate> delegate;


#define POST @"POST"
#define GET @"GET"


@end
