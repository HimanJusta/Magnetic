//
//  SKTexture+Gradient.swift
//  Magnetic
//
//  Created by Himanshu on 30/11/18.
//  Copyright © 2018 efremidze. All rights reserved.
//

import SpriteKit

extension SKTexture
{
    convenience init(radialGradientWithColors colors: [UIColor], locations: [CGFloat], size: CGSize)
    {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { (context) in
            let colorSpace = context.cgContext.colorSpace ?? CGColorSpaceCreateDeviceRGB()
            let cgColors = colors.map({ $0.cgColor }) as CFArray
            guard let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors, locations: UnsafePointer<CGFloat>(locations)) else {
                fatalError("Failed creating gradient.")
            }
            
            let radius = max(size.width, size.height) / 2.0
            let midPoint = CGPoint(x: size.width / 2.0, y: size.height / 2.0)
            context.cgContext.drawRadialGradient(gradient, startCenter: midPoint, startRadius: 0, endCenter: midPoint, endRadius: radius, options: [])
        }
        
        self.init(image: image)
    }
    
    convenience init(linearGradientWithAngle angleInRadians: CGFloat, colors: [UIColor], locations: [CGFloat], size: CGSize)
    {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { (context) in
            let colorSpace = context.cgContext.colorSpace ?? CGColorSpaceCreateDeviceRGB()
            let cgColors = colors.map({ $0.cgColor }) as CFArray
            guard let gradient = CGGradient(colorsSpace: colorSpace, colors: cgColors, locations: UnsafePointer<CGFloat>(locations)) else {
                fatalError("Failed creating gradient.")
            }
            
            let angles = [angleInRadians + .pi, angleInRadians]
            let radius = (pow(size.width / 2.0, 2.0) + pow(size.height / 2.0, 2.0)).squareRoot()
            let points = angles.map { (angle) -> CGPoint in
                let dx = radius * cos(-angle) + size.width / 2.0
                let dy = radius * sin(-angle) + size.height / 2.0
                return CGPoint(x: dx, y: dy)
            }
            
            context.cgContext.drawLinearGradient(gradient, start: points[0], end: points[1], options: [])
        }
        
        self.init(image: image)
    }
}
