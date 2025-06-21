import Foundation
import Security

/// A class responsible for securely managing user tokens in MusadoraKit.
public final class TokenManager: Sendable {
    /// Shared instance of the TokenManager
    public static let shared = TokenManager()
    
    private let tokenKey = "com.musadorakit.userToken"
    private let keychainService = "com.musadorakit.keychain"
    
    private init() {}
    
    /// Saves the user token securely in the Keychain
    /// - Parameter token: The token to be saved
    /// - Throws: KeychainError if saving fails
    public func saveToken(_ token: String) throws {
        guard let data = token.data(using: .utf8) else {
            throw KeychainError.encodingError
        }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: tokenKey,
            kSecValueData as String: data
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecDuplicateItem {
            // Item already exists, update it
            let updateQuery: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: keychainService,
                kSecAttrAccount as String: tokenKey
            ]
            
            let attributes: [String: Any] = [
                kSecValueData as String: data
            ]
            
            let updateStatus = SecItemUpdate(updateQuery as CFDictionary, attributes as CFDictionary)
            guard updateStatus == errSecSuccess else {
                throw KeychainError.unhandledError(status: updateStatus)
            }
        } else if status != errSecSuccess {
            throw KeychainError.unhandledError(status: status)
        }
    }
    
    /// Retrieves the user token from the Keychain
    /// - Returns: The stored token, if any
    /// - Throws: KeychainError if retrieval fails
    public func getToken() throws -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: tokenKey,
            kSecReturnData as String: true
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        if status == errSecItemNotFound {
            return nil
        }
        
        guard status == errSecSuccess,
              let data = result as? Data,
              let token = String(data: data, encoding: .utf8) else {
            throw KeychainError.unhandledError(status: status)
        }
        
        return token
    }
    
    /// Removes the user token from the Keychain
    /// - Throws: KeychainError if deletion fails
    public func deleteToken() throws {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: keychainService,
            kSecAttrAccount as String: tokenKey
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            throw KeychainError.unhandledError(status: status)
        }
    }
    
    /// Checks if a token exists and is valid
    /// - Returns: True if a valid token exists, false otherwise
    public func hasValidToken() -> Bool {
        guard let token = try? getToken() else {
            return false
        }
        return !token.isEmpty
    }
}

/// Errors that can occur during Keychain operations
public enum KeychainError: LocalizedError {
    case unhandledError(status: OSStatus)
    case encodingError
    
    public var errorDescription: String? {
        switch self {
        case .unhandledError(let status):
            return "Keychain operation failed with status: \(status)"
        case .encodingError:
            return "Failed to encode token data"
        }
    }
}