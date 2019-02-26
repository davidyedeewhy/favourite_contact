//
//  ContactViewController.swift
//  Favourite Contact
//
//  Created by David Ye on 23/2/19.
//  Copyright © 2019 David Ye. All rights reserved.
//

import UIKit

class ContactViewController: UICollectionViewController, Requestable {
    
    // MARK: - Variables

    private var contacts: [Contact]? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    private var isFavouriteContacts: Bool = false {
        didSet {
            self.collectionView.reloadData()
        }
    }
    private var segment: UISegmentedControl?
    private var numberOfContacts = 20
    private var numberOfFavourites = 20
    private let cellIdentifier = "cell"
    private let footerIdentifier = "headerCell"
    private let urlString = "https://gist.githubusercontent.com/pokeytc/e8c52af014cf80bc1b217103bbe7e9e4/raw/4bc01478836ad7f1fb840f5e5a3c24ea654422f7/contacts.json"

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        if let contactsUrl = URL(string: urlString) {
            request(contactsUrl, success: { contacts in
                self.contacts = contacts.sorted()
            }) { error in
                // TODO: handle backend error or decoding error
            }
        }
    }

}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension ContactViewController: UICollectionViewDelegateFlowLayout {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let contacts = contacts else { return 0 }
        return isFavouriteContacts
            ? min(numberOfFavourites, contacts.filter { $0.isFavourite }.count)
            : min(numberOfContacts, contacts.count)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        let filteredContacts = isFavouriteContacts
            ? contacts?.filter { $0.isFavourite }
            : contacts
        if let contact = filteredContacts?[indexPath.row],
            let contactCell = cell as? ContactCollectionViewCell
        {
            contactCell.imageView?.image = UIImage(named: contact.gender.imageName)
            contactCell.textLabel?.text = [contact.firstName, contact.lastName].joined(separator: " ")
            contactCell.detailTextLabel?.text = contact.email
            contactCell.favouriteButton?.addTarget(self, action: #selector(didTapFavouriteButton), for: .touchUpInside)
            let heartImage = contact.isFavourite
                ? UIImage(named: "favouriteHeart")
                : UIImage(named: "heart")
            let tintImage = heartImage?.withRenderingMode(.alwaysTemplate)
            contactCell.favouriteButton?.setImage(tintImage, for: .normal)
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerIdentifier, for: indexPath)
        (sectionFooter as? ContactCollectionReusableView)?.button?.addTarget(self, action: #selector(didTapShowMore), for: .touchUpInside)
        return sectionFooter
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard let contacts = contacts else { return CGSize(width: view.frame.size.width, height: 0) }
        if isFavouriteContacts {
            return contacts.filter { $0.isFavourite }.count >= numberOfFavourites
            ? CGSize(width: view.frame.size.width, height: 80)
            : CGSize(width: view.frame.size.width, height: 0)
        }
        return contacts.count >= numberOfContacts
            ? CGSize(width: view.frame.size.width, height: 80)
            : CGSize(width: view.frame.size.width, height: 0)
    }

}

// MARK: - functions

extension ContactViewController {
    
    private func configureView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        flowLayout.itemSize = CGSize(width: 300, height: 150)
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        collectionView.collectionViewLayout = flowLayout
        collectionView.register(ContactCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(ContactCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerIdentifier)
        segment = UISegmentedControl(items: ["All", "Favourites"])
        segment?.selectedSegmentIndex = 0
        segment?.addTarget(self, action: #selector(didSelectSegment), for: .valueChanged)
        navigationItem.titleView = segment
        collectionView.backgroundColor = UIColor(red: 200 / 255.0, green: 226 / 355.0, blue: 243 / 255.0, alpha: 1.0)
    }
    
    @IBAction private func didSelectSegment(_ sender: UISegmentedControl) {
        isFavouriteContacts = sender.selectedSegmentIndex == 1
    }
    
    @IBAction private func didTapFavouriteButton(_ sender: UIButton) {
        if let cell = sender.superview?.superview as? ContactCollectionViewCell,
            let indexPath = collectionView?.indexPath(for: cell),
            let contact = (isFavouriteContacts ? contacts?.filter { $0.isFavourite } : contacts)?[indexPath.row],
            let index = contacts?[contact]
        {
            contacts?[index].isFavourite = !contact.isFavourite
            isFavouriteContacts
                ? collectionView.deleteItems(at: [indexPath])
                : collectionView.reloadItems(at: [indexPath])
        }
    }
    
    @IBAction private func didTapShowMore(_ sender: UIButton) {
        isFavouriteContacts
            ? (numberOfFavourites += 20)
            : (numberOfContacts += 20)
        collectionView.reloadData()
        if let number = collectionView?.numberOfItems(inSection: 0) {
            collectionView.scrollToItem(at: IndexPath(row: number - 1, section: 0), at: .bottom, animated: true)
        }
    }
    
}

