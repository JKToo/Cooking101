//
//  ViewController.swift
//  Cook Book
//
//  Created by Justin on 3/12/22.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
     performSearch()
   }
    
    var hasSearched = false
    var RecipeArray = [Result]()
    var WineArray = [WineProducts]()
    var WinePairing = [WineDescription]()
    var isLoading = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.contentInset = UIEdgeInsets(top: 91, left: 0, bottom:
       0, right: 0)
        
        
        var cellNib = UINib(nibName: TableView.CellIdentifiers.searchResultCell, bundle: nil)
       tableView.register(cellNib, forCellReuseIdentifier:
        TableView.CellIdentifiers.searchResultCell)
        
        cellNib = UINib(nibName:
        TableView.CellIdentifiers.nothingFoundCell, bundle: nil)
        tableView.register(
        cellNib,
          forCellReuseIdentifier:
        TableView.CellIdentifiers.nothingFoundCell)
        
        
        cellNib = UINib(nibName:
        TableView.CellIdentifiers.loadingFoundCell, bundle: nil)
        tableView.register(
        cellNib,
          forCellReuseIdentifier:
        TableView.CellIdentifiers.loadingFoundCell)
        
        
        searchBar.becomeFirstResponder()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let backgroundColor = UserDefaults.standard.bool(forKey: "themeKey")
            if(backgroundColor){
                self.tableView.backgroundColor = UIColor.white
                searchBar.barTintColor = UIColor.appColor(.blue)
                searchBar.backgroundColor = UIColor.white
                searchBar.searchTextField.textColor = UIColor.black
                toolbar.barTintColor = UIColor.white
                segmentedControl.backgroundColor = UIColor.gray
                textLabel.backgroundColor = UIColor.white
                textLabel.textColor = UIColor.black
                self.view.backgroundColor = UIColor.white
            } else {
                self.tableView.backgroundColor = UIColor.appColor(.dark)
                searchBar.barTintColor = UIColor.black
                searchBar.searchTextField.textColor = UIColor.white
                toolbar.barTintColor = UIColor.black
                segmentedControl.backgroundColor = UIColor.appColor(.blue)
                textLabel.backgroundColor = UIColor.black
                textLabel.textColor = UIColor.white
                self.view.backgroundColor = UIColor.appColor(.dark)
            }
        self.tableView.reloadData()
        
    }
    
    private func parseData(searchText: String, category: Int){
        switch category{
        case 0:
            isLoading = true
            textLabel.isHidden = true
            imageView.isHidden = true
            tableView.isHidden = false
                WineArray.removeAll()
                RecipeArray.removeAll()
            let encodedText = searchText.addingPercentEncoding(
                withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            let headers = [
                "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
                "X-RapidAPI-Key": "{Personal Key}"
            ]
            
            //Set &number=10 to avoid any delay in search but that can be removed and
            //Data will be displayed dynamically based on number of returns
            let request = NSMutableURLRequest(url: NSURL(string:"https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/search?query=\(encodedText)&number=10")! as URL,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers

            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest) { [self] (data, response, error) in

                if error == nil && data != nil {
                    let decoder = JSONDecoder()
                    do{
                        let resultData = try decoder.decode(ResultData.self, from: data!)
//                        print(resultData)
                        self.RecipeArray = resultData.results
                    } catch {
                       
                    }

                }
                self.isLoading = false
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            dataTask.resume()
        
        
        case 1:
            isLoading = true
            textLabel.text = ""
            WineArray.removeAll()
            RecipeArray.removeAll()
            let encodedText = searchText.addingPercentEncoding(
                withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            let headers = [
                "X-RapidAPI-Host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com",
                "X-RapidAPI-Key": "{Personal Key}"
            ]
            let request = NSMutableURLRequest(url: NSURL(string:"https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/food/wine/pairing?food=\(encodedText)")! as URL,
                                                    cachePolicy: .useProtocolCachePolicy,
                                                timeoutInterval: 10.0)
            request.httpMethod = "GET"
            request.allHTTPHeaderFields = headers

            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest) { [self] (data, response, error) in

                if error == nil && data != nil {
                    let decoder = JSONDecoder()
                    do{
                        let resultData = try decoder.decode(WineData.self, from: data!)
                        self.WineArray = resultData.wineProduct
                    } catch {
                       print("Error reading JSON")
                    }

                }
                self.isLoading = false
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            dataTask.resume()
        default:
            break
        }
       
    }
    
    
    struct TableView {
      struct CellIdentifiers {
        static let searchResultCell = "SearchResultCell"
          static let nothingFoundCell = "NothingFoundCell"
          static let loadingFoundCell = "LoadingCell"
      }
    }

    
    
    func performStoreRequest(with url: URL) -> String? {
      do {
       return try String(contentsOf: url, encoding: .utf8)
      } catch {
       print("Download Error: \(error.localizedDescription)")
    return nil
    } }
}

// MARK: - Search Bar Delegate
extension SearchViewController: UISearchBarDelegate {
    func performSearch() {
      if !searchBar.text!.isEmpty {
        searchBar.resignFirstResponder()
        hasSearched = true
          parseData(searchText: searchBar.text!, category : segmentedControl.selectedSegmentIndex)

        tableView.reloadData()
          
      }
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
     return .topAttached
   }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isLoading = true
        imageView.isHidden = true
     performSearch()
    }
}



// MARK: - Table View Delegate
extension SearchViewController: UITableViewDelegate,
UITableViewDataSource {
    
    func tableView(
      _ tableView: UITableView,
      numberOfRowsInSection section: Int
    ) -> Int {
        if isLoading{
            return 1
        }
     else if !hasSearched {
        return 0
      } else if RecipeArray.count == 0 {
        return 1
      } else {
        return RecipeArray.count
      }
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoading {
           let cell = tableView.dequeueReusableCell(
             withIdentifier: TableView.CellIdentifiers.loadingFoundCell,
             for: indexPath)
            let spinner = cell.viewWithTag(100) as!
            UIActivityIndicatorView
                spinner.startAnimating()
            return cell
        }
        if RecipeArray.count != 0 {
            tableView.isHidden = false
            imageView.isHidden = true
            textLabel.isHidden = true
        let cell = tableView.dequeueReusableCell(withIdentifier:
          TableView.CellIdentifiers.searchResultCell,
          for: indexPath) as! SearchResultCell
            let backgroundColor = UserDefaults.standard.bool(forKey: "themeKey")
                if(backgroundColor){
                    cell.backgroundColor = UIColor.white
                    cell.nameLabel.textColor = UIColor.black
                    cell.recipeTimeLabel.textColor = UIColor.black
                } else {
                    cell.backgroundColor = UIColor.black
                    self.tableView.separatorColor = UIColor.gray
                    cell.nameLabel.textColor = UIColor.white
                    cell.recipeTimeLabel.textColor = UIColor.white
                }
            
          
        let searchResult = RecipeArray[indexPath.row]
        cell.nameLabel.text = searchResult.title
        cell.recipeTimeLabel.text = "Cook time: " + String(searchResult.minutes) + " minutes"
          
            
        // https://stackoverflow.com/questions/39813497/swift-3-display-image-from-url
          let url = URL(string: "https://spoonacular.com/recipeImages/" + searchResult.thumbnail)
          let data = try? Data(contentsOf: url!)

          if let imageData = data {
              cell.recipeImageView.image = UIImage(data: imageData)
          }
        return cell
    }
        
        else if WineArray.count != 0 {
            let searchResult = WineArray[indexPath.row]
          
            imageView.isHidden = false
            textLabel.isHidden = false
            
            let cell = tableView.dequeueReusableCell(withIdentifier:
              TableView.CellIdentifiers.searchResultCell,
              for: indexPath) as! SearchResultCell
            let backgroundColor = UserDefaults.standard.bool(forKey: "themeKey")
                if(backgroundColor){
                    imageView.backgroundColor = UIColor.white
                    textLabel.backgroundColor = UIColor.white
                } else {
                    self.view.backgroundColor = UIColor.black
                    imageView.backgroundColor = UIColor.black
                    textLabel.backgroundColor = UIColor.black
                }
            
            tableView.isHidden = true
            textLabel.text = String(searchResult.description) + "\n\nAverage Rating: " + String(searchResult.rating) + "\n\nRating Count: " + String(searchResult.ratingCount)
              let url = URL(string: searchResult.thumbnail)
              let data = try? Data(contentsOf: url!)

              if let imageData = data {
                  imageView.image = UIImage(data: imageData)
              }
            return cell
        }
        else {
            tableView.isHidden = false
        return tableView.dequeueReusableCell(
          withIdentifier: TableView.CellIdentifiers.nothingFoundCell,
          for: indexPath)
      }
    }
    
    
    func tableView(
      _ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath
    ){
        if RecipeArray.count != 0{
            let searchResult = RecipeArray[indexPath.row]
            
            //https://stackoverflow.com/questions/40690291/how-to-open-a-url-via-uitableviewcell
            let urlString = searchResult.sourceURL
            if let url = URL(string: urlString)
            {
                UIApplication.shared.openURL(url)
            }
            tableView.deselectRow(at: indexPath, animated: true)
        } else if RecipeArray.count == 0 {
            let searchResult2 = WineArray[indexPath.row]
            let urlString2 = searchResult2.link
            if let url2 = URL(string: urlString2)
            {
                UIApplication.shared.openURL(url2)
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }
      }
    
      func tableView(
        _ tableView: UITableView,
        willSelectRowAt indexPath: IndexPath
      ) -> IndexPath? {
          if (RecipeArray.count == 0 && WineArray.count == 0) || isLoading {
          return nil
        }
          else {
          return indexPath
        }
      }
}

