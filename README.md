# AnyWeb3

```console
git clone git@github.com:rinat-enikeev/AnyWeb3.git
cd AnyWeb3/
xcodegen
cd truffle/
npm install
npm run mnemonics
ganache-cli -m "$(cat mnemonics)" -v
```

Open `AnyWeb3.xcodeproj`, add scheme, run and tap on "Use demo wallet". 

Expected: you can see your balance and address from ganache. 
