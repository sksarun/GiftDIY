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
//  OMTritone.m
//  ObjectiveMagic
//

#import "OMTritone.h"
#import "OMMutableImage.h"

@implementation OMTritone
@synthesize originalImage;
@synthesize greyscaleImage;
@synthesize sepiaImage;

- (id)initWithImage:(UIImage*)image
{
	originalImage = [[OMTritone scaleAndRotateImage:image] retain];
	return self;
}
+ (UIImage*)scaleAndRotateImage:(UIImage*)image
{
	return [OMTritone scaleAndRotateImage:image  maxResolution:1024];
}
+ (UIImage*)scaleAndRotateImage:(UIImage*)image maxResolution:(int)maxResolution
{
	/*
	 This method is not my work.
	 See: http://blog.logichigh.com/2008/06/05/uiimage-fix/
	 
	 One of the earliest bugs I had to face was related to image orientations.
	 UIImage stores its orientation in a separate property, which means that the
	 underlying CGImage sometimes has differend orientation and dimensions.
	 This method takes an UIImage and fixes this problem by returning an image that
	 has UIImageOrientationUp orientation, and therefore the CGImage and UIImage
	 representations produce the same results when drawing.
	 
	 It also scales back the image if requested
	 */
    CGImageRef imgRef = image.CGImage;
	
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
	
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > maxResolution || height > maxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = maxResolution;
            bounds.size.height = bounds.size.width / ratio;
        }
        else {
            bounds.size.height = maxResolution;
            bounds.size.width = bounds.size.height * ratio;
        }
    }
	
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
			
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
			if (width <= maxResolution && height <= maxResolution)
			{
				return image;
			}
            break;
			
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
			
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
			
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
			
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
			
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
			
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
			
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
			
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
			
    }
	
    UIGraphicsBeginImageContext(bounds.size);
	
    CGContextRef context = UIGraphicsGetCurrentContext();
	
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
	
    CGContextConcatCTM(context, transform);
	
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
    return imageCopy;
}

- (CGSize)size
{
	return originalImage.size;
}

- (UIImage*)sepiaImage
{
	if (originalImage == nil) return nil;
	if (sepiaImage == nil)
	{
		OMMutableImage* sepia = [[OMMutableImage alloc] initWithWidth:originalImage.size.width height:originalImage.size.height];
		CGContextDrawImage(sepia.context, sepia.bounds, originalImage.CGImage);
		CGContextFlush(sepia.context);
		
		UInt8* memory = sepia.memory;
		UInt8* currentPixel;
		float common;
		uint length = originalImage.size.width * originalImage.size.height * 4;
		for (uint i = 0; i < length; i += 4)
		{
			currentPixel = memory + i;
			common = 0.299 * currentPixel[0] + 0.587 * currentPixel[1] + 0.114 * currentPixel[2];
			currentPixel[0] = common * 0.94;
			currentPixel[1] = common * 0.78;
			currentPixel[2] = common * 0.54;
		}
		
		sepiaImage = [[sepia image] retain];
		[sepia release];
	}
	return sepiaImage;
}

- (UIImage*)greyscaleImage
{
	if (originalImage == nil) return nil;
	if (greyscaleImage == nil)
	{
		OMMutableImage* greyscale = [[OMMutableImage alloc] initWithWidth:originalImage.size.width height:originalImage.size.height];
		CGContextDrawImage(greyscale.context, greyscale.bounds, originalImage.CGImage);
		CGContextFlush(greyscale.context);
		UInt8* memory = greyscale.memory;
		UInt8* currentPixel;
		uint length = originalImage.size.width * originalImage.size.height * 4;
		for (uint i = 0; i < length; i += 4)
		{
			currentPixel = memory + i;
			currentPixel[0] = currentPixel[1] = currentPixel[2] = 0.299 * currentPixel[0] + 0.587 * currentPixel[1] + 0.114 * currentPixel[2];
		}
		
		greyscaleImage = [[greyscale image] retain];
		[greyscale release];
	}
	return greyscaleImage;
}

- (void)dealloc
{
	[originalImage release];
	[sepiaImage release];
	[greyscaleImage release];
	[super dealloc];
}
@end
