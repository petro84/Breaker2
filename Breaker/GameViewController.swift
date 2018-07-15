//
//  GameViewController.swift
//  Breaker
//
//  Created by Larry Petroski on 7/15/18.
//  Copyright © 2018 Larry Petroski. All rights reserved.
//

import UIKit
import SceneKit

class GameViewController: UIViewController {

    var scnView: SCNView!
    var scnScene: SCNScene!
    var horizontalCamera: SCNNode!
    var verticalCamera: SCNNode!
    
    var game = GameHelper.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScene()
        setupNodes()
        setupSounds()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }
    
    func setupScene()
    {
        scnView = self.view as! SCNView
        scnView.delegate = self
        
        scnScene = SCNScene(named: "Breaker.scnassets/Scenes/Game.scn")
        scnView.scene = scnScene
    }
    
    func setupNodes() {
        horizontalCamera = scnScene.rootNode.childNode(withName: "HorizontalCamera", recursively: true)!
        verticalCamera = scnScene.rootNode.childNode(withName: "VerticalCamera", recursively: true)!
        
        scnScene.rootNode.addChildNode(game.hudNode)
    }
    
    func setupSounds() {
    }
    
    override var shouldAutorotate: Bool { return true }
    override var prefersStatusBarHidden: Bool { return true }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        let deviceOrientation = UIDevice.current.orientation
        
        switch (deviceOrientation) {
        case .portrait:
            scnView.pointOfView = verticalCamera
        default:
            scnView.pointOfView = horizontalCamera
        }
    }
}

extension GameViewController: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        game.updateHUD()
    }
}
