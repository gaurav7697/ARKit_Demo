//
//  ViewController.swift
//  ArPart_Three
//
//  Created by Gaurav Sharma on 1/9/18.
//  Copyright © 2018 Gaurav Sharma. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController , ARSCNViewDelegate{

    @IBOutlet var myScenView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
      self.myScenView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
//        self.myScenView.session.run(configuration)
        self.configuration.planeDetection = .horizontal
        self.myScenView.session.run(configuration)
//        self.myScenView.delegate = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    
    func addNode(){
        let node = SCNNode()
        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        node.eulerAngles = SCNVector3(Float(180.degreeToRadians), 0, 0)
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        node.position = SCNVector3(0,0.1,-0.1)
        self.myScenView.scene.rootNode.addChildNode(node)
    }
    
    func makeHouse(){
        let doorNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.06))
        doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
        let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        let node = SCNNode()
        // node.geometry = SCNCapsule(capRadius: 0.1, height: 0.3)
        //        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.03)
        //        let path = UIBezierPath()
        //        path.move(to: CGPoint(x: 0, y: 0))
        //        path.addLine(to: CGPoint(x:0, y: 0.2))
        //        path.addLine(to: CGPoint(x: 0.2, y:0.3))
        //        path.addLine(to: CGPoint(x: 0.4, y: 0.2))
        //        path.addLine(to: CGPoint(x: 0.4, y: 0))
        //        let shape = SCNShape(path: path, extrusionDepth: 0.2)
        //        node.geometry = shape
        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        node.position = SCNVector3(0.2,0.3,-0.2)
        boxNode.position = SCNVector3(0, -0.05, 0)
        doorNode.position = SCNVector3(0,-0.02,0.053)
        self.myScenView.scene.rootNode.addChildNode(node)
        node.addChildNode(boxNode)
        boxNode.addChildNode(doorNode)
        //   self.sceneView.scene.rootNode.addChildNode(cylinderNode)
    }
    
    
    
    func restartSession() {
            self.myScenView.session.pause()
        
    
          self.myScenView.scene.rootNode.enumerateChildNodes { (node, _) in
                node.removeFromParentNode()
            }
            self.myScenView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
    }

    @IBAction func nodeAdd_Action(_ sender: Any) {
        addNode()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func restartSession_Action(_ sender: Any) {
        restartSession()
    }
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else {return}
        print("new  surface detected, new ARPlaneAnchor added")
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else {return}
        print("updating floor's anchor...")
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor else {return}
        print("remove floor's anchor...")
    }
}
extension Int{
    var degreeToRadians: Double {
        return Double(self) * .pi/180
}
}
