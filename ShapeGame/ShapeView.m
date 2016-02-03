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
    
    switch (shapeType) {
        case ShapeTypeCircle: {
            if (self.isHole) {
                shapeLayer = [ShapeView circleInFrame:self.frame andFillColor:kBackgroundColor];
            } else {
                shapeLayer = [ShapeView circleInFrame:frameWithInset andFillColor:self.shapeColor];
            }
            break;
        }
        case ShapeTypeSquare: {
            if (self.isHole) {
                shapeLayer = [ShapeView rectangleInFrame:self.frame andFillColor:kBackgroundColor];
            } else {
                shapeLayer = [ShapeView rectangleInFrame:frameWithInset andFillColor:self.shapeColor];
            }
            break;
        }
        case ShapeTypeTriangle: {
            if (self.isHole) {
                shapeLayer = [ShapeView triangleInFrame:self.frame andFillColor:kBackgroundColor];
            } else {
                shapeLayer = [ShapeView triangleInFrame:frameWithInset andFillColor:self.shapeColor];
            }
            
            break;
        }
        case ShapeTypeRectangle: {
            if (self.isHole) {
                shapeLayer = [ShapeView rectangleInFrame:self.frame andFillColor:kBackgroundColor];
            } else {
                shapeLayer = [ShapeView rectangleInFrame:frameWithInset andFillColor:self.shapeColor];
            }
            
            break;
        }
        case ShapeTypeDiamond : {
            if (self.isHole) {
                shapeLayer = [ShapeView diamondInFrame:self.frame andFillColor:kBackgroundColor];
            } else {
                shapeLayer = [ShapeView diamondInFrame:frameWithInset andFillColor:self.shapeColor];
            }
            break;
        }
        case ShapeTypeHexagon : {
            if (self.isHole) {
                shapeLayer = [ShapeView hexagonInFrame:self.frame andFillColor:kBackgroundColor];
            } else {
                shapeLayer = [ShapeView hexagonInFrame:frameWithInset andFillColor:self.shapeColor];
            }
            break;
        }
        case ShapeTypeCross: {
            if (self.isHole) {
                shapeLayer = [ShapeView crossInFrame:self.frame andFillColor:kBackgroundColor];
            } else {
                shapeLayer = [ShapeView crossInFrame:frameWithInset andFillColor:self.shapeColor];

            }
            break;
        }
        case ShapeTypeStar: {
            if (self.isHole) {
                shapeLayer = [ShapeView starInFrame:self.frame andFillColor:kBackgroundColor];
            } else {
                shapeLayer = [ShapeView starInFrame:frameWithInset andFillColor:self.shapeColor];
            }
            break;
        } case ShapeTypeHeart : {
            if (self.isHole) {
                shapeLayer = [ShapeView heartInFrame:self.frame andFillColor:kBackgroundColor];
            } else {
                shapeLayer = [ShapeView heartInFrame:frameWithInset andFillColor:self.shapeColor];
            }
            break;
        } case ShapeTypeFlower : {
            if (self.isHole) {
                shapeLayer = [ShapeView flowerInFrame:self.frame andFillColor:kBackgroundColor];
            } else {
                shapeLayer = [ShapeView flowerInFrame:frameWithInset andFillColor:self.shapeColor];
            }
            break;
        }
        default:
            shapeLayer = [ShapeView circleInFrame:frameWithInset andFillColor:self.shapeColor];
            break;
    }
    
    shapeLayer.position = CGPointZero;
    [self.layer addSublayer:shapeLayer];
}

@end
