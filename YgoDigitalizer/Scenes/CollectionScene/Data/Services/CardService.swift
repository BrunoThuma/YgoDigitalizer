import Foundation


final class CardService {
    func fetchCards(id: String, completion: @escaping (Data) -> Void ) {
        let url = URL(string: "https://db.ygoprodeck.com/api/v7/cardinfo.php?id=\(id)")!
        let request = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            completion(data)
        }
        request.resume()
    }
}
