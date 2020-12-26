import UIKit

public class FountainFireworkController {

    public init() {}
    
    public var scheduler = FireworkSparkScheduler()

    public func createFirework(at origin: CGPoint, sparkSize: CGSize, scale: CGFloat) -> Firework {
        return FountainFirework(origin: origin, sparkSize: sparkSize, scale: scale)
    }

    public func addFirework(sparks sparksCount: Int,
                     above sourceView: UIView,
                     sparkSize: CGSize = CGSize(width: 9, height: 9),
                     scale: CGFloat = 50.0,
                     offsetY: CGFloat = 0,
                     animationDuration: TimeInterval = 0.2) {
        guard let superview = sourceView.superview else { fatalError() }

//        let origin = CGPoint(x: sourceView.frame.midX, y: sourceView.frame.minY + sourceView.frame.size.height)
//        let firework = self.createFirework(at: origin, sparkSize: sparkSize, scale: scale)
//        
        let origins = [
            CGPoint(x: sourceView.frame.minX, y: sourceView.frame.maxY),
            CGPoint(x: sourceView.frame.maxX, y: sourceView.frame.maxY),
        ]

        for sparkIndex in 0..<sparksCount {
            
            let idx = Int.random(in: 0..<2)
            let origin = origins[idx]
            let firework = self.createFirework(at: origin, sparkSize: sparkSize, scale: scale)
            
            let spark = firework.spark(at: sparkIndex)
            spark.sparkView.isHidden = true
            superview.addSubview(spark.sparkView)

            self.scheduler.schedule(sparks: [spark],
                                    in: superview,
                                    with: FountainFireworkAnimator(),
                                    animationDuration: animationDuration)
        }
        
        
        

    }
}
