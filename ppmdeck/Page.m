//
//  Page.m
//  ppmdeck
//
//  Created by Gereldyn Quizora on 06/03/2016.
//  Copyright © 2016 Gereldyn Quizora. All rights reserved.
//

#import "Page.h"

@implementation Page

-(NSString *) code{
    return [self.filename stringByDeletingPathExtension];
}
@end
