import UIKit

final class SearchBarViewComponent: UIView {
  
  lazy var titleLabel: UILabel = {
      let titleLabel = UILabel()
      titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
      return titleLabel
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    setupView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  private func setupView() {
    backgroundColor = .green
    
    titleLabel.text = "Asfsfsdfsdfsdfsd"
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    addSubview(titleLabel)
    
    NSLayoutConstraint.activate([
      titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
      titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1)
    ])
    
  }
}
