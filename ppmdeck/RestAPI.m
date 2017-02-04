//
//  RestAPI.m
//  ppmdeck
//
//  Created by Gereldyn Quizora on 14/02/2016.
//  Copyright © 2016 Gereldyn Quizora. All rights reserved.
//

#import "RestAPI.h"

@interface RestAPI() <NSURLConnectionDataDelegate>

@property (nonatomic, strong) NSMutableData *receivedData;
@property (nonatomic, strong) NSURLConnection *requestConnection;

@end
@implementation RestAPI



- (NSMutableData *)receivedData
{
    if (!_receivedData)
    {
        _receivedData = [[NSMutableData alloc] init];
    }
    return _receivedData;
}



-(NSURLConnection *) requestConnection{
    if (!_requestConnection)
    {
        _requestConnection = [[NSURLConnection alloc] init];
    }
    return _requestConnection;
}

-(void) httpRequest:(NSMutableURLRequest *)request
{
 
    NSLog(@"    self.requestConnection");

   // self.requestConnection = [NSURLConnection connectionWithRequest:request
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:request.URL
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                // handle response
                
                
            }] resume];
    
}



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.receivedData appendData:data];
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"ERROR %@", error.description);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.delegate getReceivedData:self.receivedData sender:self];
    self.delegate = nil;
    self.requestConnection = nil;
    self.receivedData = nil;
    
    NSLog(@"FINISH");
}

@end
