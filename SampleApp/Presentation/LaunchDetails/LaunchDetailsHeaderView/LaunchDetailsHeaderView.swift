import UIKit

final class LaunchDetailsHeaderView: UIView, NibLoadable {
    
    @IBOutlet var descriptionLabel: UILabel!
    
    func setup(with viewModel: LaunchDetailsHeaderViewModel) {
        descriptionLabel.text = viewModel.description
    }
}
