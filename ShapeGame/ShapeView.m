//
//  ShapeView.m
//  ShapeGame
//
//  Created by Anca Julean on 21/01/16.
//  Copyright © 2016 Anca Julean. All rights reserved.
//

#import "ShapeView.h"
#import "ShapeViewDrawingAdditions.h"


#define kBackgroundColor [UIColor colorWithRed:102.0/255.0 green:1.0 blue:204./255.0 alpha:1.0]


@interface ShapeView ()

@end


@implementation ShapeView

- (instancetype)initWithDefaultFrame {
    self = [super initWithFrame:CGRectZero];
    
    if (!self) return nil;
    
    return self;
}

+ (instancetype)shapeView {
    return [[self alloc] initWithDefaultFrame];
}

- (void)configureWithShapeType:(ShapeType)shapeType andColor:(UIColor *)color isHole:(BOOL)isHole {
    self.shapeType = shapeType;
    self.shapeColor = color;
    self.isHole = isHole;
    
    for (CAShapeLayer *shapelayer in self.layer.sublayers) {
        [shapelayer removeFromSuperlayer];
    }
    
    if (self.isHole) {
        self.backgroundColor = self.shapeColor;
    }
    
    CAShapeLayer *shapeLayer = nil;
    CGRect frameWithInset = CGRectIntegral(CGRectInset(self.frame, 3.0, 3.0));
    
    CGRect shapeFrame = self.isHole ? self.frame : frameWithInset;
    UIColor *fillColor =  self.isHole ? kBackgroundColor : self.shapeColor;
    
    switch (shapeType) {
        case ShapeTypeCircle:
            shapeLayer = [ShapeView circleInFrame:shapeFrame andFillColor:fillColor];
            break;
        case ShapeTypeSquare:
            shapeLayer = [ShapeView squareInFrame:shapeFrame andFillColor:fillColor];
            break;
        case ShapeTypeTriangle:
            shapeLayer = [ShapeView triangleInFrame:shapeFrame andFillColor:fillColor];
            break;
        case ShapeTypeRectangle:
            shapeLayer = [ShapeView rectangleInFrame:shapeFrame andFillColor:fillColor];
            break;
        case ShapeTypeDiamond :
            shapeLayer = [ShapeView diamondInFrame:shapeFrame andFillColor:fillColor];
            break;
        case ShapeTypeHexagon :
            shapeLayer = [ShapeView hexagonInFrame:shapeFrame andFillColor:fillColor];
            break;
        case ShapeTypeCross:
            shapeLayer = [ShapeView crossInFrame:shapeFrame andFillColor:fillColor];
            break;
        case ShapeTypeStar:
            shapeLayer = [ShapeView starInFrame:shapeFrame andFillColor:fillColor];
            break;
        case ShapeTypeHeart :
            shapeLayer = [ShapeView heartInFrame:shapeFrame andFillColor:fillColor];
            break;
       case ShapeTypeFlower :
            shapeLayer = [ShapeView flowerInFrame:shapeFrame andFillColor:fillColor];
            break;
        default:
            shapeLayer = [ShapeView circleInFrame:shapeFrame andFillColor:fillColor];
            break;
    }
    
    shapeLayer.position = CGPointZero;
    [self.layer addSublayer:shapeLayer];
}

@end
