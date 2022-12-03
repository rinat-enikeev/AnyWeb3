#!/usr/bin/env node

const Mnemonic = require("bitcore-mnemonic");
const fs = require('fs');

var code = new Mnemonic(Mnemonic.Words.SPANISH);
try {
  fs.writeFileSync('mnemonics', code.toString());
} catch (err) {
  console.error(err);
}