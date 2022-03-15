//
//  GeometryExtensions.swift
//  FLIRUI
//
//  Created by Lescai, Ionel on 2020-07-30.
//  Copyright © 2020 FLIR Systems AB. All rights reserved.
//

import Foundation

// TODO: Write tests!

public extension CGPoint {
    func scaled(by scale: CGFloat) -> CGPoint {
        CGPoint(x: x * scale, y: y * scale)
    }
    
    func convert(fromRect source: CGRect, toRect destination: CGRect) -> CGPoint {
        ilerp(rect: source).lerp(rect: destination)
    }
}

public extension CGSize {
    func scaled(by scale: CGFloat) -> CGSize {
        CGSize(width: width * scale, height: height * scale)
    }
}

public extension CGRect {
    func scaled(by scale: CGFloat) -> CGRect {
        CGRect(origin: origin.scaled(by: scale),
               size: size.scaled(by: scale))
    }
    
    func convert(fromRect source: CGRect, toRect destination: CGRect) -> CGRect {
        ilerp(rect: source).lerp(rect: destination)
    }
}

public func + (lhs: CGPoint, rhs: CGVector) -> CGPoint {
    CGPoint(x: lhs.x + rhs.dx, y: lhs.y + rhs.dy)
}

public func - (lhs: CGPoint, rhs: CGVector) -> CGPoint {
    CGPoint(x: lhs.x - rhs.dx, y: lhs.y - rhs.dy)
}

public func * (lhs: (CGFloat, CGFloat), rhs: CGVector) -> CGVector {
    CGVector(dx: lhs.0 * rhs.dx, dy: lhs.1 * rhs.dy)
}
