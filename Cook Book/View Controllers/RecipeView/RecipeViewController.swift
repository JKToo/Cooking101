//
//  RecipeViewController.swift
//  Cook Book
//
//  Created by Justin on 3/12/22.
//

import Foundation
import UIKit

class RecipeViewController: UITableViewController, AddRecipeViewControllerDelegate, UINavigationControllerDelegate {
    
   var items = [RecipeItem] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.delegate = self
        loadRecipeItems()
//        print("Documents folder is \(documentsDirectory())")
//         print("Data file path is \(dataFilePath())")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backgroundColor = UserDefaults.standard.bool(forKey: "themeKey")
            if(backgroundColor){
                self.tableView.backgroundColor = UIColor.white
                
            } else {
                self.tableView.backgroundColor = UIColor.appColor(.dark)
            }
        self.tableView.reloadData()
        
    }
    
    // MARK: - Add Item ViewController Delegates
    //Protocol methods
    func addRecipeViewControllerDidCancel(
      _ controller: AddRecipeViewController
    ){
      navigationController?.popViewController(animated: true)
    }
    
    func addRecipeViewController(
      _ controller: AddRecipeViewController,
      didFinishAdding item: RecipeItem
    ){
        let newRowIndex = items.count
        items.append(item)
          let indexPath = IndexPath(row: newRowIndex, section: 0)
          let indexPaths = [indexPath]
          tableView.insertRows(at: indexPaths, with: .automatic)
      navigationController?.popViewController(animated: true)
        saveRecipeItems()
    }
    
    func addRecipeViewController(
      _ controller: AddRecipeViewController,
      didFinishEditing item: RecipeItem
    ){
        if let index = items.firstIndex(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
              configureText(for: cell, with: item)
            }
        }
      navigationController?.popViewController(animated: true)
        saveRecipeItems()
    }
    
    override func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ){
       
      tableView.deselectRow(at: indexPath, animated: true)
        saveRecipeItems()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int
    ) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(
        withIdentifier: "RecipeItem", for: indexPath)
        
          let item = items[indexPath.row]
          let label = cell.viewWithTag(1000) as! UILabel
          label.text = item.text
        
        let backgroundColor = UserDefaults.standard.bool(forKey: "themeKey")
            if(backgroundColor){
                cell.backgroundColor = UIColor.white
                label.textColor = UIColor.black
            } else {
                cell.backgroundColor = UIColor.black
                
                self.tableView.separatorColor = UIColor.gray
                label.textColor = UIColor.white
                
            }
      return cell
    }
    
   

    //Delete swipe
    override func tableView(
      _ tableView: UITableView,
      commit editingStyle: UITableViewCell.EditingStyle,
      forRowAt indexPath: IndexPath
    ){

      items.remove(at: indexPath.row)

      let indexPaths = [indexPath]
      tableView.deleteRows(at: indexPaths, with: .automatic)
        
        saveRecipeItems()
    }
    
    
    // MARK: - Navigation
    override func prepare(
      for segue: UIStoryboardSegue,
      sender: Any?
    ){

      if segue.identifier == "AddRecipe" {
  
        let controller = segue.destination as! AddRecipeViewController

        controller.delegate = self
      } else if segue.identifier == "EditItem" {
          let controller = segue.destination as! AddRecipeViewController
          controller.delegate = self
          if let indexPath = tableView.indexPath(
            for: sender as! UITableViewCell) {
            controller.itemToEdit = items[indexPath.row]
          }
      }
    }
    

    func documentsDirectory() -> URL {
      let paths = FileManager.default.urls(
        for: .documentDirectory,
        in: .userDomainMask)
      return paths[0]
    }
    func dataFilePath() -> URL {
      return
    documentsDirectory().appendingPathComponent("Recipes.plist")
    }

    func saveRecipeItems() {
   
      let encoder = PropertyListEncoder()
  
      do {

        let data = try encoder.encode(items)
   
        try data.write(
          to: dataFilePath(),
          options: Data.WritingOptions.atomic)
        
    } catch {
        print("Error encoding item array: \(error.localizedDescription)")
    } }

    func loadRecipeItems() {
   
      let path = dataFilePath()
   
      if let data = try? Data(contentsOf: path) {
   
        let decoder = PropertyListDecoder()
        do {
 
          items = try decoder.decode(
            [RecipeItem].self,
            from: data)
        } catch {
            print("Error decoding item array: \(error.localizedDescription)")
    } }
    }
    
    func configureText(
      for cell: UITableViewCell,
      with item: RecipeItem
    ){
    let label = cell.viewWithTag(1000) as! UILabel
      label.text = item.text
    }
    
    func addItemViewController(
      _ controller: RecipeViewController,
      didFinishEditing item: RecipeItem
    ){
    if let index = items.firstIndex(of: item) {
        let indexPath = IndexPath(row: index, section: 0)
        if let cell = tableView.cellForRow(at: indexPath) {
          configureText(for: cell, with: item)
        }
    }
      navigationController?.popViewController(animated: true)
    }
    
    
  
}
