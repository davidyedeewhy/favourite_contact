//
//  ContactViewController.swift
//  Favourite Contact
//
//  Created by David Ye on 23/2/19.
//  Copyright © 2019 David Ye. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController, Requestable {
    
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
    private var numbersOfPerPage = 20
    private let cellIdentifier = "cell"
    private let footerIdentifier = "headerCell"
    private let urlString = "https://gist.githubusercontent.com/pokeytc/e8c52af014cf80bc1b217103bbe7e9e4/raw/4bc01478836ad7f1fb840f5e5a3c24ea654422f7/contacts.json"

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension ContactViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let contacts = contacts else { return 0 }
        let contactsNumber = isFavouriteContacts
            ? contacts.filter { $0.isFavourite }.count
            : contacts.count
        return min(numbersOfPerPage, contactsNumber)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        let filteredContacts = isFavouriteContacts ? contacts?.filter { $0.isFavourite } : contacts
        if let contact = filteredContacts?[indexPath.row],
            let contactCell = cell as? ContactCollectionViewCell
        {
            contactCell.imageView?.image = UIImage(named: contact.gender.imageName)
            contactCell.textLabel?.text = [contact.firstName, contact.lastName].joined(separator: " ")
            contactCell.detailTextLabel?.text = contact.email
            contactCell.favouriteButton?.addTarget(self, action: #selector(didTapFavouriteButton(_:)), for: .touchUpInside)
            if contact.isFavourite {
                let heartImage = UIImage(named: "favouriteHeart")
                let tintImage = heartImage?.withRenderingMode(.alwaysTemplate)
                contactCell.favouriteButton?.setImage(tintImage, for: .normal)
            } else {
                let heartImage = UIImage(named: "heart")
                let tintImage = heartImage?.withRenderingMode(.alwaysTemplate)
                contactCell.favouriteButton?.setImage(tintImage, for: .normal)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionViewLayout.invalidateLayout()
        switch UIDevice.current.orientation {
        case .portrait:
            return CGSize(width: view.frame.width - 40, height: (view.frame.width - 40) / 2)
        default:
            return CGSize(width: (view.frame.width - 40) / 2, height: (view.frame.width - 40) / 4)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerIdentifier, for: indexPath)
        (sectionFooter as? ContactCollectionReusableView)?.button?.addTarget(self, action: #selector(didTapShowMore(_:)), for: .touchUpInside)
        return sectionFooter
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard let contacts = contacts,
            (isFavouriteContacts ? contacts.filter { $0.isFavourite }.count : contacts.count) > numbersOfPerPage else { return CGSize(width: view.frame.size.width, height: 0) }
        return CGSize(width: view.frame.size.width, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20.0,
                            left: 20.0,
                            bottom: 20.0,
                            right: 20.0)
    }
}

// MARK: - functions

extension ContactViewController {
    
    private func configureView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(ContactCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView?.register(ContactCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerIdentifier)
        if let collectionView = collectionView {
            view.addSubview(collectionView)
        }
        if let url = URL(string: urlString) {
            request(url, success: { contacts in
                self.contacts = contacts.sorted()
            }) { error in
                
            }
        }
        segment = UISegmentedControl(items: ["All", "Favourites"])
        segment?.selectedSegmentIndex = 0
        segment?.addTarget(self, action: #selector(didSelectSegment), for: .valueChanged)
        navigationItem.titleView = segment
        collectionView?.backgroundColor = UIColor(red: 200 / 255.0, green: 226 / 355.0, blue: 243 / 255.0, alpha: 1.0)
    }
    
    @IBAction func didSelectSegment(_ sender: UISegmentedControl) {
        isFavouriteContacts = sender.selectedSegmentIndex == 1
    }
    
    @IBAction func didTapFavouriteButton(_ sender: UIButton) {
        if let cell = sender.superview?.superview as? ContactCollectionViewCell,
            let indexPath = collectionView?.indexPath(for: cell),
            let contact = (isFavouriteContacts ? contacts?.filter { $0.isFavourite } : contacts)?[indexPath.row],
            let index = contacts?[contact]
        {
            contacts?[index].isFavourite = !contact.isFavourite
            isFavouriteContacts
                ? collectionView?.deleteItems(at: [indexPath])
                : collectionView?.reloadItems(at: [indexPath])
        }
    }
    
    @IBAction func didTapShowMore(_ sender: UIButton) {
        numbersOfPerPage += 20
        collectionView?.reloadData()
        if let number = collectionView?.numberOfItems(inSection: 0) {
            collectionView?.scrollToItem(at: IndexPath(row: number - 1, section: 0), at: .bottom, animated: true)
        }
    }
    
}

