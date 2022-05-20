//
//  Storage.swift
//  Shopping
//
//  Created by Hoorad Ramezani on 21/5/2022.
//

import Foundation

class Storage{

    // MARK: Static
    static let shared: Storage = Storage()

    // MARK: Private Init
    private init(){


    }


//    func changeVisibiltyOfTileLayer(layer: DynamicTile, isVisable: Bool){
//
//        layer.isVisible = isVisable
//        for tile in self.dynamicTiles{
//
//            if tile.nameId == layer.nameId{
//
//                tile.isVisible = isVisable
//            }
//        }
//        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: self.dynamicTiles)
//        UserDefaults.standard.set(encodedData, forKey: "dynamicTiles")
//        UserDefaults.standard.synchronize()
//    }


//    var isAvoidTrafficZone: Bool{
//
//        didSet{
//
//            UserDefaults.standard.set(self.isAvoidTrafficZone, forKey: "isAvoidTrafficZone")
//            UserDefaults.standard.synchronize()
//        }
//    }
//
//    var isVisiableTrafficLayer: Bool{
//
//        didSet{
//
//            UserDefaults.standard.set(self.isVisiableTrafficLayer, forKey: "isVisiableTrafficLayer")
//            UserDefaults.standard.synchronize()
//        }
//    }
//
//    var isVisiableMetroLayer: Bool{
//
//        didSet{
//
//            UserDefaults.standard.set(self.isVisiableMetroLayer, forKey: "isVisiableMetroLayer")
//            UserDefaults.standard.synchronize()
//        }
//    }


}
