//
//  secondViewController.swift
//  PrayerApp
//
//  Created by Raneem Alkahtani on 02/09/2022.
//

import UIKit

class secondViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return chooseArray.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! SecondCollectionViewCell
           // cell.backgroundColor = .purple
            cell.layer.cornerRadius = 20
            cell.secondLabel.text = chooseArray[indexPath.row].name1
            cell.secondImage.image = chooseArray[indexPath.row].image1!
    
                return cell
    }
    
    var arrPray : [Datum] = []
    
    struct details {
        var image1: UIImage!
        var name1: String
    }
    
    let chooseArray:Array<details> = [details(image1: UIImage(systemName: "clock.circle")!, name1: "Prayer Times"),details(image1: UIImage(systemName: "hands.sparkles")!, name1: "Dhikr")]
 
    @IBOutlet weak var secondCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        secondCollectionView.delegate = self
        secondCollectionView.dataSource = self
        secondCollectionView.register(UINib(nibName: "SecondCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell1")
        
    }
 
    
    
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let columns: CGFloat = 2
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columns - 1)
        let sectionInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let adjustedWidth = collectionViewWidth - spaceBetweenCells - sectionInsets
        let width: CGFloat = floor(adjustedWidth / columns)
        let height: CGFloat = width / 1.5
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "PrayShow", sender: nil)
        case 1:
            performSegue(withIdentifier: "DhikrShow", sender: nil)
        default:
            print("")
        }
//        let cell = secondCollectionView.cellForItem(at: indexPath)
//        if cell?.tag == 0 {
//        performSegue(withIdentifier: "PrayShow", sender: nil)
//
//        }
//        else if cell?.tag == 1 {
//            performSegue(withIdentifier: "DhikrShow", sender: cell)
//        }
//        else{}
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PrayShow" {
            let viewCont = segue.destination as! PrayViewController
          //  viewCont.lab.text! = "\( arrPray[ind].date.readable)"
            //viewCont.lab.text = arrPray[indexPath.row].timings.fajr
        } else if segue.identifier == "DhikrShow" {
           let viewCont = segue.destination as! DhikrViewController

          }
    }
    
        }
