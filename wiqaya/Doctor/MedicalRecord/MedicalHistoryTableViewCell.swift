//
//  MedicalHistoryTableViewCell.swift
//  wiqaya
//
//  Created by AhmadALshafei on 11/30/25.
//

import UIKit

class MedicalHistoryTableViewCell: UITableViewCell,
                                   UICollectionViewDelegate,
                                   UICollectionViewDataSource,
                                   UICollectionViewDelegateFlowLayout {
    

    @IBOutlet weak var greenCircleImage: UIImageView!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var lblMedicalStatus: UILabel!
    
    @IBOutlet weak var pharmaceutical1Collection: UICollectionView!
    
    
    @IBOutlet weak var moreView: UIView!
    
    
    @IBOutlet weak var pharmaceutical2Collection: UICollectionView!
    
    @IBOutlet weak var proceduresCollection: UICollectionView!
    
    var pharmaceutical1 = [String]()
    var pharmaceutical2 = [String]()
    var procedures = [String]()

    override func awakeFromNib() {
        super.awakeFromNib()
        pharmaceutical1Collection.delegate = self
        pharmaceutical1Collection.dataSource = self
        
        pharmaceutical2Collection.delegate = self
        pharmaceutical2Collection.dataSource = self
        
        proceduresCollection.delegate = self
        proceduresCollection.dataSource = self
        
        greenCircleImage.layer.cornerRadius = greenCircleImage.bounds.width / 2
        greenCircleImage.clipsToBounds = true

        
        moreView.layer.cornerRadius = 5
        moreView.layer.masksToBounds = true
        moreView.layer.borderWidth = 1
        moreView.layer.borderColor = UIColor(hex: "E2E8F0").cgColor
        selectionStyle = .none
        
        if let flow = proceduresCollection.collectionViewLayout as? UICollectionViewFlowLayout {
            flow.estimatedItemSize = CGSize(width: proceduresCollection.frame.width - 8, height: 44)
            flow.minimumLineSpacing = 8
            flow.minimumInteritemSpacing = 8
            flow.sectionInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        }

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == pharmaceutical1Collection {
            return pharmaceutical1.count
        } else if collectionView == pharmaceutical2Collection {
            return pharmaceutical2.count

        } else {
            return procedures.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == pharmaceutical1Collection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pharmaceutical1Cell", for: indexPath) as! Pharmaceutical1CollectionViewCell
            cell.lblMedicine.text = pharmaceutical1[indexPath.row]
            return cell
            
        } else if collectionView == pharmaceutical2Collection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pharmaceutical2Cell", for: indexPath) as! Pharmaceutical2CollectionViewCell
            cell.lblMedicine.text = pharmaceutical2[indexPath.row]
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "proceduresCell", for: indexPath) as! ProceduresCollectionViewCell
            cell.lblProcedure.text = procedures[indexPath.row]
            return cell
        }
        
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//        if collectionView == proceduresCollection {
//            return CGSize(width: collectionView.frame.width - 8, height: 40)
//        } else {
//            return CGSize(width: collectionView.frame.width - 8, height: 40)
//        }
//    }

    func reloadCollections() {
        // تأكد reload على main thread ثم invalide layout
        DispatchQueue.main.async {
            self.pharmaceutical1Collection.reloadData()
            self.pharmaceutical1Collection.collectionViewLayout.invalidateLayout()
            self.pharmaceutical2Collection.reloadData()
            self.pharmaceutical2Collection.collectionViewLayout.invalidateLayout()
            self.proceduresCollection.reloadData()
            self.proceduresCollection.collectionViewLayout.invalidateLayout()
            self.layoutIfNeeded()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.bounds.width - 8
        // إرتفاع ثابت مناسب للنص الواحد. لو النص طويل ممكن تعدّل 44 إلى 60 أو احسبه ديناميكياً.
        return CGSize(width: width, height: 44)
    }

}
