//
//  MovieCell.swift
//  TheMovieDB
//
//  Created by Victor Luni on 05/10/20.
//

import UIKit
import Nuke

class MovieCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var movie: Movie? {
        didSet {
            titleLabel.text = movie?.title
            overviewLabel.text = movie?.overview
        }
    }
    
    var viewModel: MovieCellViewModel? {
        didSet {
            titleLabel.text = viewModel?.title
            overviewLabel.text = viewModel?.description
            loadImagefrommovie()
        }
    }
    
    private func loadImagefrommovie() {
        let options = ImageLoadingOptions(
          placeholder: UIImage(named: "MoviePlaceholder"),
          transition: .fadeIn(duration: 0.5)
        )
        
        guard let url = URL(string: viewModel?.imageURL ?? "") else {
            return
        }
        
        Nuke.loadImage(with: url, options: options, into: movieBanner)
    }
    
    let movieBanner: UIImageView = {
        //var image = UIImageView(image: UIImage(imageLiteralResourceName: "MoviePlaceholder"))
        var image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.frame = CGRect(x: 0, y: 0, width: 90, height: 90)
        return image
    }()
    
    let titleLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    let overviewLabel: UILabel = {
        var label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.clipsToBounds = true
        return label
    }()
    
    let content: UIView = {
        var content = UIView()
        
        return content
    }()
    
    let stackView: UIStackView = {
        var stack = UIStackView()
        stack.distribution = .fill
        stack.spacing = 4
        stack.axis = .vertical
        
        return stack
    }()
    
    
    private func addImageView() {
        addSubview(movieBanner)
        movieBanner.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        movieBanner.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        movieBanner.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        movieBanner.widthAnchor.constraint(equalToConstant: 90).isActive = true
        movieBanner.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupContentView() {
        content.addSubview(titleLabel)
        content.addSubview(overviewLabel)
        addSubview(content)
        
        titleLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 0).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: 0).isActive = true
        titleLabel.topAnchor.constraint(equalTo: content.topAnchor, constant: 0).isActive = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        overviewLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        overviewLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 0).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: 0).isActive = true
        overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        overviewLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        content.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        content.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 8).isActive = true
        content.leadingAnchor.constraint(equalTo: movieBanner.trailingAnchor, constant: 8).isActive = true
        content.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        content.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        //Add Subviews
        addImageView()
        setupContentView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
