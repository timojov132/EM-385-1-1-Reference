import UIKit

class DefinitionViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let dictionary = DictionaryLoader().dict
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension DefinitionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print(dictionary![indexPath.row].Word)
    }
}

extension DefinitionViewController: UITableViewDataSource {
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictionary!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DefItemCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        content.text = dictionary![indexPath.row].Word
        content.secondaryText = dictionary![indexPath.row].Definition
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print([indexPath.row])
    }
}
