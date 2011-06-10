//
//  GBParser.h
//  appledoc
//
//  Created by Tomaz Kragelj on 23.7.10.
//  Copyright (C) 2010, Gentle Bytes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBParser : NSObject

+ (id)parserWithSettingsProvider:(id)settingsProvider;

- (id)initWithSettingsProvider:(id)settingsProvider;

- (void)parseObjectsFromPaths:(NSArray *)paths toStore:(id)store;

- (void)parseDocumentsFromPaths:(NSArray *)paths toStore:(id)store;

@end
