import Foundation
import Security

class KeychainHelper {
    static let shared = KeychainHelper()

    private init() {}

    func save(_ value: String, forKey key: String) {
        if let data = value.data(using: .utf8) {
            let query = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccount: key,
                kSecValueData: data
            ] as CFDictionary

            SecItemDelete(query) // remove existing item
            SecItemAdd(query, nil)
        }
    }

    func read(forKey key: String) -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: true,
            kSecMatchLimit: kSecMatchLimitOne
        ] as CFDictionary

        var result: AnyObject?
        SecItemCopyMatching(query, &result)

        if let data = result as? Data {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}
