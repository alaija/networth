import CoreData

extension Tag {
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<Tag> {
        let request = NSFetchRequest<Tag>(entityName: "Tag")
        request.sortDescriptors = [NSSortDescriptor(key: "name_", ascending: true)]
        request.predicate = predicate
        return request
    }

    var name: String {
        get { name_ ?? "Default tag" }
        set { name_ = newValue }
    }

    var transactions: Set<Transaction> {
        get { (transactions_ as? Set<Transaction>) ?? [] }
        set { transactions_ = newValue as NSSet }
    }
}
