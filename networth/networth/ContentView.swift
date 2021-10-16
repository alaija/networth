import CoreData
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(fetchRequest: Account.fetchRequest(.all))
    private var accounts: FetchedResults<Account>

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(accounts) { account in
                        HStack {
                            Image(systemName: "plus")
                            Text(account.name)
                            Spacer()
                            Text(account.currency.sign ?? account.currency.code)
                        }
                        .contextMenu(
                            ContextMenu(menuItems: {
                                Button {
                                    deleteAccount(account)
                                } label: {
                                    Label("Edit Account", systemImage: "pencil")
                                }
                                Button {
                                    deleteAccount(account)
                                } label: {
                                    Label("Delete Account", systemImage: "trash")
                                }
                            })
                        )
                    }
                    .onDelete(perform: deleteAccounts)

                }
                Spacer()
                Button(action: addAccount) {
                    Label("Add Account", systemImage: "plus")
                }.padding()
            }.navigationTitle("Accounts")
        }
    }

    private func addAccount() {
        withAnimation {
            _ = Account.defaultAccount(in: viewContext)
            saveChanges()
        }
    }

    private func deleteAccounts(offsets: IndexSet) {
        withAnimation {
            offsets.map { accounts[$0] }.forEach(deleteAccount)
        }
    }

    private func deleteAccount(_ account: Account) {
        viewContext.delete(account)
        saveChanges()
    }

    private func saveChanges() {
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(
                \.managedObjectContext,
                PersistenceController.preview.container.viewContext
            )
    }
}
