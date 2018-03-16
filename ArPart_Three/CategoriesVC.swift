//
//  CategoriesVC.swift
//  ArPart_Three
//
//  Created by Gaurav Sharma on 2/9/18.
//  Copyright © 2018 Gaurav Sharma. All rights reserved.
//

import UIKit

class CategoriesVC: UIViewController {

    @IBOutlet var tbl_Category: UITableView!
    var arrCat : [String] = Array()
    override func viewDidLoad() {
        super.viewDidLoad()
//        arrCat.append("Scenview Configuration")
//        arrCat.append("Euler Angles")
        arrCat.append("Rotations")
        arrCat.append("Draw 3D")
        arrCat.append("Hit Test")
        arrCat.append("3D Objects")
        arrCat.append("Distance Measure")
        //arrCat.append("Milo Demo")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CategoriesVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text  = arrCat[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        if indexPath.row == 1{
//            let ViewController = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
//            self.navigationController?.pushViewController(ViewController, animated: true)
//        }
        if indexPath.row == 0{
            let ViewController = storyboard?.instantiateViewController(withIdentifier: "SolarVC") as! SolarVC
            self.navigationController?.pushViewController(ViewController, animated: true)
        }
        if indexPath.row == 1{
            let ViewController = storyboard?.instantiateViewController(withIdentifier: "DrawLineVC") as! DrawLineVC
            self.navigationController?.pushViewController(ViewController, animated: true)
        }
        if indexPath.row == 2{
            let ViewController = storyboard?.instantiateViewController(withIdentifier: "HitTestVC") as! HitTestVC
            self.navigationController?.pushViewController(ViewController, animated: true)
        }
        if indexPath.row == 3{
            let ViewController = storyboard?.instantiateViewController(withIdentifier: "PlaceObjectVC") as! PlaceObjectVC
            self.navigationController?.pushViewController(ViewController, animated: true)
        }
        if indexPath.row == 4{
            let ViewController = storyboard?.instantiateViewController(withIdentifier: "DistanceMeasureVC") as! DistanceMeasureVC
            self.navigationController?.pushViewController(ViewController, animated: true)
        }
//        if indexPath.row == 7{
//            let ViewController = storyboard?.instantiateViewController(withIdentifier: "MiloDemo") as! MiloDemo
//            self.navigationController?.pushViewController(ViewController, animated: true)
//        }
        
    }
    
    
}
