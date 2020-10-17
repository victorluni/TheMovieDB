//
//  MovieDetailViewController.swift
//  TheMovieDB
//
//  Created by Victor Luni on 06/10/20.
//

import UIKit
import Nuke

class MovieDetailViewController: UIViewController {
    
    var movieDetailView: MovieDetailView!
    var movie: MovieDetailViewModel?
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize: CGRect = UIScreen.main.bounds
        movieDetailView = MovieDetailView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        
        guard let vm = movie else {
            return
        }
        
        movieDetailView.movieDetail = vm
        
        layoutScrollView()
        
        self.view.backgroundColor = .white
        self.edgesForExtendedLayout = []
        
    }
    
    private func layoutView() {
    
    }
    
    private func layoutScrollView() {
        self.view.addSubview(self.scrollView)
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false;

        //Constrain scroll view
        self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true;
        self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true;
        self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true;
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true;
        self.scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true;
        
        self.scrollView.addSubview(movieDetailView)
        movieDetailView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        movieDetailView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        movieDetailView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        movieDetailView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        
        movieDetailView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true;
    }
    
    
    
}

class MovieDetailView: UIView {
    
    var movieDetail: MovieDetailViewModel? {
        didSet {
            titleLabel.text = movieDetail?.title
            overviewLabel.text = movieDetail?.description
            loadImage()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadImage() {
        guard let url = URL(string: self.movieDetail?.imageURL ?? "") else {
            return
        }
        
        Nuke.loadImage(with: url, into: imageView)
    }
    
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    var overviewLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 14, weight: .thin)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    func setupConstraints() {
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(overviewLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        
        overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16).isActive = true
        overviewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        
    }
    
    
}


extension UIView {
    func autoPinEdgesToSuperviewEdges(with insets: UIEdgeInsets = .zero) {
        guard let sv = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(equalTo: sv.leftAnchor, constant: insets.left).isActive = true
        rightAnchor.constraint(equalTo: sv.rightAnchor, constant: insets.right).isActive = true
        topAnchor.constraint(equalTo: sv.topAnchor, constant: insets.top).isActive = true
        bottomAnchor.constraint(equalTo: sv.bottomAnchor, constant: insets.bottom).isActive = true
    }
}
