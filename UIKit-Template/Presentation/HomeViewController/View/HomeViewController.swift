import UIKit

final class HomeViewController: UIViewController {
  
  private let viewModel: HomeViewModelProtocol
  private let tableView = UITableView()
  
  init(_ viewModel: HomeViewModelProtocol) {
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
    title = "Home screen"
    
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(HomeViewTableCell.self, forCellReuseIdentifier: HomeViewTableCell.cellID)
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
  
  func loadInitialData() {
    Task {
      do {
        try await viewModel.loadData()
        DispatchQueue.main.async { [weak self] in
          self?.tableView.reloadData()
        }
      } catch {
        // Hadnle error state
      }
    }
  }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    viewModel.openDetailsScreen()
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
