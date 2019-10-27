//
//  SearchBookCVC.swift
//  GoogleBooksFinder
//
//  Created by Maksim Chizhavko on 10/25/19.
//  Copyright © 2019 Maksim Chizhavko. All rights reserved.
//

import UIKit

class SearchBookTVC: UITableViewCell {
    
    let bookImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .red
        image.image = #imageLiteral(resourceName: "300px-no_image_available.svg")
        return image
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews:[authorName, pagesAmount])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var authorName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .green
        return label
    }()
    
    lazy var pagesAmount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .blue
        return label
    }()
    
    
//    Fix resue of cell
    override func prepareForReuse() {
        bookImage.image = UIImage()
        authorName.text = ""
        pagesAmount.text = ""
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
//        Add subviews
        self.addSubview(bookImage)
        self.addSubview(stackView)
         
        
//        Setup constraints
        let constraints: [NSLayoutConstraint] = [
//            Book image constraints
            bookImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.5),
            bookImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12.5),
            bookImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            bookImage.widthAnchor.constraint(equalToConstant: 120),
//            Stack View constraints
            stackView.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10.5),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12.5),
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
//    Configurate table view cell
    func configurateCell(model: BooksData) {
      guard let authorsArray = model.items.first?.volumeInfo.authors else {
            authorName.text = "No author"
            return
        }
        guard let pages = model.items.first?.volumeInfo.pageCount else { return }
        guard let imageLink = model.items.first?.volumeInfo.imageLinks?.small else { return }
        
        convertImage(imageURL: imageLink)
        pagesAmount.text = "Pages: \(pages)"
        authorName.text = authorsArray.count > 1 ?
            "Authors: \n \(configurate(authors: authorsArray))" :
            "Author: \n \(configurate(authors: authorsArray))"

    }
    
//    Convert array into string
    private func configurate(authors: [String]) -> String{
        var authorsString = String()
        for author in authors {
            authorsString += "\(author)\n"
        }
        
        return authorsString
    }
    
//    Uload images from url
    private func convertImage(imageURL: String) {
        DispatchQueue.global(qos: .background).async {
            guard let url = URL(string: imageURL) else { return }
            do {
                let imageData = try Data(contentsOf: url)
                let bookImage = UIImage(data: imageData)
                self.bookImage.image = bookImage
            }catch {
                print(error.localizedDescription)
            }
        }
        
    }
}
