import {
    debugPrint;
    decodeUtf8;
} "mo:prim";

import ic_sig_verifier "../../mops/component/ic_sig_verifier";
import meet_and_greet "../../mops/component/meet_and_greet";

import Blob "mo:core/Blob";
type CanisterSigVerifierArgs = {
    message : Blob;
    signature_cbor : Blob;
    public_key_der : Blob;
};

let result1 = ic_sig_verifier.verifyCanisterSig("args, serialized");
debugPrint("Result Canister Sig with malformed arguments: " # debug_show (decodeUtf8(result1)));

let result2 = ic_sig_verifier.verifyBlsSig("args, serialized");
debugPrint("Result BLS Sig with malformed arguments: " # debug_show (decodeUtf8(result2)));

let dummyArgs : CanisterSigVerifierArgs = {
    message = Blob.fromArray([1, 2, 3]); // Placeholder for message
    signature_cbor = Blob.fromArray([3, 4, 5]); // Placeholder for signature
    public_key_der = Blob.fromArray([6, 7, 8]); // Placeholder for public key
};

let result3 = ic_sig_verifier.verifyCanisterSig(to_candid (dummyArgs));
debugPrint("Result Canister Sig with dummy arguments (single): " # debug_show (decodeUtf8(result3)));

let result3D = ic_sig_verifier.verifyCanisterSigDirect(dummyArgs.message, dummyArgs.signature_cbor, dummyArgs.public_key_der);
debugPrint("Result Canister Sig with dummy arguments (multi ): " # debug_show (decodeUtf8(result3D)));

let result4 = ic_sig_verifier.verifyBlsSig(to_candid (dummyArgs));
debugPrint("Result BLS Sig with dummy arguments: " # debug_show (decodeUtf8(result4)));

let result5 = meet_and_greet.sayHello("Bob");
debugPrint("Result Say Hello: " # debug_show (decodeUtf8(result5)));

let result6 = meet_and_greet.sayGoodbye("Alice");
debugPrint("Result Say Goodbye: " # debug_show (decodeUtf8(result6)));

let resultConcat0 = meet_and_greet.concat0();
debugPrint("Result Concat0: " # debug_show (decodeUtf8(resultConcat0)));

let resultConcat2 = meet_and_greet.concat2("Hello", "World");
debugPrint("Result Concat2: " # debug_show (decodeUtf8(resultConcat2)));

// Primitives in arguments
do {
    debugPrint("Result Prim Bool: " # debug_show (decodeUtf8(meet_and_greet.prim_bool(true))));
    debugPrint("Result Prim Bool: " # debug_show (decodeUtf8(meet_and_greet.prim_bool(false))));
    debugPrint("Result Prim Char: " # debug_show (decodeUtf8(meet_and_greet.prim_char('a'))));
    debugPrint("Result Prim U8: " # debug_show (decodeUtf8(meet_and_greet.prim_u8(123))));
    debugPrint("Result Prim U16: " # debug_show (decodeUtf8(meet_and_greet.prim_u16(12345))));
    debugPrint("Result Prim U32: " # debug_show (decodeUtf8(meet_and_greet.prim_u32(1234567890))));
    debugPrint("Result Prim U64: " # debug_show (decodeUtf8(meet_and_greet.prim_u64(12345678901234567890))));
    debugPrint("Result Prim I8: " # debug_show (decodeUtf8(meet_and_greet.prim_i8(-125))));
    debugPrint("Result Prim I16: " # debug_show (decodeUtf8(meet_and_greet.prim_i16(-12349))));
    debugPrint("Result Prim I32: " # debug_show (decodeUtf8(meet_and_greet.prim_i32(-1234567893))));
    debugPrint("Result Prim I64: " # debug_show (decodeUtf8(meet_and_greet.prim_i64(-1234567890123456789))));
};
