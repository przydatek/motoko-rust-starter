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
        debugPrint("Actual  : " # actual);
    };
};

type CanisterSigVerifierArgs = {
    message : Blob;
    signature_cbor : Blob;
    public_key_der : Blob;
};

let result1 = ic_sig_verifier.verifyCanisterSigMainnet("args, serialized");
debugPrint("Result Canister Sig with malformed arguments: " # debug_show (decodeUtf8(result1)));

let result2 = ic_sig_verifier.verifyBlsSig("sig", "msg", "public key");
debugPrint("Result BLS Sig with malformed arguments: " # debug_show (result2));

let dummyArgs : CanisterSigVerifierArgs = {
    message = Blob.fromArray([1, 2, 3]); // Placeholder for message
    signature_cbor = Blob.fromArray([3, 4, 5]); // Placeholder for signature
    public_key_der = Blob.fromArray([6, 7, 8]); // Placeholder for public key
};

let result3 = ic_sig_verifier.verifyCanisterSigMainnet(to_candid (dummyArgs));
debugPrint("Result Canister Sig with dummy arguments (single): " # debug_show (decodeUtf8(result3)));

let result3D = ic_sig_verifier.verifyCanisterSig(dummyArgs.message, dummyArgs.signature_cbor, dummyArgs.public_key_der, Blob.fromArray([7,11]));
debugPrint("Result Canister Sig with dummy arguments (multi ): " # debug_show (result3D));

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
    test("Prim Text In", debug_show meet_and_greet.prim_text_in("Hello; emoji: ☃❄🌨; FooBär☃"), "+36");
    test("Prim Text Out", meet_and_greet.prim_text_out(), "Hello; emoji: ☃❄🌨; FooBär☃!");
    test("Prim Text", meet_and_greet.prim_text("Hello; emoji: ☃❄🌨; FooBär☃"), "Hello; emoji: ☃❄🌨; FooBär☃!");
    test("Vec U16", meet_and_greet.vec_u16([1, 2, 3]), "vec_u16: 1, 2, 3");
    test("Vec Text", meet_and_greet.vec_text(["Hello", "World"]), "vec_string: Hello, World");
    test("Vec U8", meet_and_greet.vec_u8([1, 2, 3, 4]), "vec_u8: 1, 2, 3, 4");
    test("Vec U32", meet_and_greet.vec_u32([10, 20, 30]), "vec_u32: 10, 20, 30");
    test("Vec I32", meet_and_greet.vec_i32([-1, -2, 3]), "vec_i32: -1, -2, 3");
    test("Vec I64", meet_and_greet.vec_i64([-1, -2, 3]), "vec_i64: -1, -2, 3"); // TODO
    test("Vec Bool", meet_and_greet.vec_bool([true, false, true]), "vec_bool: true, false, true");
    test("Vec Text Nested", meet_and_greet.vec_text_nested([["A", "B"], ["C"]]), "vec_string_nested: A|B; C");
    test("Vec Char", meet_and_greet.vec_char(['a', 'b', 'c']), "vec_char: abc");
    test("Vec F64", meet_and_greet.vec_f64([1.25, -2.5, 3.0]), "vec_f64: 1.25, -2.5, 3");

    test("To Vec Bool", debug_show meet_and_greet.to_vec_bool(1, true), "[true, false, true, false]");
    test("To Vec Char", debug_show meet_and_greet.to_vec_char(128, 'a'), "['@', 'a']");
    test("To Vec U8", debug_show meet_and_greet.to_vec_u8(2, 'a'), "[1, 97]");
    test("To Vec I16", debug_show meet_and_greet.to_vec_i16(4, 1), "[+2, 0]");
    test("To Vec U32", debug_show meet_and_greet.to_vec_u32(4, 1), "[1, 0]");
    test("To Vec I64", debug_show meet_and_greet.to_vec_i64(4, 1), "[+2, 0]");
    test("To Vec F64", debug_show meet_and_greet.to_vec_f64(4, 1.4), "[2.000000, 0.700000]");
    test("To Vec String", debug_show meet_and_greet.to_vec_string("Hello", "World"), "[\"Hello!\", \"World!\"]");
    test("To Vec Vec Simple", debug_show meet_and_greet.to_vec_vec_simple(), "[[0, 0], [1, 1]]");
    test("To Vec Vec U64", debug_show meet_and_greet.to_vec_vec_u64(1), "[[1, 1], [2, 2]]");
    test("To Vec Vec", debug_show meet_and_greet.to_vec_vec([1, 2, 3]), "[[1, 2, 3], [2, 3, 4]]");
};
