////
////  DataModel.swift
////  Cook Book
////
////  Created by Justin on 4/13/22.
////
//
//import Foundation
//
//class DataModel{
//    init() {
//        loadRecipeItems()
//   }
//    var items = [RecipeItem]()
//    
//    func documentsDirectory() -> URL {
//      let paths = FileManager.default.urls(
//        for: .documentDirectory,
//        in: .userDomainMask)
//      return paths[0]
//    }
//    func dataFilePath() -> URL {
//      return
//    documentsDirectory().appendingPathComponent("Recipes.plist")
//    }
//    
//    func saveRecipeItems() {
//      // 1
//      let encoder = PropertyListEncoder()
//      // 2
//      do {
//    // 3
//        let data = try encoder.encode(items)
//        // 4
//        try data.write(
//          to: dataFilePath(),
//          options: Data.WritingOptions.atomic)
//        // 5
//    } catch { // 6
//        print("Error encoding item array: \(error.localizedDescription)")
//    } }
//    
//    func loadRecipeItems() {
//      // 1
//      let path = dataFilePath()
//      // 2
//      if let data = try? Data(contentsOf: path) {
//    // 3
//        let decoder = PropertyListDecoder()
//        do {
//    // 4
//          items = try decoder.decode(
//            [RecipeItem].self,
//            from: data)
//        } catch {
//            print("Error decoding item array: \(error.localizedDescription)")
//    } }
//    }
//   
//}
