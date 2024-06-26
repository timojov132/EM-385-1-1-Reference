import Foundation
import RealmSwift

class Sec21Formatted: Object {
    @Persisted var section: String?
    @Persisted var topic: String?
    @Persisted var refOne: String?
    @Persisted var refTwo: String?
    @Persisted var refThree: String?
    @Persisted var content: String?
    @Persisted var highlight: String?
    @Persisted var bookmark: String?
}
