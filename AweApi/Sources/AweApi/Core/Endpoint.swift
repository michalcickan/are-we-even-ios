import Foundation


enum Endpoint {
    case user
    case userAddress
    case usersSearch
    case login(LoginType?)
    case token
    case logout
    case register
    case groupExpense(groupId: Int)
    case groupInvitations
    case groupInviteUser(groupId: Int, inviteeId: Int)
    case groupsInvitationsResolution(invitationId: Int, InvitationResolution)
    case expense(expenseId: Int)
    case groupExpenses(groupId: Int)
    case groupWithId(groupId: Int)
    case groupDefault(groupId: Int?)
    case group
    case groups

    var path: String {
        switch self {
        case .user:
            return "user"
        case .userAddress:
            return "user/address"
        case .usersSearch:
            return "users/search"
        case let .login(loginType):
            return ["login", loginType?.rawValue]
                .compactMap { $0 }
                .joined(separator: "/")
        case .token:
            return "token"
        case .logout:
            return "logout"
        case .register:
            return "register"
        case let .groupExpense(groupId):
            return "groups/\(groupId)/expense"
        case .groupInvitations:
            return "groups/invitations"
        case let .groupInviteUser(groupId, inviteeId):
            return "groups/\(groupId)/inviteUser/\(inviteeId)"
        case let .groupsInvitationsResolution(invitationId, resolution):
            return "groups/invitations/\(invitationId)/\(resolution.rawValue)"
        case let .expense(expenseId):
            return "groups/expenses/\(expenseId)"
        case .groupExpenses(let groupId):
            return "groups/\(groupId)/expenses"
        case let .groupWithId(groupId):
            return "groups/\(groupId)"
        case let .groupDefault(groupId):
            return ["groups", groupId.map(String.init), "default"]
                .compactMap { $0 }
                .joined(separator: "/")
        case .group:
            return "group"
        case .groups:
            return "groups"
        }
    }
    
    func fullUrl(with baseUrl: String) -> String {
        "\(baseUrl)/\(path)"
    }
}
