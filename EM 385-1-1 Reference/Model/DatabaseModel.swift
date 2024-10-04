
import Foundation
import RealmSwift

class Reference: Object {
    @Persisted var chapter: String
    @Persisted var section: String
    @Persisted var topic: String?
    @Persisted var refOne: String?
    @Persisted var refTwo: String?
    @Persisted var refThree: String?
    @Persisted var content: String
    @Persisted var highlight: List<Int?>
    @Persisted var bookmark: Bool
    
}
class Zeference: Object {
    @Persisted var chapter: String
    @Persisted var section: String
    @Persisted var topic: String?
    @Persisted var refOne: String?
    @Persisted var refTwo: String?
    @Persisted var refThree: String?
    @Persisted var content: String
    @Persisted var highlight: List<Int?>
    @Persisted var bookmark: Bool?
    
}
