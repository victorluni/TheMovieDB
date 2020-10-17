//
//  NowPlayingTableViewController.swift
//  TheMovieDB
//
//  Created by Victor Luni on 05/10/20.
//

import UIKit
import Nuke

class MovieListTableViewController: UITableViewController, UISearchBarDelegate {

    var movieList: MovieListViewModel = MovieListViewModel()
    var header: String = ""
    var listType: ListType?
    var page = 1
    private let cellIdentifier = "MovieCell"
    let activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    lazy var searchBar: UISearchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MovieCell.self, forCellReuseIdentifier: self.cellIdentifier)
        self.title = header
        fetchNowPlaying()
        if self.title == "Now Playing" {
            let logoutBarButtonItem = UIBarButtonItem(title: "Genres", style: .plain, target: self, action: #selector(gotToGenres))
            self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
        }
        addSearch()
    }
    
    func addSearch() {
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationItem.titleView = searchBar

    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String)
    {
        print("textSearched: \(textSearched)")
        movieList.filterArray(text: textSearched) { (data, error) in
            self.tableView.reloadData()
        }
        
    }
    
    @objc func gotToGenres(){
        let genreVC = GenreTableViewController()
        self.navigationController?.pushViewController(genreVC, animated: true)
    }
    
    func startAnimating() {
        let container: UIView = UIView()
        container.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        container.backgroundColor = .clear
        self.activityView.center = self.view.center
        container.addSubview(activityView)
        self.view.addSubview(container)
        self.activityView.startAnimating()
    }
    
    func stopAnimating() {
        self.activityView.stopAnimating()
    }
    
    
    func fetchNowPlaying() {
        guard let type = self.listType else {
            return
        }
        
        if type == .nowPlaying {
            self.movieList.fetchNowPlaying(completion: { (data, error) in
                self.tableView.reloadData()
            })
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.movieList.movies?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! MovieCell
        
        // Configure the cell...
        //cell.textLabel?.text = self.nowPlaying?.movies[indexPath.row].title
        guard let movie = self.movieList.movies?[indexPath.row] else {
            return UITableViewCell()
        }
        let viewModel = MovieCellViewModel(movie: movie)
        cell.viewModel = viewModel

        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movie = self.movieList.movies?[indexPath.row] else {
            return
        }
        let viewModel = MovieDetailViewModel(movie: movie)
        
        let vc = MovieDetailViewController()
        vc.movie = viewModel
        self.navigationController?.pushViewController(vc, animated: true)
        
    }

    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let movieCount = self.movieList.movies?.count else {
            return
        }
        
        guard let type = self.listType else {
            return
        }
        
        self.page += 1
        if indexPath.row == movieCount - 7 {
            self.movieList.fetchNextPage(url: type.getUrl(), page: self.page, completion: { (data, error) in
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            })
        }
    }
}

enum ListType: String {
    case byGenre
    case nowPlaying
    
    func getUrl() -> ApiValues {
        switch self {
        case .byGenre:
            return ApiValues.moviesByGenre
        case .nowPlaying:
            return ApiValues.nowPlaying
        }
    }
}
