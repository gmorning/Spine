//
//  Color.swift
//  Spine
//
//  Created by Max Gribov on 17/02/2018.
//  Copyright © 2018 Max Gribov. All rights reserved.
//

import SpriteKit

func createColor(with model: ColorModel) -> SKColor {

    return SKColor(red: model.red, green: model.green, blue: model.blue, alpha: model.alpha)
}
