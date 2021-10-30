import CoreData

extension Payee {
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<Payee> {
        let request = NSFetchRequest<Payee>(entityName: "Payee")
        request.sortDescriptors = [NSSortDescriptor(key: "name_", ascending: true)]
        request.predicate = predicate
        return request
    }

    var name: String {
        get { name_ ?? "Default payee" }
        set { name_ = newValue }
    }

    var transactions: Set<Transaction> {
        get { (transactions_ as? Set<Transaction>) ?? [] }
        set { transactions_ = newValue as NSSet }
    }
}
