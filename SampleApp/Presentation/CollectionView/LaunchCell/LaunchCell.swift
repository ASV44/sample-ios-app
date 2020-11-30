import UIKit
import Kingfisher

final class LaunchCell: UICollectionViewCell {
    static var identifier = "ForecastCell"

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var launchStatus: UILabel!
    @IBOutlet private var missionNameLabel: UILabel!
    @IBOutlet private var missionLaunchDateLabel: UILabel!
    @IBOutlet private var flightNumberLabel: UILabel!
    
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with cellModel: LaunchCellModel) {
        imageView.kf.setImage(
            with: cellModel.imageURL,
            placeholder: UIImage.init(named: "SpaceX-placeholder"),
            options: [.processor(DownsamplingImageProcessor(size: imageView.intrinsicContentSize)),
                      .transition(.fade(0.35)),
                      .cacheOriginalImage]
        )
        launchStatus.text = cellModel.success ? "Success" : "Fail"
        launchStatus.textColor = cellModel.success ? .green : .red
        flightNumberLabel.text = "#\(cellModel.flightNumber)"
        missionNameLabel.text = cellModel.missionName
        missionLaunchDateLabel.text = cellModel.formattedDate
    }
}
