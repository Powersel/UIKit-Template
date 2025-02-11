import UIKit

final class HomeViewController: UIViewController {
  
  private let coordinator: AppCoordinator
  private let viewModel: HomeViewModelProtocol
  private let tableView = UITableView()
  
  init(_ coordinator: AppCoordinator, _ viewModel: HomeViewModelProtocol) {
    self.coordinator = coordinator
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
    loadInitialData()
  }
}

// MARK: - Private
private extension HomeViewController {
  func configureUI() {
    view.addSubview(tableView)
    tableView.frame = view.bounds
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(HomeViewTableCell.self, forCellReuseIdentifier: HomeViewTableCell.cellID)
  }
  
  func loadInitialData() {
    Task {
      tableView.reloadData()
    }
  }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("Selected row: \(indexPath.row)")
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeViewTableCell.cellID) as? HomeViewTableCell  else {
      return UITableViewCell()
    }
    
    cell.titleLabel.text = "AAA: \(indexPath.section)"
    cell.descriptionLabel.text = "BBB: \(indexPath.row)"
    
    return cell
  }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 50.0
  }
}
