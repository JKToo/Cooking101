//
//  AddRecipeViewControllerTableViewController.swift
//  Cook Book
//
//  Created by Justin on 3/15/22.
//

import UIKit

protocol AddRecipeViewControllerDelegate: AnyObject {
  func addRecipeViewControllerDidCancel(
    _ controller: AddRecipeViewController)
  func addRecipeViewController(
    _ controller: AddRecipeViewController,
    didFinishAdding item: RecipeItem
  )
    
    //Cancel and two methods for user press done
    func addRecipeViewController(
      _ controller: AddRecipeViewController,
      didFinishEditing item: RecipeItem
    )
}

class AddRecipeViewController: UITableViewController,
UITextFieldDelegate {
    var itemToEdit: RecipeItem?
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    //Outlet for the textfield input
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textLabel: UITextView!
    
    weak var delegate: AddRecipeViewControllerDelegate?
    
    override func viewDidLoad() {
    super.viewDidLoad()
      navigationItem.largeTitleDisplayMode = .never
        
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            textLabel.text = item.textDetail
            doneBarButton.isEnabled = true
          }
  }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backgroundColor = UserDefaults.standard.bool(forKey: "themeKey")
            if(backgroundColor){
                self.tableView.backgroundColor = UIColor.white
                textLabel.backgroundColor = UIColor.white
                textField.backgroundColor = UIColor.white
                textLabel.textColor = UIColor.black
                textField.textColor = UIColor.black
                self.view.backgroundColor = UIColor.white
            } else {
                self.tableView.backgroundColor = UIColor.gray
                textLabel.backgroundColor = UIColor.appColor(.dark)
                textField.backgroundColor = UIColor.appColor(.dark)
                textLabel.textColor = UIColor.white
                textField.textColor = UIColor.white
                self.view.backgroundColor = UIColor.black
            }
        
        textField.becomeFirstResponder()
        self.tableView.reloadData()
        
    }
    
    // MARK: - Actions
    @IBAction func cancel() {
        //If delegate is nil, dont send message
        delegate?.addRecipeViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let item = itemToEdit {
            item.text = textField.text!
            item.textDetail = textLabel.text!
            delegate?.addRecipeViewController(
        self,
              didFinishEditing: item)
          } else {
            let item = RecipeItem()
            item.text = textField.text!
            item.textDetail = textLabel.text!
            delegate?.addRecipeViewController(self, didFinishAdding: item)
        }
    }
    
    
    // Disables selections
    // MARK: - Table View Delegates
    override func tableView(
      _ tableView: UITableView,
      willSelectRowAt indexPath: IndexPath
    ) -> IndexPath? {
    return nil
    }
    
    
    
    // MARK: - Text Field Delegates
    func textField(
      _ textField: UITextField,
      shouldChangeCharactersIn range: NSRange,
      replacementString string: String
    ) -> Bool {
      let oldText = textField.text!
      let stringRange = Range(range, in: oldText)!
      let newText = oldText.replacingCharacters(
        in: stringRange,
        with: string)
      if newText.isEmpty {
        doneBarButton.isEnabled = false
      } else {
        doneBarButton.isEnabled = true
      }
    return true
    }
    
    //For clear button
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
      doneBarButton.isEnabled = false
    return true
    }
    
   
}
