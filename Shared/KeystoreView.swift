//
//  KeystoreView.swift
//  AnyWeb3
//
//  Created by Rinat Enikeev on 03.12.2022.
//

import SwiftUI

struct KeystoreView: View {
    @StateObject var keystores = KeystoresObject()

    var body: some View {
        List {
            ForEach(keystores.addresses) { address in
                Text(address.address)
            }
        }
    }
}

struct KeystoresView_Previews: PreviewProvider {
    static var previews: some View {
        KeystoreView(keystores: KeystoresObject())
    }
}
