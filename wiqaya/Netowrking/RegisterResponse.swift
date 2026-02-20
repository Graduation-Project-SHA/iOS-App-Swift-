import Foundation

// MARK: - Error Response
struct ErrorResponse: Codable, LocalizedError {
    var message: [String]?
    var statusCode: Int?
    
    var errorDescription: String? {
        return message?.first ?? "حدث خطأ غير متوقع"
    }
}

// MARK: - Register Response
struct RegisterResponse: Codable {
    let statusCode: Int
    let message: String
    let messageResponse: RegisterData
    let data: UserData
    let timestamp: String
    let path: String
}

struct RegisterData: Codable {
    let message: String
}

// MARK: - User Data
struct UserData: Codable {
    let id: String
    let email: String
    let username: String?
    let name: String
    let phone: String?
    let role: String
    let dob: String
    let gender: String
    let address: String
    let profileImage: String?
    let createdAt: String
    let updatedAt: String
}

// MARK: - Login Response
struct LoginResponse: Codable {
    let data: LoginTokens
}

struct LoginTokens: Codable {
    let access_token: String
    let refresh_token: String
}

// MARK: - Message Response
struct MessageResponse: Codable {
    let message: String
}
