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
//  OMTritone.h
//  ObjectiveMagic
//

#import <Foundation/Foundation.h>

/*
 OMTritone is used by my applications when the user
 has to choose between a color, a black and white and
 a sepia image. It takes an image when created, and creates
 the other versions on-demand. It also has a generic method to
 simplify working with UIImages.
 */

@interface OMTritone : NSObject {
	UIImage* originalImage;
	UIImage* sepiaImage;
	UIImage* greyscaleImage;
}
@property(readonly, nonatomic) CGSize size;
@property(readonly, nonatomic) UIImage* originalImage;
@property(readonly, nonatomic) UIImage* sepiaImage;
@property(readonly, nonatomic) UIImage* greyscaleImage;
- (id)initWithImage:(UIImage*)image;
// See code for more info about these:
+ (UIImage*)scaleAndRotateImage:(UIImage*)image;
+ (UIImage*)scaleAndRotateImage:(UIImage*)image maxResolution:(int)maxResolution;
@end
