import UIKit

final class LaunchCell: UICollectionViewCell {
    static var identifier = "ForecastCell"

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var missionNameLabel: UILabel!
    @IBOutlet private var missionLaunchDateLabel: UILabel!
    
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with cellModel: LaunchCellModel) {
        descriptionLabel.text = cellModel.details
        missionNameLabel.text = cellModel.missionName
        missionLaunchDateLabel.text = cellModel.formattedDate
    }
}
