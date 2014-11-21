/*
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 
     This controller displays a table with rows. This controller demonstrates how to insert rows after the intial set of rows has been added and displayed.
  
 */

#import "AAPLTableDetailController.h"
#import "AAPLTableRowController.h"

@interface AAPLTableDetailController()

@property (weak, nonatomic) IBOutlet WKInterfaceTable *interfaceTable;
@property (strong, nonatomic) NSArray *cityNames;

@end

@implementation AAPLTableDetailController

- (instancetype)initWithContext:(id)context {
    self = [super initWithContext:context];

    if (self) {
        // Initialize variables here.
        // Configure interface objects here.
        
        [self loadTableData];
    }
    
    return self;
}

- (void)willActivate {
    // This method is called when the controller is about to be visible to the wearer.
    NSLog(@"%@ will activate", self);
}

- (void)didDeactivate {
    // This method is called when the controller is no longer visible.
    NSLog(@"%@ did deactivate", self);
}

- (void)loadTableData {
    NSDictionary *loveData = @{
                                @"controllerIdentifier" : @"Love",
                                @"text" : @"Nina loves your photo",
                                };
    NSDictionary *admireData = @{
                               @"controllerIdentifier" : @"admire",
                               @"text" : @"Nina admires you",
                               };
    self.cityNames = @[loveData, admireData];
    
    [self.interfaceTable setNumberOfRows:self.cityNames.count withRowType:@"default"];
    
    [self.cityNames enumerateObjectsUsingBlock:^(NSString *citName, NSUInteger idx, BOOL *stop) {
        AAPLTableRowController *row = [self.interfaceTable rowControllerAtIndex:idx];
        NSDictionary *rowData = self.cityNames[idx];
        NSLog(@"hello world");
        NSLog(@"%@",rowData[@"text"]);

        [row.rowLabel setText:rowData[@"text"]];
    }];
}

- (void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex {
    NSDictionary *rowData = self.cityNames[rowIndex];
    [self pushControllerWithName:rowData[@"controllerIdentifier"] context:nil];
}

- (NSString *)actionForUserActivity:(NSDictionary *)userActivity context:(id *)context {
    // Set the context to meaningful data that may be in userActivity. You can also set it to data you derive from userActivity.
    *context = userActivity[@"detailInfo"];
    
    // The string returned should be the scene's Identifier, set in Interface Builder, for the controller you want to route the wearer to.
    return userActivity[@"controllerName"];
}


@end
