//
//  Picture.h
//  TestAutoLayout3
//
//  Created by mobidevM199 on 15.12.14.
//  Copyright (c) 2014 mobidevM199. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Picture : NSManagedObject

@property (nonatomic, retain) id bigPic;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) id pic;
@property (nonatomic, retain) NSString * picFileName;

@end
