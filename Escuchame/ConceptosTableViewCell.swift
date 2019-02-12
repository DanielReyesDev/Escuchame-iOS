//
//  ConceptosTableViewCell.swift
//  Escuchame
//
//  Created by Daniel Reyes Sánchez on 10/12/16.
//  Copyright © 2016 Daniel Reyes Sánchez. All rights reserved.
//

import UIKit

class ConceptosTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    
    // Creamos una función para colocar el delegate, datasource y row number en el collectionView
    // para hacer una conformación de múltiples protocolos se sigue la estructura:
    // func wishHappyBirthday(to celebrator: Named & Aged) {}
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.reloadData()
    }
    
    

}
