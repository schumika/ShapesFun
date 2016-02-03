//
//  ShapeViewDrawingAdditions.h
//  ShapeGame
//
//  Created by Anca Julean on 03/02/16.
//  Copyright © 2016 Anca Julean. All rights reserved.
//

#import "ShapeView.h"

@interface ShapeView (ShapeViewDrawing)

+ (CAShapeLayer *)circleInFrame:(CGRect)originalFrame andFillColor:(UIColor *)fillColor;
+ (CAShapeLayer *)triangleInFrame:(CGRect)originalFrame andFillColor:(UIColor *)fillColor;
+ (CAShapeLayer *)squareInFrame:(CGRect)originalFrame andFillColor:(UIColor *)fillColor;
+ (CAShapeLayer *)rectangleInFrame:(CGRect)originalFrame andFillColor:(UIColor *)fillColor;
+ (CAShapeLayer *)diamondInFrame:(CGRect)originalFrame andFillColor:(UIColor *)fillColor;
+ (CAShapeLayer *)crossInFrame:(CGRect)originalFrame andFillColor:(UIColor *)fillColor;
+ (CAShapeLayer *)hexagonInFrame:(CGRect)originalFrame andFillColor:(UIColor *)fillColor;
+ (CAShapeLayer *)starInFrame:(CGRect)originalFrame andFillColor:(UIColor *)fillColor;
+ (CAShapeLayer *)heartInFrame:(CGRect)originalFrame andFillColor:(UIColor *)fillColor;

+ (CGRect)maximumSquareFrameThatFits:(CGRect)frame;
+ (UIBezierPath *)bezierPathWithPolygonInRect:(CGRect)rect numberOfSides:(NSUInteger)numberOfSides;

@end
