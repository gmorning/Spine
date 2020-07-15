//
//  Skeleton+Animations.swift
//  Spine
//
//  Created by Max Gribov on 20/02/2018.
//  Copyright © 2018 Max Gribov. All rights reserved.
//

import SpriteKit

extension Skeleton {

    /**
     A list of all available animation names for this skeleton `Skeleton`.
     */
    public var animationsNames: [String]? {
        get {
            guard let animations = animations else {
                return nil
            }
            
            return animations.map({ $0.name })
        }
    }
    
    /**
     Returns a 'SKAction' for animation with a specific name if possible.
     
     - parameter named: the name of the animation.
     */
    public func animation(named: String) -> SKAction? {
        
        guard let animation = animations?.first(where: { $0.name == named }) else {
            
            return nil
        }
        
        return animation.action
    }
    
    /**
     Returns a 'SKAction' that stops all animations and resets all skeleton parameters to the default state.
     */
    public func dropToDefaultsAction() -> SKAction {
        
        return SKAction.customAction(withDuration: 0, actionBlock: { (node, time) in

            if let skeleton = node as? Skeleton {
                
                skeleton.dropToDefaults()
            }
        })
    }

    public func switchToAnimation(named: String, repeating: Bool)
    {
        freezeAnimations()
        removeAction(forKey: "spine_channel")
        if var animation = animation(named: named) {
            if repeating {
                animation = SKAction.repeatForever(animation)
            }
            run(animation, withKey: "spine_channel")
        }
    }

    public func switchToAnimations(list: [(named: String, repeating: Bool)])
    {
        freezeAnimations()
        removeAction(forKey: "spine_channel")

        let actions = list.compactMap { (named: String, repeating: Bool) -> SKAction? in
            if var animation = animation(named: named) {
                if repeating {
                    animation = SKAction.repeatForever(animation)
                }
                return animation
            }
            return nil
        }
        run(SKAction.sequence(actions), withKey: "spine_channel")
    }

    public func freezeAnimations()
    {
        for child in self[".//*"] {
            if child.hasActions() {
                child.removeAllActions()
            }

            if let slot = child as? Slot {
                slot.dropToDefaults()
            }
        }
    }

}
