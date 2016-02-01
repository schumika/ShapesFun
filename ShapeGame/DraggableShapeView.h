//
//  DraggableShapeView.h
//  ShapeGame
//
//  Created by Anca Julean on 22/01/16.
//  Copyright © 2016 Anca Julean. All rights reserved.
//

#import "ShapeView.h"

@protocol DraggableShapeViewDelegate;

@interface DraggableShapeView : ShapeView

@property (nonatomic, assign) CGPoint holeCenter;
@property (nonatomic, assign) CGPoint originalCenter;
@property (nonatomic, weak) id<DraggableShapeViewDelegate> delegate;
@property (nonatomic, assign) BOOL isMatched;
- (void)resetToOriginalPosition;

@end

@protocol DraggableShapeViewDelegate <NSObject>

- (void)shapeViewGotMatched:(DraggableShapeView *)shapeView;

@end
