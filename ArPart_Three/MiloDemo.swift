//
//  MiloDemo.swift
//  ArPart_Three
//
//  Created by Gaurav Sharma on 3/16/18.
//  Copyright © 2018 Gaurav Sharma. All rights reserved.
//

import UIKit
import ARKit

class MiloDemo: UIViewController, UITableViewDataSource, UITableViewDelegate,ARSCNViewDelegate {
    
    

    @IBOutlet var tbl_milo: UITableView!
    @IBOutlet var myScenView: ARSCNView!
    
    @IBOutlet var constraint_tbltrailing: NSLayoutConstraint!
    @IBOutlet var btn_arrow: UIButton!
    var itemsArr = ["Add Base", "Add First Point", "Add Second Point"]
    let configurarion = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myScenView.session.run(configurarion)
        self.myScenView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.myScenView.delegate = self
        self.registerGestureRecognizers()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerGestureRecognizers() {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
        self.myScenView.addGestureRecognizer(pinchGestureRecognizer)
        self.myScenView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func pinch(sender: UIPinchGestureRecognizer) {
        let sceneView = sender.view as! ARSCNView
        let pinchLocation = sender.location(in: sceneView)
        let hitTest = sceneView.hitTest(pinchLocation)
        
        if !hitTest.isEmpty {
            
            let results = hitTest.first!
            let node = results.node
            let pinchAction = SCNAction.scale(by: sender.scale, duration: 0)
            print(sender.scale)
            node.runAction(pinchAction)
            sender.scale = 1.0
        }
        
        
    }
    
    @objc func tapped(sender: UITapGestureRecognizer) {
        let sceneView = sender.view as! ARSCNView
        let tapLocation = sender.location(in: sceneView)
        let hitTest = sceneView.hitTest(tapLocation, types: .featurePoint)
        if !hitTest.isEmpty {
            self.addItem(hitTestResult: hitTest.first!)
        }
    }
    
    func addItem(hitTestResult: ARHitTestResult) {
        let node = SCNNode(geometry: SCNBox(width: 0.06, height: 0.1, length: 0.02, chamferRadius: 0.0))
        node.geometry?.firstMaterial?.diffuse.contents = #imageLiteral(resourceName: "miloBase")
        let transform = hitTestResult.worldTransform
        let thirdColumn = transform.columns.3
        node.position = SCNVector3(thirdColumn.x, thirdColumn.y, thirdColumn.z)
        self.myScenView.scene.rootNode.addChildNode(node)
        addRangeNode(position: node.position)
      
    }
    @IBAction func backBtn_Action(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func arrowBtn_Action(_ sender: Any) {
        if constraint_tbltrailing.constant != 0{
            UIView.animate(withDuration: 0.5,
                           delay: 0.5,
                           options: UIViewAnimationOptions.curveEaseIn,
                           animations: { () -> Void in
                            self.constraint_tbltrailing.constant = 0
                            self.btn_arrow.setImage(#imageLiteral(resourceName: "arrowRight"), for: .normal)


                            self.view?.layoutIfNeeded()
            }, completion: { (finished) -> Void in
                // ....
            })
            
        }
        else{
            UIView.animate(withDuration: 0.5,
                           delay: 0.5,
                           options: UIViewAnimationOptions.curveEaseIn,
                           animations: { () -> Void in
                            self.btn_arrow.setImage(#imageLiteral(resourceName: "arrowLeft"), for: .normal)

                            self.constraint_tbltrailing.constant = 150
                            
                            self.view?.layoutIfNeeded()
            }, completion: { (finished) -> Void in
                // ....
            })
           

        }
        
        
    }
    
    func addRangeNode(position: SCNVector3){
        let node = SCNNode(geometry: SCNTorus(ringRadius: 10.0, pipeRadius: 0.0))
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        node.position = position
        self.myScenView.scene.rootNode.addChildNode(node)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return itemsArr.count
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARPlaneAnchor else {return}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMilo", for: indexPath)
        cell.textLabel?.text = itemsArr[indexPath.row]
        return cell
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
