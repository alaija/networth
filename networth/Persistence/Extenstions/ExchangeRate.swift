import CoreData

extension ExchangeRate {
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<ExchangeRate> {
        let request = NSFetchRequest<ExchangeRate>(entityName: "ExchangeRate")
        request.sortDescriptors = [NSSortDescriptor(key: "timestamp_", ascending: true)]
        request.predicate = predicate
        return request
    }

    var timestamp: Date {
        get { timestamp_ ?? Date() }
        set { timestamp_ = newValue }
    }

    var value: Decimal {
        get { (value_ ?? 0) as Decimal }
        set { value_ = newValue as NSDecimalNumber }
    }

    var source: Currency {
        get { source_! }
        set { source_ = newValue }
    }

    var target: Currency {
        get { target_! }
        set { target_ = newValue }
    }
}
