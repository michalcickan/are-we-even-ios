import SwiftUI
import GoogleSignInSwift

struct SocialButton: View {
    enum Kind {
        case google, email
    }
    
    let kind: Kind
    let action: () -> Void
    
    var body: some View {
        Group {
            switch kind {
            case .google:
                GoogleSignInButton(action: action)
            default:
                let info = kind.info
                HStack {
                    Button(
                        action: action,
                        label: {
                            HStack {
                                info.image
                                    .tint(info.foregroundColor)
                                    .padding(.trailing, 8)
                                Text(info.title)
                                    .bold()
                                    .foregroundColor(info.foregroundColor)
                                    .font(.system(size: 14))
                                Spacer()
                            }
                            .padding(.horizontal, 10)
                            .padding(.vertical, 12)
                            .background(
                                RoundedRectangle(cornerRadius: 2)
                                    .fill(info.backgroundColor)
                                    .shadow(radius: 2, x: 2, y: 2)
                            )
                        }
                    )
                }
            }
        }
    }
}

fileprivate extension SocialButton.Kind {
    struct KindInfo {
       let title: String
       let image: Image
       let backgroundColor: Color
       let foregroundColor: Color
   }
    
    var info: KindInfo {
        switch self {
        case .email:
            return KindInfo(
                title: L10n.LoginButton.email,
                image: Image(systemName: "mail"),
                backgroundColor: Color(.gray),
                foregroundColor: Color(.white)
            )
        case .google:
            fatalError("Call library made by Google to follow the latest guidelines")
        }
    }
}

struct SocialButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SocialButton(kind: .email) {}
            SocialButton(kind: .google) {}
        }
    }
}
