//
//  IBView.m
//  IBNavigationController
//
//  Created by Chris Birch on 02/07/2016.
//  Copyright © 2016 Intensebits. All rights reserved.
//

#import "IBView.h"

@interface IBView ()

@property (weak,nonatomic) IBView* proxyForIB;

@end
@implementation IBView



-(id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
	IBView* view =[super awakeAfterUsingCoder:aDecoder];
	
	
#if !TARGET_INTERFACE_BUILDER
	// connect to the server
#else
	IBView* proxy = [[IBView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
	view.proxyForIB = proxy;
	
	[view addSubview:proxy];
#endif
	
	return view;
}

-(void)prepareForInterfaceBuilder
{
	_proxyForIB.borderWidth = self.borderWidth;
	_proxyForIB.backgroundColour = self.backgroundColour;
	_proxyForIB.cornerRadius = self.cornerRadius;
	_proxyForIB.borderColour = self.borderColour;
}

-(void)setupForOSX
{

	self.wantsLayer = YES;

}

-(void)setBackgroundColour:(NSColor *)backgroundColour
{
	
	[self setupForOSX];
	
	self.layer.backgroundColor = backgroundColour.CGColor;
}

-(NSColor *)backgroundColour
{
	CGColorRef ref = self.layer.backgroundColor;
	NSColor* colour = nil;
	
	if (!ref)
	{
		colour = [NSColor clearColor];
		
	}
	else
	{
		colour = [NSColor colorWithCGColor:ref];
	}
	
	return colour;
	
}

-(void)setBorderColour:(NSColor*)borderColour
{
	[self setupForOSX];
	self.layer.borderColor = borderColour.CGColor;
}
-(CGFloat)cornerRadius
{
	return self.layer.cornerRadius;
}

-(void)setCornerRadius:(CGFloat)cornerRadius
{
	[self setupForOSX];
	self.layer.cornerRadius = cornerRadius;
}

-(NSColor*)borderColour
{
	CGColorRef ref = self.layer.borderColor;
	NSColor* colour = nil;
	
	if (!ref)
	{
		colour = [NSColor clearColor];
		
	}
	else
	{
		colour = [NSColor colorWithCGColor:ref];
	}
	
	return colour;
}


-(void)setBorderWidth:(CGFloat)borderWidth
{
	[self setupForOSX];
	self.layer.borderWidth = borderWidth;
	
}

-(CGFloat)borderWidth
{
	return self.layer.borderWidth;
}



//- (void)drawRect:(NSRect)dirtyRect {
//    [super drawRect:dirtyRect];
//    
//    // Drawing code here.
//}

@end
