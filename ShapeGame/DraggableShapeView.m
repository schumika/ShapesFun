//
//  DraggableShapeView.m
//  ShapeGame
//
//  Created by Anca Julean on 22/01/16.
//  Copyright © 2016 Anca Julean. All rights reserved.
//

#import "DraggableShapeView.h"

@interface DraggableShapeView ()

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

@end

@implementation DraggableShapeView

- (void)awakeFromNib {
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    self.panGestureRecognizer.minimumNumberOfTouches = 1;
}

- (void)configureWithShapeType:(ShapeType)shapeType andColor:(UIColor *)color isHole:(BOOL)isHole {
    [self addGestureRecognizer:self.panGestureRecognizer];
    self.originalCenter = self.center;
    
    [super configureWithShapeType:shapeType andColor:color isHole:NO];
}

- (void)resetToOriginalPosition {
    self.center = self.originalCenter;
    self.isMatched = NO;
}

- (void)dealloc {
    [self removeGestureRecognizer:self.panGestureRecognizer];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)panGesture {
    
    CGPoint translation = [panGesture translationInView:self];
    panGesture.view.center = CGPointMake(panGesture.view.center.x + translation.x,
                                         panGesture.view.center.y + translation.y);
    [panGesture setTranslation:CGPointMake(0, 0) inView:self];
    
    if ([DraggableShapeView distanceFromHole:self.holeCenter toShape:self.center] < 30.0) {
        if (self.shapeType == ShapeTypeStar || self.shapeType == ShapeTypeHeart) {
            self.center = CGPointMake(self.holeCenter.x + 3.0, self.holeCenter.y + 3.0);
        } else {
            self.center = self.holeCenter;
        }
        
        
        
        __weak typeof(DraggableShapeView *) weakSelf = self;
        if (self.isMatched == NO && [self.delegate respondsToSelector:@selector(shapeViewGotMatched:)]) {
            weakSelf.isMatched = YES;
            [self.delegate shapeViewGotMatched:weakSelf];
        }
    } else if (panGesture.state == UIGestureRecognizerStateEnded || panGesture.state == UIGestureRecognizerStateCancelled) {
        [self resetToOriginalPosition];
    }
    
    
}

#pragma mark - Private methods

+ (CGFloat)distanceFromHole:(CGPoint)holeCenter toShape:(CGPoint)shapeCenter {
    CGFloat distance = 0.0;
    distance = sqrt((shapeCenter.x - holeCenter.x) * (shapeCenter.x - holeCenter.x) + (shapeCenter.y - holeCenter.y) * (shapeCenter.y - holeCenter.y));
    
    return distance;
}

@end
