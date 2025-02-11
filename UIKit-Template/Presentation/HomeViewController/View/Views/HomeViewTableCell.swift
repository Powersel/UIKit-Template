import UIKit

final class HomeViewTableCell: UITableViewCell {
  static let cellID: String = "HomeViewTableCell"
  
  let titleLabel = UILabel()
  let descriptionLabel = UILabel()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    titleLabel.text = nil
    descriptionLabel.text = nil
  }
}

private extension HomeViewTableCell {
  func configureUI() {
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.font = UIFont.systemFont(ofSize: 18)
    contentView.addSubview(titleLabel)
    
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    descriptionLabel.font = UIFont.systemFont(ofSize: 12)
    contentView.addSubview(descriptionLabel)
    
    let horizontalAligment: CGFloat = 20
    let verticalAligment: CGFloat = 6
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalAligment),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalAligment),
      titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: horizontalAligment),
      
      descriptionLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: verticalAligment),
      descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalAligment),
      descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: horizontalAligment),
      descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: verticalAligment),
    ])
  }
}
