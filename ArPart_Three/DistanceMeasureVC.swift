//
//  DistanceMeasureVC.swift
//  ArPart_Three
//
//  Created by Gaurav Sharma on 3/16/18.
//  Copyright © 2018 Gaurav Sharma. All rights reserved.
//

import UIKit
import ARKit

class DistanceMeasureVC: UIViewController {

    @IBOutlet var myScnView: ARSCNView!
    var points = [SCNNode]()
    var txtNode = SCNNode()
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        myScnView.session.run(configuration)
        self.myScnView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if points.count >= 2 {
            for point in points {
                point.removeFromParentNode()
            }
            points = [SCNNode]()
        }
        
        if let touch = touches.first{
            let tapPoint = touch.location(in: myScnView)
            let tapResult = myScnView.hitTest(tapPoint, types: .featurePoint)
            if let hitResult = tapResult.first {
                
               let pointNode = SCNNode(geometry: SCNSphere(radius: 0.005))
                pointNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
                
                    pointNode.position = SCNVector3(
                        x: hitResult.worldTransform.columns.3.x,
                        y: hitResult.worldTransform.columns.3.y ,
                        z: hitResult.worldTransform.columns.3.z
                )
                    myScnView.scene.rootNode.addChildNode(pointNode)
                
                points.append(pointNode)
                if points.count >= 2{
                    calculateDistance()
                }
                }
            }
    }
    
    func calculateDistance(){
        let firstPoint = points[0]
        let secondPoint = points[1]
        let distance = sqrt(pow((secondPoint.position.x - firstPoint.position.x), 2) + pow((secondPoint.position.y - firstPoint.position.y), 2) + pow((secondPoint.position.z - firstPoint.position.z), 2))
        showText(distance: "\(abs(distance))", position: secondPoint.position)
        print(distance)
        
    }
    
    func showText(distance: String, position: SCNVector3){
       txtNode.removeFromParentNode()
       txtNode  = SCNNode(geometry: SCNText(string: distance, extrusionDepth: 1.0))
        txtNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
         txtNode.position = SCNVector3(position.x, position.y + 0.01, position.z)
        txtNode.scale = SCNVector3(0.01, 0.01, 0.01)
        
        myScnView.scene.rootNode.addChildNode(txtNode)
    }

    @IBAction func backBtn_Action(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

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
