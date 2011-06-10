//
//  GBParser.h
//  appledoc
//
//  Created by Tomaz Kragelj on 23.7.10.
//  Copyright (C) 2010, Gentle Bytes. All rights reserved.
//

#import <Foundation/Foundation.h>

/** <#(brief description of GBParser)#>

 <#(comprehensive description)#>

*/
@interface GBParser : NSObject

/** <#(brief description)#>

 <#(comprehensive description)#>

 @param settingsProvider <#(description of settingsProvider)#>
 @return <#(description of return value)#>
*/
+ (id)parserWithSettingsProvider:(id)settingsProvider;

/** <#(brief description)#>

 <#(comprehensive description)#>

 @param settingsProvider <#(description of settingsProvider)#>
 @return <#(description of return value)#>
*/
- (id)initWithSettingsProvider:(id)settingsProvider;

/** <#(brief description)#>

 <#(comprehensive description)#>

 @param paths <#(description of paths)#>
 @param store <#(description of store)#>
*/
- (void)parseObjectsFromPaths:(NSArray *)paths toStore:(id)store;

/** <#(brief description)#>

 <#(comprehensive description)#>

 @param paths <#(description of paths)#>
 @param store <#(description of store)#>
*/
- (void)parseDocumentsFromPaths:(NSArray *)paths toStore:(id)store;

@end
