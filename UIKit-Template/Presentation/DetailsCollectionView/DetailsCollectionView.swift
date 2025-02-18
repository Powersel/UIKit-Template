import UIKit

final class DetailsCollectionView: UIViewController {
  
  private lazy var mainCollectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .vertical
    flowLayout.minimumLineSpacing = 0
    flowLayout.minimumInteritemSpacing = 0
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.register(DetailsCollectionCell.self, forCellWithReuseIdentifier: DetailsCollectionCell.identifier)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = .yellow
    collectionView.showsVerticalScrollIndicator = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  override func viewDidLoad() {
    configureUI()
    loadData()
  }
}

private extension DetailsCollectionView {
  func configureUI() {
    view.addSubview(mainCollectionView)
    NSLayoutConstraint.activate([
      mainCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      mainCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      mainCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      mainCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
  
  func loadData() {
    // Fetch data from network
    Task {
      
      DispatchQueue.main.async { [weak self] in
        self?.mainCollectionView.reloadData()
      }
    }
  }
}

extension DetailsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 10
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCollectionCell.identifier, for: indexPath) as! DetailsCollectionCell
    cell.configure(with: "A+\(indexPath.row)")
    return cell
  }
  
  // Return the size for the item at a given index path
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let h = mainCollectionView.frame.width / 5
    return CGSize(width: mainCollectionView.frame.width, height: h)
  }
}
