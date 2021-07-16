//
//  FlipEffect.swift
//  Filmies
//
//  Created by bryan colin on 7/16/21.
//

import SwiftUI

struct FlipEffect: GeometryEffect {
    
    var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }
    
    @Binding var flipped: Bool
    var angle: Double
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        
        DispatchQueue.main.async {
            flipped = angle >= 90 && angle < 270
        }
        
        let newAngle = flipped ? -180 + angle : angle
        
        let angleInRadians = CGFloat(Angle(degrees: newAngle).radians)
        
        var transform3d = CATransform3DIdentity
//        transform3d.m34 = -1/max(size.width, size.height)
        
        transform3d = CATransform3DRotate(transform3d, angleInRadians, 0, 1, 0)
        transform3d = CATransform3DTranslate(transform3d, -size.width / 2, -size.height/2, 0)
        
        let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width / 2, y: size.height / 2))
        
        return ProjectionTransform(transform3d).concatenating(affineTransform)
    }
}
