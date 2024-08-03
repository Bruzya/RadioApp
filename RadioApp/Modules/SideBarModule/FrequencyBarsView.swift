import UIKit

import UIKit

final class FrequencyBarsView: UIView {
    private var pointLayers: [CAShapeLayer] = []
    private var gradientLayer: CAGradientLayer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        gradientLayer = CAGradientLayer()
        gradientLayer?.colors = [
            UIColor(red: 0.22, green: 0.32, blue: 0.63, alpha: 1.0).cgColor,
            UIColor(red: 0.60, green: 0.29, blue: 0.59, alpha: 1.0).cgColor, // #9A4A96
            UIColor(red: 0.85, green: 0.19, blue: 0.54, alpha: 1.0).cgColor  // #D8318A
        ]
        gradientLayer?.locations = [0.0, 0.5, 1.0]
        gradientLayer?.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer?.endPoint = CGPoint(x: 1, y: 0.5)
        
        if let gradientLayer = gradientLayer {
            self.layer.addSublayer(gradientLayer)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer?.frame = self.bounds
    }

    func updateBars(with magnitudes: [Float]) {
        guard magnitudes.count > 1 else { return }
        
        // Remove existing point layers
        pointLayers.forEach { $0.removeFromSuperlayer() }
        pointLayers.removeAll()
        
        let width = self.bounds.width
        let height = self.bounds.height
        let barWidth = width / CGFloat(magnitudes.count - 1)
        let pointRadius: CGFloat = 3.0 // Radius of each point
        
        for (index, magnitude) in magnitudes.enumerated() {
            let x = CGFloat(index) * barWidth
            let y = height - CGFloat(magnitude) * height
            
            // Create a circle path for the point
            let pointPath = UIBezierPath(arcCenter: CGPoint(x: pointRadius, y: pointRadius), radius: pointRadius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
            
            // Create a shape layer for the point
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = pointPath.cgPath
            shapeLayer.frame = CGRect(x: x - pointRadius, y: y - pointRadius, width: pointRadius * 2, height: pointRadius * 2)
            shapeLayer.fillColor = UIColor.black.cgColor
            
            // Add the shape layer to the gradient layer's mask
            self.layer.addSublayer(shapeLayer)
            pointLayers.append(shapeLayer)
        }

        // Mask the gradient layer with the combined shape layers
        let combinedMaskLayer = CALayer()
        pointLayers.forEach { combinedMaskLayer.addSublayer($0) }
        gradientLayer?.mask = combinedMaskLayer
    }
}
