

import UIKit

class SearchBookVC: UIViewController {
    
    private let cellID = "tableViewCellID"
    private var booksModel = [BooksData]()
    private var timer: Timer?
    private let networkDataFetcher = NetworkDataFetcher()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.delegate = self
        tv.dataSource = self
        tv.register(SearchBookTVC.self, forCellReuseIdentifier: cellID)
        tv.keyboardDismissMode = .onDrag
        tv.allowsSelection = false
        tv.tableHeaderView = searchBar
        return tv
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Name of book/author"
        searchBar.sizeToFit()
        searchBar.delegate = self
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.titleView = searchBar
//        Add subviews
        view.addSubview(tableView)
        
//        Setup constraints
        let constraints: [NSLayoutConstraint] = [
//            Table view constraints
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    
}
//  MARK: Table View Delegate
extension SearchBookVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension SearchBookVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! SearchBookTVC
        
        let model = booksModel[indexPath.row]
        cell.configurateCell(model: model)
        
        return cell
    }
    
}
//  MARK: Search Bar Delegate
extension SearchBookVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        
        timer = Timer(timeInterval: 0.5, repeats: false, block: { (_) in
            self.networkDataFetcher.fetchImagies(searchTerms: textSearched) { (data) in
                guard let data = data else { return }
                self.booksModel = [data]
                self.tableView.reloadData()
            }
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        self.searchBar.endEditing(true)
    }
}
