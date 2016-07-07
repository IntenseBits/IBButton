//
//  IBButton.m
//  IBButtonFramework
//
//  Created by Chris Birch on 07/07/2016.
//  Copyright © 2016 Intensebits. All rights reserved.
//

#import "IBButton.h"
#import "NSColor+ColorExtensions.h"
#import "UIView+OSConstraints.h"

@interface IBButton ()
{
	
}

@end
@implementation IBButton
@synthesize titleColour=_titleColour;
@synthesize backgroundColour =_backgroundColour;
@synthesize borderColour =_borderColour;
@synthesize hoverBackgroundColour=_hoverBackgroundColour;
@synthesize highlightBackgroundColour=_highlightBackgroundColour;
@synthesize titleHoverColour=_titleHoverColour;

-(void)setHorizontalPadding:(CGFloat)horizontalPadding
{
	
	_horizontalPadding = horizontalPadding;
	[self setNeedsDisplay];
}
-(void)setVerticalPadding:(CGFloat)verticalPadding
{
	_verticalPadding = verticalPadding;
	[self setNeedsDisplay];
}
-(NSColor *)titleColour
{
	if (!_titleColour)
		_titleColour = [NSColor blackColor];
	return _titleColour;
}

-(void)setCornerRadius:(CGFloat)cornerRadius
{
	_cornerRadius = cornerRadius;
	self.layer.cornerRadius = cornerRadius;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder])
	{
		_gradientAngle = 90;
	}
	
	return self;
}

-(NSColor *)titleColourSelected
{
	if (!_titleColourSelected)
		_titleColourSelected = [_titleColour lightenColorByValue:0.12];
	
	return _titleColourSelected;
}


-(NSColor *)titleHoverColour
{
	if (!_titleHoverColour)
		_titleHoverColour = self.titleColour;
	
	return _titleHoverColour;
}
-(void)setTitleColourMouseOver:(NSColor *)titleHoverColour
{
	_titleHoverColour = titleHoverColour;
	[self setNeedsDisplay];
}

-(NSColor *)hoverBackgroundColour
{
	if (!_hoverBackgroundColour)
		_hoverBackgroundColour = [self.backgroundColour lightenColorByValue:0.3f];
	
	return _hoverBackgroundColour;
}

-(void)setHoverBackgroundColour:(NSColor *)hoverBackgroundColour
{
	_hoverBackgroundColour = hoverBackgroundColour;
	[self setNeedsDisplay];
}




-(NSColor *)highlightBackgroundColour
{
	if (!_highlightBackgroundColour)
		_highlightBackgroundColour = self.backgroundColour;
	
	return _highlightBackgroundColour;
}
-(void)setHighlightBackgroundColour:(NSColor *)highlightBackgroundColour
{
	_highlightBackgroundColour = highlightBackgroundColour;
	[self setNeedsDisplay];
}

-(NSColor *)borderColour
{
	if (!_borderColour)
		_borderColour = [NSColor clearColor];
	
	return _borderColour;
}
-(void)setBorderColour:(NSColor *)borderColour
{
	_borderColour = borderColour;
	self.layer.borderColor = borderColour.CGColor;
	
	[self setNeedsDisplay];
	
	
}

-(void)setBorderWidth:(CGFloat)borderWidth
{
	_borderWidth = borderWidth;
	self.layer.borderWidth = borderWidth;
	[self setNeedsDisplay];
}



-(NSColor *)backgroundColour
{
	if (!_backgroundColour)
		_backgroundColour = [NSColor clearColor];
	
	return _backgroundColour;
}
-(void)setBackgroundColour:(NSColor *)backgroundColour
{
	_backgroundColour = backgroundColour;
	[self setNeedsDisplay];
}

-(void)setTitleColour:(NSColor *)titleColour
{
	_titleColour = titleColour;
	[self setNeedsDisplay];
}

-(NSSize)sizeWithPadding:(BOOL)padding
{
	NSAttributedString *attrString = [self attributedStringFromTitle:self.attributedStringValue];
	
	CGRect rect = [attrString boundingRectWithSize:CGSizeMake(self.frame.size.width,CGFLOAT_MAX) options: NSStringDrawingUsesLineFragmentOrigin context:nil];
	
	CGSize size = rect.size;
 
	if (padding)
	{
	size.width += _horizontalPadding * 2.0f;
	size.height += _verticalPadding * 2.0f;
	}
	
	
	return size;
}
//
-(NSSize)intrinsicContentSize
{
	return [self sizeWithPadding:YES];

}

-(void)drawRect:(NSRect)dirtyRect
{
	NSRect frame = self.bounds;
	
	//if the user has clicked down on the button
	if([self isHighlighted])
	{
		[self drawBackgroundWithColour:self.highlightBackgroundColour withGradient:YES];
		
		//draw title and set content size for intrisic content size method
		[self drawTitle:self.attributedTitle withFrame:self.bounds inView:self];
		return;
	}
	else if(self.isMouseOver)
	{
//		[self drawBackgroundWithColour:self.hoverBackgroundColour];
		
		NSBezierPath* bgPath = [NSBezierPath bezierPathWithRect:frame];
		[bgPath setClip];
		
		NSColor* topColor = self.hoverBackgroundColour;//[self.backgroundColour lightenColorByValue:0.12f];
		
		// gradient for inner portion of button
		NSGradient* bgGradient = [[NSGradient alloc] initWithColorsAndLocations:
								  topColor, 0.0f,
								  self.backgroundColour, 1.0f,
								  nil];
		[bgGradient drawInRect:[bgPath bounds] angle:_gradientAngle];
		
		//draw title and set content size for intrisic content size method
		[self drawTitle:self.attributedTitle withFrame:self.bounds inView:self];
		
		
		return;
	}
	

	[self drawBackgroundWithColour:self.backgroundColour withGradient:YES];
	//make a note of our intrisic content size
	[self drawTitle:self.attributedTitle withFrame:self.bounds inView:self];
	

}




-(void)drawBackgroundWithColour:(NSColor*)colour withGradient:(BOOL)gradient
{
	NSGraphicsContext* ctx = [NSGraphicsContext currentContext];
	[ctx saveGraphicsState];
	
	
	
	if (gradient && colour.alphaComponent != 0)
	{
		NSColor* topColor = [colour lightenColorByValue:0.12f];
		
		NSBezierPath* bgPath = [NSBezierPath bezierPathWithRect:self.bounds];
		[bgPath setClip];
		
		// gradient for inner portion of button
		NSGradient* bgGradient = [[NSGradient alloc] initWithColorsAndLocations:
								  topColor, 0.0f,
								  colour, 1.0f,
								  nil];
		[bgGradient drawInRect:[bgPath bounds] angle:_gradientAngle];
	}
	else
	{
		[colour setFill];
		NSRectFillUsingOperation(self.bounds, NSCompositeSourceOver);
	}
	
	[ctx restoreGraphicsState];
	
}


-(NSAttributedString*)attributedStringFromTitle:(NSAttributedString*)title
{
	NSColor *titleColor = [self isHighlighted] ? self.titleColourSelected : self.isMouseOver ? self.titleHoverColour : self.titleColour;
	NSMutableParagraphStyle* style = [[NSParagraphStyle alloc] init].mutableCopy;
	style.lineBreakMode = NSLineBreakByWordWrapping;
	style.alignment = NSTextAlignmentCenter;
	//	NSFont* font =[NSFont fontWithName:@"Helvetica" size:26];
	NSFont* font = self.font;
	id attrs = @{NSForegroundColorAttributeName :titleColor,NSFontAttributeName:font,NSParagraphStyleAttributeName: style};
	
	NSAttributedString* attrString = [[NSAttributedString alloc] initWithString:self.title attributes:attrs];
	//[attrString addAttributes:attrs range:NSMakeRange(0, [[self title] length])];
	
	//[attrString endEditing];
	
	return attrString;
}


- (void) drawTitle:(NSAttributedString *)title withFrame:(NSRect)frame inView:(NSView *)controlView {
	NSGraphicsContext* ctx = [NSGraphicsContext currentContext];
	
	[ctx saveGraphicsState];
	NSAttributedString *attrString = [self attributedStringFromTitle:title];
	
	
	CGSize size = [self sizeWithPadding:NO];
	
	
	
	CGFloat x,y;
	NSLog(@"Our frame %@",NSStringFromRect(self.frame));
	NSLog(@"Our size %@",NSStringFromSize(size));
	x = (frame.size.width - size.width)/2.0f;
	y = (frame.size.height - size.height)/2.0f;
	
	[attrString drawWithRect:CGRectMake(x, y, size.width, size.height) options:NSStringDrawingUsesLineFragmentOrigin];
//	[attrString drawInRect:];
	
	//NSRect r = [ [self drawTitle:attrString withFrame:frame inView:controlView];
	// 5) Restore the graphics state
	[ctx restoreGraphicsState];
	
}


-(void)awakeFromNib
{
	[super awakeFromNib];
	self.wantsLayer = YES;
	[self setNeedsDisplay];
	
	//border causes weirdness
	self.bordered = NO;
	
	//Filthy but these are set too early by IB before we are ready
	self.borderWidth = self.borderWidth;
	self.borderColour = self.borderColour;
	self.cornerRadius = self.cornerRadius;
	
	//Allows us to be notified when mouse hovers over us
	NSTrackingArea* ta = [[NSTrackingArea alloc] initWithRect:NSZeroRect options:NSTrackingInVisibleRect | NSTrackingActiveAlways | NSTrackingMouseEnteredAndExited owner:self userInfo:nil];
	[self addTrackingArea:ta];
	
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
		[self setNeedsDisplay];
	});
}


#pragma mark -
#pragma mark Mouse stuff

 -(void)mouseEntered:(NSEvent *)theEvent
 {
	 _isMouseOver = YES;
	 [self setNeedsDisplay];
	 
 }

-(void)mouseExited:(NSEvent *)theEvent
{
	_isMouseOver = NO;
	[self setNeedsDisplay];
	
}

@end
