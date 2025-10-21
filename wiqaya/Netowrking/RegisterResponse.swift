//
//  RegisterResponse.swift
//  wiqaya
//
//  Created by AhmadALshafei on 10/20/25.
//
import Foundation

// MARK: - Register Response
struct RegisterResponse: Codable {
    let message: String
    let data: UserData
}

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
    let tokens: Tokens
    let date: LoginDate
}

struct Tokens: Codable {
    let accessToken: String
    let refreshToken: String
}

struct LoginDate: Codable {
    let payload: LoginPayload
}

struct LoginPayload: Codable {
    let id: String
    let name: String
    let username: String?
    let email: String
    let role: String
}

// MARK: - Password Reset / Verify Responses

/// ✅ عند طلب كود إعادة التعيين (request-password-reset)
struct PasswordResetRequestResponse: Codable {
    let message: String
}

/// ✅ عند التحقق من الكود (verify-reset-code)
struct VerifyCodeResponse: Codable {
    let resetToken: String?
    let message: String?
}

/// ✅ عند إعادة تعيين كلمة المرور فعليًا (reset-password)
struct ResetPasswordResponse: Codable {
    let message: String
}
