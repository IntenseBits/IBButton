//
//  IBButton.h
//  IBButtonFramework
//
//  Created by Chris Birch on 07/07/2016.
//  Copyright © 2016 Intensebits. All rights reserved.
//

#import <Cocoa/Cocoa.h>

IB_DESIGNABLE

/**
 * A customisable button designed to be a drop-in replacement into your storyboards
 */
@interface IBButton : NSButton

@property (strong,nonatomic) IBInspectable NSColor* borderColour;
@property (assign,nonatomic) IBInspectable CGFloat borderWidth;
@property (strong,nonatomic) IBInspectable NSColor* backgroundColour;
@property (strong,nonatomic) IBInspectable NSColor* highlightBackgroundColour;
@property (strong,nonatomic) IBInspectable NSColor* hoverBackgroundColour;
@property (strong,nonatomic) IBInspectable NSColor* titleColour;
@property (strong,nonatomic) IBInspectable NSColor* titleColourSelected;
@property (strong,nonatomic) IBInspectable NSColor* titleHoverColour;
@property (assign,nonatomic) IBInspectable CGFloat cornerRadius;
@property (assign,nonatomic) IBInspectable CGFloat gradientAngle;
@property (assign,nonatomic) IBInspectable CGFloat verticalPadding;
@property (assign,nonatomic) IBInspectable CGFloat horizontalPadding;
@property (readonly,nonatomic) BOOL isMouseOver;



@end
