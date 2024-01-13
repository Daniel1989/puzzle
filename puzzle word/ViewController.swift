import UIKit


class ViewController: UIViewController {
    
    //    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sudokuCollectionView: UICollectionView!
    
    var selectedLetter: String?
    var sudokuGrid: [[String]] = []
    
    var db = Db()
    
    var words: [WordItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        tableView.dataSource = self
        //        tableView.delegate = self
        
        sudokuCollectionView.dataSource = self
        sudokuCollectionView.delegate = self
        if let flowLayout = sudokuCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.minimumLineSpacing = 0
            flowLayout.minimumInteritemSpacing = 0
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleAppDidBecomeActive), name: Notification.Name("AppDidBecomeActiveNotification"), object: nil)
        
    }
    
    //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        return words.count
    //    }
    //
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = tableView.dequeueReusableCell(withIdentifier: "WordCell", for: indexPath)
    //        cell.textLabel?.text = words[indexPath.row].word
    //        return cell
    //    }
    //
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        // Handle row selection if needed
    //        showAlertDialog(indexPath: indexPath)
    //
    //    }
    
    @objc func handleAppDidBecomeActive() {
        print("ViewController: App did become active")
        self.db.generateWord()
        words = self.db.wordItemList ?? []
        
        updateWords()
    }
    
    
    // Your custom method
    func updateWords() {
        // Shuffle the array of words every time the view is about to appear
        words.shuffle()
        let generator = CrosswordsGenerator(columns: 10, rows: 10, maxLoops: 2000, words: words.map { $0.word! })
        generator.generate()
        var startIndex = generator.displayList.first!.count - 1;
        var endIndex = 0;
        var tempArray: [[String]] = []
        for word in generator.displayList {
            let row = Array(word).enumerated().map {
                (index, element) in
                if(element != "-") {
                    startIndex = min(startIndex, index)
                    endIndex = max(endIndex, index)
                }
                return String(element)
            }
            print(row)
            let isEmptyRow = row.allSatisfy {$0 == "-"}
            if(!isEmptyRow) {
                tempArray.append(Array(row))
            }
            
        }
        print(startIndex, endIndex)
        for word in tempArray {
            let row = Array(word[startIndex..<endIndex])
            sudokuGrid.append(Array(row))
        }
        
        
        
        sudokuCollectionView.reloadData()
        
    }
    
    
    
    // Remove the observer when the view controller is deinitialized
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func showAlertDialog(indexPath: IndexPath) {
        let alertController = UIAlertController(title: words[indexPath.row].word, message: words[indexPath.row].definition, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
}
