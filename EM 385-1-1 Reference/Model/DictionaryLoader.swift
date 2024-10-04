
import Foundation

public class DictionaryLoader {
    
    @Published var dict: [DictionaryData]?
    
    init(){
        loadDefinitions()
        sortDefinitions()
    }
    
    func loadDefinitions() {
        if let url = Bundle.main.url(forResource: "Definitions", withExtension: "json") {
            
            do {
                let jsonData = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                self.dict = try decoder.decode([DictionaryData].self, from: jsonData)
            } catch {
                print(error)
            }
        } else {
                print("Fail")
        }
    }
    func sortDefinitions() {
        dict = dict!.sorted(by: {($0.Word.lowercased() < $1.Word.lowercased())})
    }
}
