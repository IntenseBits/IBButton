//
//  IBView.h
//  IBNavigationController
//
//  Created by Chris Birch on 02/07/2016.
//  Copyright © 2016 Intensebits. All rights reserved.
//

@import Cocoa;

IB_DESIGNABLE
@interface IBView : NSView

@property(nonatomic,assign) IBInspectable NSColor* borderColour;
@property(nonatomic,assign) IBInspectable CGFloat borderWidth;
@property (nonatomic,assign) IBInspectable CGFloat cornerRadius;
@property (weak,nonatomic) IBInspectable NSColor* backgroundColour;
@end
