import CoreData

extension Transaction {
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<Transaction> {
        let request = NSFetchRequest<Transaction>(entityName: "Transaction")
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp_", ascending: true)]
        request.predicate = predicate
        return request
    }

    var timestamp: Date {
        get { timestamp_ ?? Date() }
        set { timestamp_ = newValue }
    }

    var amount: Decimal {
        get { (amount_ ?? 0) as Decimal}
        set { amount_ = newValue as NSDecimalNumber }
    }

    var source: Account {
        get { source_! }
        set { source_ = newValue }
    }
}
