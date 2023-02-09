import UIKit

public final class CircleColorSparkView: SparkView {

    public init(color: UIColor, size: CGSize) {
        super.init(frame: CGRect(origin: .zero, size: size))
        self.backgroundColor = color
        self.layer.cornerRadius = self.frame.width / 2.0
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension UIColor {

    public static var sparkColorSet1: [UIColor] = {
        return [
            UIColor(red: 0.91, green: 0.30, blue: 0.24, alpha: 1.00),
            UIColor(red: 1, green: 1, blue: 1, alpha:1.00),
            UIColor(red: 0, green: 0, blue: 0, alpha: 1.00),
            UIColor(red: 1, green: 1, blue: 1, alpha:1.00),
        ]
    }()
}
