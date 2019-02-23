//
//  ContactViewController.swift
//  Favourite Contact
//
//  Created by David Ye on 23/2/19.
//  Copyright © 2019 David Ye. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {
    
    // MARK: - Variables

    var contacts: [Contact]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }
    
    var isFavouriteContacts: Bool = false {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    var collectionView: UICollectionView?
    var segment: UISegmentedControl?

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension ContactViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFavouriteContacts ? contacts?.filter { $0.isFavourite }.count ?? 0 : contacts?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let contact = contacts?[indexPath.row] {
            (cell as? ContactCollectionViewCell)?.imageView?.image = UIImage(named: contact.gender.imageName)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !isFavouriteContacts, let isFavourite = contacts?[indexPath.row].isFavourite {
            contacts?[indexPath.row].isFavourite = !isFavourite
            collectionView.reloadItems(at: [indexPath])
        }
    }
}

// MARK: - functions

extension ContactViewController {
    
    private func configureView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        flowLayout.itemSize = CGSize(width: view.frame.width - 100, height: (view.frame.width - 40) / 2)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(ContactCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        if let collectionView = collectionView {
            view.addSubview(collectionView)
        }
        let requestManager = RequestManager()
        if let url = URL(string: "https://gist.githubusercontent.com/pokeytc/e8c52af014cf80bc1b217103bbe7e9e4/raw/4bc01478836ad7f1fb840f5e5a3c24ea654422f7/contacts.json") {
            requestManager.request(url, success: { contacts in
                self.contacts = contacts
            }) { error in
                
            }
        }
        segment = UISegmentedControl(items: ["All", "Favourites"])
        segment?.selectedSegmentIndex = 0
        segment?.addTarget(self, action: #selector(didSelectSegment), for: .valueChanged)
        navigationItem.titleView = segment
    }
    
    @IBAction func didSelectSegment(_ sender: UISegmentedControl) {
        isFavouriteContacts = sender.selectedSegmentIndex == 1
    }
    
}
