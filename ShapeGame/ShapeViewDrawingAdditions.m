//
//  ShapeViewDrawingAdditions.m
//  ShapeGame
//
//  Created by Anca Julean on 03/02/16.
//  Copyright © 2016 Anca Julean. All rights reserved.
//

#import "ShapeViewDrawingAdditions.h"

@implementation ShapeView (ShapeViewDrawing)

+ (CAShapeLayer *)circleInFrame:(CGRect)originalFrame andFillColor:(UIColor *)fillColor {
    CGFloat shapeInset = 10.0;
    CGRect frame = [self maximumSquareFrameThatFits:CGRectInset(originalFrame,shapeInset, shapeInset)];
    CGFloat radius = frame.size.width / 2.0;
    CGFloat xOffset = (originalFrame.size.width - frame.size.width) / 2.0;
    CGFloat yOffset = (originalFrame.size.height - frame.size.height) / 2.0;
    
    CAShapeLayer *circle = [CAShapeLayer layer];
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(xOffset, yOffset, 2.0*radius, 2.0*radius)
                                             cornerRadius:radius].CGPath;
    circle.fillColor = fillColor.CGColor;
    
    return circle;
}

+ (CAShapeLayer *)triangleInFrame:(CGRect)originalFrame andFillColor:(UIColor *)fillColor {
    CGFloat shapeInset = 10.0;
    CGRect frame = [self maximumSquareFrameThatFits:CGRectInset(originalFrame,shapeInset, shapeInset)];
    
    CGFloat xOffset = (originalFrame.size.width - frame.size.width) / 2.0;
    CGFloat yOffset = (originalFrame.size.height - frame.size.height) / 2.0;
    
    CGFloat side = frame.size.width;
    CGFloat triangleHeight = side * sqrt(3) / 2;
    
    CAShapeLayer *triangle = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(xOffset, triangleHeight + yOffset)];
    [path addLineToPoint:CGPointMake(xOffset + side, triangleHeight + yOffset)];
    [path addLineToPoint:CGPointMake(xOffset + side / 2, yOffset)];
    [path closePath];
    
    triangle.path = path.CGPath;
    triangle.fillColor = fillColor.CGColor;
    return  triangle;
}

+ (CAShapeLayer *)squareInFrame:(CGRect)originalFrame andFillColor:(UIColor *)fillColor {
    CGFloat shapeInset = ceil(originalFrame.size.height / 6.0);
    CGRect frame = [self maximumSquareFrameThatFits:CGRectInset(originalFrame,shapeInset, shapeInset)];
    
    CGFloat xOffset = (originalFrame.size.width - frame.size.width) / 2.0;
    CGFloat yOffset = (originalFrame.size.height - frame.size.height) / 2.0;
    
    CGFloat side = frame.size.width;
    
    CAShapeLayer *square = [CAShapeLayer layer];
    square.path = [UIBezierPath bezierPathWithRect:CGRectMake(xOffset, yOffset, side, side)].CGPath;
    square.fillColor = fillColor.CGColor;
    return  square;
}

+ (CAShapeLayer *)rectangleInFrame:(CGRect)originalFrame andFillColor:(UIColor *)fillColor {
    CGFloat shapeInset = ceil(originalFrame.size.height / 10.0);
    CGRect frame = [self maximumSquareFrameThatFits:CGRectInset(originalFrame,shapeInset, shapeInset)];
    
    CGFloat width = frame.size.width;
    CGFloat height = width * 0.7;
    
    CGFloat xOffset = (originalFrame.size.width - frame.size.width) / 2.0;
    CGFloat yOffset = (originalFrame.size.height - frame.size.height + (width - height)) / 2.0;
    
    CAShapeLayer *square = [CAShapeLayer layer];
    square.path = [UIBezierPath bezierPathWithRect:CGRectMake(xOffset, yOffset, width, height)].CGPath;
    square.fillColor = fillColor.CGColor;
    return  square;
}

+ (CAShapeLayer *)diamondInFrame:(CGRect)originalFrame andFillColor:(UIColor *)fillColor {
    CGFloat shapeInset = ceil(originalFrame.size.height / 10.0);
    CGRect frame = [self maximumSquareFrameThatFits:CGRectInset(originalFrame,shapeInset, shapeInset)];
    
    CGFloat xOffset = (originalFrame.size.width - frame.size.width) / 2.0;
    CGFloat yOffset = (originalFrame.size.height - frame.size.height) / 2.0;
    
    CGFloat side = (frame.size.width / 2) * sqrt(2);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGFloat diagonalSize = sqrt(side * side + side * side);
    [path moveToPoint:CGPointMake(xOffset + diagonalSize / 2.0, yOffset)];
    
    [path addLineToPoint:CGPointMake(xOffset + diagonalSize, diagonalSize / 2.0 + yOffset)];
    [path addLineToPoint:CGPointMake(xOffset + diagonalSize / 2.0, diagonalSize + yOffset)];
    [path addLineToPoint:CGPointMake(xOffset, diagonalSize / 2.0 + yOffset)];
    [path closePath];
    
    CAShapeLayer *diamond = [CAShapeLayer layer];
    diamond.path = path.CGPath;
    diamond.fillColor = fillColor.CGColor;
    return diamond;
}

+ (CAShapeLayer *)crossInFrame:(CGRect)originalFrame andFillColor:(UIColor *)fillColor {
    CGRect frame = [self maximumSquareFrameThatFits:CGRectInset(originalFrame, 5.0, 5.0)];
    
    CGFloat side = frame.size.width;
    CGFloat thirdOfSide = side / 3.0;
    CGFloat twoThirdsOfSide = 2 * thirdOfSide;
    CGFloat minX = CGRectGetMinX(frame) + 5.0;
    CGFloat minY = CGRectGetMinY(frame) + 5.0;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(minX + thirdOfSide, minY)];
    [path addLineToPoint:CGPointMake(minX + twoThirdsOfSide, minY)];
    [path addLineToPoint:CGPointMake(minX + twoThirdsOfSide, thirdOfSide + minY)];
    [path addLineToPoint:CGPointMake(minX + side, thirdOfSide + minY)];
    [path addLineToPoint:CGPointMake(minX + side, twoThirdsOfSide + minY)];
    [path addLineToPoint:CGPointMake(minX + twoThirdsOfSide, twoThirdsOfSide + minY)];
    [path addLineToPoint:CGPointMake(minX + twoThirdsOfSide, side + minY)];
    [path addLineToPoint:CGPointMake(minX + thirdOfSide, side + minY)];
    [path addLineToPoint:CGPointMake(minX + thirdOfSide, twoThirdsOfSide + minY)];
    [path addLineToPoint:CGPointMake(minX, twoThirdsOfSide + minY)];
    [path addLineToPoint:CGPointMake(minX, thirdOfSide + minY)];
    [path addLineToPoint:CGPointMake(minX + thirdOfSide, thirdOfSide + minY)];
    [path closePath];
    
    CAShapeLayer *cross = [CAShapeLayer layer];
    cross.path = path.CGPath;
    cross.fillColor = fillColor.CGColor;
    return cross;
}

+ (CAShapeLayer *)hexagonInFrame:(CGRect)originalFrame andFillColor:(UIColor *)fillColor {
    CGRect frame = [self maximumSquareFrameThatFits:originalFrame];
    
    CGFloat xRadius = CGRectGetWidth(frame) / 2;
    CGFloat yRadius = CGRectGetHeight(frame) / 2;
    
    CGFloat centerX = CGRectGetMidX(frame);
    CGFloat centerY = CGRectGetMidY(frame);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath moveToPoint:CGPointMake(centerX + xRadius, centerY + 0)];
    
    int numberOfSides = 6;
    
    for (NSUInteger i = 0; i < numberOfSides; i++)
    {
        CGFloat theta = 2 * M_PI / numberOfSides * i;
        CGFloat xCoordinate = centerX + xRadius * cosf(theta);
        CGFloat yCoordinate = centerY + yRadius * sinf(theta);
        [bezierPath addLineToPoint:CGPointMake(xCoordinate, yCoordinate)];
    }
    
    [bezierPath closePath];
    
    CAShapeLayer *hexagon = [CAShapeLayer layer];
    hexagon.path = bezierPath.CGPath;
    hexagon.fillColor = fillColor.CGColor;
    return hexagon;
}

+ (CAShapeLayer *)starInFrame:(CGRect)originalFrame andFillColor:(UIColor *)fillColor {
    CGRect frame = [self maximumSquareFrameThatFits:originalFrame];
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.05000 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.67634 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30729 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.97553 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39549 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.78532 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64271 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.79389 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95451 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50000 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.85000 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.20611 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.95451 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.21468 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.64271 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.02447 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.39549 * CGRectGetHeight(frame))];
    [bezierPath addLineToPoint: CGPointMake(CGRectGetMinX(frame) + 0.32366 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.30729 * CGRectGetHeight(frame))];
    [bezierPath closePath];
    
    CAShapeLayer *star = [CAShapeLayer layer];
    star.path = bezierPath.CGPath;
    star.fillColor = fillColor.CGColor;
    return star;
}

+ (CAShapeLayer *)heartInFrame:(CGRect)originalFrame andFillColor:(UIColor *)fillColor {
    CGRect frame = [self maximumSquareFrameThatFits:originalFrame];
    
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.74182 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04948 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.49986 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.24129 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.64732 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.05022 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.55044 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.11201 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.33067 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.06393 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.46023 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.14682 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.39785 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.08864 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.25304 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.05011 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.30516 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.05454 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.27896 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04999 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.00841 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.36081 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.12805 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.05067 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.00977 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.15998 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.29627 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70379 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.00709 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.55420 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.18069 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62648 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.50061 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.92498 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.40835 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77876 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.48812 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.88133 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.70195 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.70407 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.50990 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.88158 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.59821 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.77912 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.99177 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.35870 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.81539 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.62200 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.99308 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.55208 * CGRectGetHeight(frame))];
    [bezierPath addCurveToPoint: CGPointMake(CGRectGetMinX(frame) + 0.74182 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04948 * CGRectGetHeight(frame)) controlPoint1: CGPointMake(CGRectGetMinX(frame) + 0.99040 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.15672 * CGRectGetHeight(frame)) controlPoint2: CGPointMake(CGRectGetMinX(frame) + 0.86824 * CGRectGetWidth(frame), CGRectGetMinY(frame) + 0.04848 * CGRectGetHeight(frame))];
    [bezierPath closePath];
    bezierPath.miterLimit = 4;
    
    CAShapeLayer *heart = [CAShapeLayer layer];
    heart.path = bezierPath.CGPath;
    heart.fillColor = fillColor.CGColor;
    return heart;
}

+ (CGRect)maximumSquareFrameThatFits:(CGRect)frame {
    CGFloat a = MIN(frame.size.width, frame.size.height);
    return CGRectIntegral(CGRectMake(frame.size.width/2 - a/2, frame.size.height/2 - a/2, a, a));
}

+ (UIBezierPath *)bezierPathWithPolygonInRect:(CGRect)rect numberOfSides:(NSUInteger)numberOfSides {
    if (numberOfSides < 3)
    {
        [NSException raise:NSInvalidArgumentException format:@"ZEPolygon requires numberOfSides to be 3 or greater"];
    }
    
    CGFloat xRadius = CGRectGetWidth(rect) / 2;
    CGFloat yRadius = CGRectGetHeight(rect) / 2;
    
    CGFloat centerX = CGRectGetMidX(rect);
    CGFloat centerY = CGRectGetMidY(rect);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    
    [bezierPath moveToPoint:CGPointMake(centerX + xRadius, centerY + 0)];
    
    for (NSUInteger i = 0; i < numberOfSides; i++)
    {
        CGFloat theta = 2 * M_PI / numberOfSides * i;
        CGFloat xCoordinate = centerX + xRadius * cosf(theta);
        CGFloat yCoordinate = centerY + yRadius * sinf(theta);
        [bezierPath addLineToPoint:CGPointMake(xCoordinate, yCoordinate)];
    }
    
    [bezierPath closePath];
    
    return bezierPath;
}

@end
