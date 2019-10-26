//
//   Copyright (c) 2009 Bálint Jánvári
//       www.programmaticmagic.com
//  
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.

//
//  OMMutableImage.m
//  ObjectiveMagic
//


#import "OMMutableImage.h"


@implementation OMMutableImage
@synthesize context;
@synthesize memory;
@synthesize bounds;

- (id)initWithWidth:(NSInteger)width height:(NSInteger)height
{
	bounds = CGRectMake(0, 0, width, height);
	memory = malloc(width * height * 4);
	CGColorSpaceRef cs = CGColorSpaceCreateDeviceRGB();
	context = CGBitmapContextCreate(memory, width, height, 8, width * 4, cs, kCGImageAlphaPremultipliedLast);
	CGColorSpaceRelease(cs);
	return self;
}

- (id)initWithWidth:(NSInteger)width height:(NSInteger)height memory:(void*)mem
{
	bounds = CGRectMake(0, 0, width, height);
	memory = malloc(width * height * 4);
	memcpy(memory, mem, width * height * 4);
	CGColorSpaceRef cs = CGColorSpaceCreateDeviceRGB();
	context = CGBitmapContextCreate(memory, width, height, 8, width * 4, cs, kCGImageAlphaPremultipliedLast);
	CGColorSpaceRelease(cs);
	return self;
}

- (UIImage*)image
{
	CGImageRef CGImage = CGBitmapContextCreateImage(context);
	UIImage* img = [[[UIImage alloc] initWithCGImage:CGImage] autorelease];
	CGImageRelease(CGImage);
	return img;
}

/*
 This class is NSCopying and NSCoding compliant, but
 this does not mean that you should use these methods.
 These are expensive and the resulting data file takes up
 a lot of space. The context is NOT saved or copied, so
 you loose the current state of the graphics context.
 OMMutableImage is designed for in-application image processing,
 and not for storing image data.
 */

- (id)copyWithZone:(NSZone *)zone
{
	return [[OMMutableImage alloc] initWithWidth:bounds.size.width height:bounds.size.height memory:memory];
}

- (void)encodeWithCoder:(NSCoder *)aCoder;
{
	[aCoder encodeObject:[NSData dataWithBytes:memory length:bounds.size.width * bounds.size.height * 4] forKey:@"memory"];
	[aCoder encodeCGRect:bounds forKey:@"bounds"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	bounds = [aDecoder decodeCGRectForKey:@"bounds"];
	NSData* data = [aDecoder decodeObjectForKey:@"memory"];
	memory = malloc(bounds.size.width * bounds.size.height * 4);
	memcpy(memory, [data bytes], bounds.size.width * bounds.size.height * 4);
	CGColorSpaceRef cs = CGColorSpaceCreateDeviceRGB();
	context = CGBitmapContextCreate(memory, bounds.size.width, bounds.size.height, 8, bounds.size.width * 4, cs, kCGImageAlphaPremultipliedLast);
	CGColorSpaceRelease(cs);
	return self;
}

- (void)dealloc
{
	CGContextRelease(context);
	free(memory);
	[super dealloc];
}
@end
