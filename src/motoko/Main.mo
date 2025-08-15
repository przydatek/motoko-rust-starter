import {
    debugPrint;
    decodeUtf8;
    trap;
} "mo:prim";

import ic_sig_verifier "../../mops/component/ic_sig_verifier";
import meet_and_greet "../../mops/component/meet_and_greet";

import Blob "mo:core/Blob";

func testBlobText(msg : Text, actual : Blob, expected : Text) {
    let ?actualText = decodeUtf8(actual) else trap("Failed to decode blob to text");
    test(msg, actualText, expected);
};
func test(msg : Text, actual : Text, expected : Text) {
    if (actual == expected) {
        debugPrint("✅ " # msg # " " # actual);
    } else {
        debugPrint("❌ " # msg);
        debugPrint("Expected: " # expected);
        debugPrint("Actual: " # actual);
    };
};

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

testBlobText("Concat0: ", meet_and_greet.concat0(), "concat0");
testBlobText("Concat2: ", meet_and_greet.concat2("Hello", "World"), "concat2: Hello World");

// Primitives in arguments and the return value
do {
    test("Prim Bool", debug_show meet_and_greet.prim_bool(true), "true");
    test("Prim Bool", debug_show meet_and_greet.prim_bool(false), "false");
    test("Prim Char", debug_show meet_and_greet.prim_char('a'), "'a'");
    test("Prim U8", debug_show meet_and_greet.prim_u8(123), "123");
    test("Prim U16", debug_show meet_and_greet.prim_u16(12345), "12_345");
    test("Prim U32", debug_show meet_and_greet.prim_u32(1234567890), "1_234_567_890");
    test("Prim U64", debug_show meet_and_greet.prim_u64(12345678901234567890), "12_345_678_901_234_567_890");
    test("Prim I8", debug_show meet_and_greet.prim_i8(-125), "-125");
    test("Prim I16", debug_show meet_and_greet.prim_i16(-12349), "-12_349");
    test("Prim I32", debug_show meet_and_greet.prim_i32(-1234567893), "-1_234_567_893");
    test("Prim I64", debug_show meet_and_greet.prim_i64(-1234567890123456789), "-1_234_567_890_123_456_789");
    test("Prim F64", debug_show meet_and_greet.prim_f64(1234567890.123457), "1234567890.123457");
    test("Prim Text", meet_and_greet.prim_text("Hello; emoji: ☃❄🌨; FooBär☃"), "Hello; emoji: ☃❄🌨; FooBär☃!");
};
