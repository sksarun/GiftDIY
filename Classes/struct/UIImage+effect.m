//
//  UIImage+effect.m
//  GiftDIY
//
//  Created by Tong on 1/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIImage+effect.h"
#import "OMMutableImage.h"

@implementation UIImage(effect)


#pragma mark UIIMage effect
- (UIImage*)greyscaleImage
{
	OMMutableImage* greyscale = [[OMMutableImage alloc] initWithWidth:self.size.width height:self.size.height];
	CGContextDrawImage(greyscale.context, greyscale.bounds, self.CGImage);
	CGContextFlush(greyscale.context);
	UInt8* memory = greyscale.memory;
	UInt8* currentPixel;
	uint length = self.size.width * self.size.height * 4;
	for (uint i = 0; i < length; i += 4)
	{
		currentPixel = memory + i;
		currentPixel[0] = currentPixel[1] = currentPixel[2] = 0.299 * currentPixel[0] + 0.587 * currentPixel[1] + 0.114 * currentPixel[2];
	}
	
	self = [[greyscale image] retain];
	[greyscale release];
	return self;
}
- (UIImage*)sepiaImage
{
	
	OMMutableImage* sepia = [[OMMutableImage alloc] initWithWidth:self.size.width height:self.size.height];
	CGContextDrawImage(sepia.context, sepia.bounds, self.CGImage);
	CGContextFlush(sepia.context);
	
	UInt8* memory = sepia.memory;
	UInt8* currentPixel;
	float common;
	uint length = self.size.width * self.size.height * 4;
	for (uint i = 0; i < length; i += 4)
	{
		currentPixel = memory + i;
		common = 0.299 * currentPixel[0] + 0.587 * currentPixel[1] + 0.114 * currentPixel[2];
		currentPixel[0] = common * 0.94;
		currentPixel[1] = common * 0.78;
		currentPixel[2] = common * 0.54;
	}
	
	self = [[sepia image] retain];
	[sepia release];
	
	return self;
}

-(UIImage*) BurnImage
{
	CGImageRef cgImage = [self CGImage];
	CGDataProviderRef provider = CGImageGetDataProvider(cgImage);
	CFDataRef bitmapData = CGDataProviderCopyData(provider);
	UInt8* data = (UInt8*)CFDataGetBytePtr(bitmapData); 
	
	int width = self.size.width;
	int height = self.size.height;
	NSInteger myDataLength = width * height * 4;
	
	
	for (int i = 0; i < myDataLength; i+=4)
	{
		UInt8 r_pixel = data[i];
		UInt8 g_pixel = data[i+1];
		UInt8 b_pixel = data[i+2];
		
		int outputRed = (r_pixel * .393) + (g_pixel *.769) + (b_pixel * .189);
		int outputGreen = (r_pixel * .349) + (g_pixel *.686) + (b_pixel * .168);
		int outputBlue = (r_pixel * .272) + (g_pixel *.534) + (b_pixel * .131);
		
		if(outputRed>255)outputRed=255;
		if(outputGreen>255)outputGreen=255;
		if(outputBlue>255)outputBlue=255;
		
		
		data[i] = outputRed;
		data[i+1] = outputGreen;
		data[i+2] = outputBlue;
	}
	
	CGDataProviderRef provider2 = CGDataProviderCreateWithData(NULL, data, myDataLength, NULL);
	int bitsPerComponent = 8;
	int bitsPerPixel = 32;
	int bytesPerRow = 4 * width;
	CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
	CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
	CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
	CGImageRef imageRef = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider2, NULL, NO, renderingIntent);
	
	CGColorSpaceRelease(colorSpaceRef); // YOU CAN RELEASE THIS NOW
	CGDataProviderRelease(provider2); // YOU CAN RELEASE THIS NOW
	CFRelease(bitmapData);
	
	UIImage *sepiaImage = [UIImage imageWithCGImage:imageRef];
	CGImageRelease(imageRef); // YOU CAN RELEASE THIS NOW
	return sepiaImage;
}

-(UIImage*)makeSepiaScale
{
	CGImageRef cgImage = [self CGImage];
	CGDataProviderRef provider = CGImageGetDataProvider(cgImage);
	CFDataRef bitmapData = CGDataProviderCopyData(provider);
	UInt8* data = (UInt8*)CFDataGetBytePtr(bitmapData); 
	
	int width = self.size.width;
	int height = self.size.height;
	NSInteger myDataLength = width * height * 4;
	
	
	for (int i = 0; i < myDataLength; i+=4)
	{
		UInt8 r_pixel = data[i];
		UInt8 g_pixel = data[i+1];
		UInt8 b_pixel = data[i+2];
		
		int outputRed = (r_pixel * .393) + (g_pixel *.769) + (b_pixel * .189);
		int outputGreen = (r_pixel * .349) + (g_pixel *.686) + (b_pixel * .168);
		int outputBlue = (r_pixel * .272) + (g_pixel *.534) + (b_pixel * .131);
		
		if(outputRed>255)outputRed=255;
		if(outputGreen>255)outputGreen=255;
		if(outputBlue>255)outputBlue=255;
		
		
		data[i] = outputRed;
		data[i+1] = outputGreen;
		data[i+2] = outputBlue;
	}
	
	CGDataProviderRef provider2 = CGDataProviderCreateWithData(NULL, data, myDataLength, NULL);
	int bitsPerComponent = 8;
	int bitsPerPixel = 32;
	int bytesPerRow = 4 * width;
	CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
	CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
	CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
	CGImageRef imageRef = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider2, NULL, NO, renderingIntent);
	
	CGColorSpaceRelease(colorSpaceRef); // YOU CAN RELEASE THIS NOW
	CGDataProviderRelease(provider2); // YOU CAN RELEASE THIS NOW
	CFRelease(bitmapData);
	
	UIImage *sepiaImage = [UIImage imageWithCGImage:imageRef];
	CGImageRelease(imageRef); // YOU CAN RELEASE THIS NOW
	return sepiaImage;
}
-(UIImage*) NegativeImage
{
	UIGraphicsBeginImageContext(self.size);
	CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeCopy);
	[self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
	CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeDifference);
	CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(),[UIColor grayColor].CGColor);
	CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, self.size.width, self.size.height));
	self = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return self;
	
	
}
-(UIImage*) imageOverlay
{
	
	UIGraphicsBeginImageContext(self.size);
	CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeCopy);
	[self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
	CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeLighten);
	CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(),[UIColor yellowColor].CGColor);
	CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, self.size.width, self.size.height));
	self = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return self;
}
-(UIImage*) ApplyBendWithMode:(int)mode withColor:(UIColor*) color
{
	int a = kCGBlendModeDifference;
	UIGraphicsBeginImageContext(self.size);
	CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeCopy);
	[self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
	CGContextSetBlendMode(UIGraphicsGetCurrentContext(), a);
	CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(),color.CGColor);
	CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, self.size.width, self.size.height));
	self = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return self;
}
- (UIImage*)imageWithShadow
{
	CGImageRef cgImage = [self CGImage];
	int width = self.size.width;
	int height = self.size.height;
	
	
	CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef shadowContext = CGBitmapContextCreate(NULL, width + 10, height + 10, CGImageGetBitsPerComponent(cgImage), 0, 
													   colourSpace, kCGImageAlphaPremultipliedLast);
	if(shadowContext)
	{
	CGColorSpaceRelease(colourSpace);
	CGContextSetShadowWithColor(shadowContext, CGSizeMake(5, -5), 5, [UIColor blackColor].CGColor);
	CGContextDrawImage(shadowContext, CGRectMake(0, 10, width, height), cgImage);
	
	CGImageRef shadowedCGImage = CGBitmapContextCreateImage(shadowContext);
	CGContextRelease(shadowContext);
	
	UIImage * shadowedImage = [UIImage imageWithCGImage:shadowedCGImage];
	CGImageRelease(shadowedCGImage);
	
	return shadowedImage;
	}
	return nil;
}

@end
