import {
    debugPrint;
    decodeUtf8;
} "mo:prim";

import ic_sig_verifier "../wit/ic_sig_verifier"

let result = ic_sig_verifier.verifyCanisterSig("args, serialized");

debugPrint("Result: " # debug_show (decodeUtf8(result))); // Print return value
