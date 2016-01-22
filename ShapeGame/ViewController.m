//
//  ViewController.m
//  ShapeGame
//
//  Created by Anca Julean on 21/01/16.
//  Copyright © 2016 Anca Julean. All rights reserved.
//

#import "ViewController.h"
#import "ShapeView.h"
#import "DraggableShapeView.h"
#import <GameplayKit/GameplayKit.h>

@interface ViewController () <DraggableShapeViewDelegate>

@property (weak, nonatomic) IBOutlet ShapeView *leftHole;
@property (weak, nonatomic) IBOutlet ShapeView *centerHole;
@property (weak, nonatomic) IBOutlet ShapeView *rightHole;
@property (weak, nonatomic) IBOutlet DraggableShapeView *leftShape;
@property (weak, nonatomic) IBOutlet DraggableShapeView *centerShape;
@property (weak, nonatomic) IBOutlet DraggableShapeView *rightShape;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.leftShape.delegate = self;
    self.centerShape.delegate = self;
    self.rightShape.delegate = self;
    
    [self pairDraggableShape:self.leftShape withHole:self.leftHole ofShapeType:ShapeTypeStar andColor:[ViewController getRandomColor]];
    [self pairDraggableShape:self.centerShape withHole:self.rightHole ofShapeType:ShapeTypeDiamond andColor:[ViewController getRandomColor]];
    [self pairDraggableShape:self.rightShape withHole:self.centerHole ofShapeType:ShapeTypeHeart andColor:[ViewController getRandomColor]];
}

- (void)pairDraggableShape:(DraggableShapeView *)draggableShapeView withHole:(ShapeView *)holeView ofShapeType:(ShapeType)shapeType andColor:(UIColor *)color {
    [draggableShapeView configureWithShapeType:shapeType andColor:color isHole:NO];
    [holeView configureWithShapeType:shapeType andColor:color isHole:YES];
    
    draggableShapeView.holeCenter = holeView.center;
}

+ (UIColor *)getRandomColor {
    
    GKRandomDistribution *randDist = [[GKRandomDistribution alloc] initWithRandomSource:[GKRandomSource sharedRandom]
                                                                            lowestValue:0 highestValue:255];
    NSInteger red = [randDist nextInt];
    NSInteger blue = [randDist nextInt];
    NSInteger green = [randDist nextInt];
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];

}

- (void)shapeViewGotMatched:(ShapeView *)shapeView {
    if (self.leftShape.isMatched && self.rightShape.isMatched && self.centerShape.isMatched) {
        UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:@"Well done!" preferredStyle:UIAlertControllerStyleAlert];
        [ac addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self.leftShape resetToOriginalPosition];
            [self.rightShape resetToOriginalPosition];
            [self.centerShape resetToOriginalPosition];
            
            [self pairDraggableShape:self.leftShape withHole:self.leftHole ofShapeType:ShapeTypeStar andColor:[ViewController getRandomColor]];
            [self pairDraggableShape:self.centerShape withHole:self.rightHole ofShapeType:ShapeTypeDiamond andColor:[ViewController getRandomColor]];
            [self pairDraggableShape:self.rightShape withHole:self.centerHole ofShapeType:ShapeTypeHeart andColor:[ViewController getRandomColor]];
            
        }]];
        [self presentViewController:ac animated:YES completion:NULL];
    }
}


@end
