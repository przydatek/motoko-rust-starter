import {
    debugPrint;
    decodeUtf8;
    trap;
} "mo:prim";

import Blob "mo:core/Blob";
import Text "mo:core/Text";
import Array "mo:core/Array";
import Hex "mo:hex";


// Import functionality from WASM components.
import meet_and_greet "../../mops/component/meet_and_greet";
import ic_sig_verifier "component:ic_sig_verifier";
import {verifyBlsSig = verifyBlsSignature} "component:ic_sig_verifier";


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

func shortenText(s : Text) : Text {
  let chars = Text.toArray(s);
  let n = chars.size();
  let first4 = Array.sliceToArray<Char>(chars, 0, if (n < 4) n else 4);
  let last4 = Array.sliceToArray<Char>(chars, if (n < 4) 0 else n - 4, n);
  Text.fromArray(Array.flatten([first4, Text.toArray(".."), last4]));
};

func testBlsSignature(sig_hex : Text, msg_hex : Text, pk_hex : Text, expected : Bool) {
    let actual = verifyBlsSignature(
        Blob.fromArray(Hex.toArrayUnsafe(sig_hex)),
        Blob.fromArray(Hex.toArrayUnsafe(msg_hex)),
        Blob.fromArray(Hex.toArrayUnsafe(pk_hex))
    );
    let logMsg = "BLS sig: " # shortenText(sig_hex) # " for message " # shortenText(msg_hex) # " and public key " # shortenText(pk_hex);
    if (actual == expected) {
        debugPrint("✅ " # logMsg # " is " # (if expected { "valid" } else { "invalid" }) # ", as expected");
    } else {
        debugPrint("❌ verification of " # logMsg # " returned unexpected result:");
        debugPrint("   Expected: " # debug_show (expected));
        debugPrint("   Actual  : " # debug_show (actual));
    };
};

do {
    debugPrint("\n===== Meet-and-greet basic functionality: ");
    
    test("sayHello: ", meet_and_greet.sayHello("Bob"), "Hello Bob!");
    test("sayBye, informal: ", meet_and_greet.sayBye("Alice", false), "Bye Alice!");
    test("sayBye, formal: ", meet_and_greet.sayBye("Carol", true), "Goodbye Carol!");
};

type CanisterSigVerifierArgs = {
    message : Blob;
    signature_cbor : Blob;
    public_key_der : Blob;
};

do {
    debugPrint("\n===== BLS signature verification: ");

    type TestBlsSignature = {
        expected : Bool;
        sig_hex : Text;
        msg_hex : Text;
        pk_hex : Text;
    };

    // Test vectors from https://github.com/dfinity/verify-bls-signatures/blob/master/tests/tests.rs
    let test_data_hex : [TestBlsSignature] = [
        {
            expected = true;
            sig_hex = "ace9fcdd9bc977e05d6328f889dc4e7c99114c737a494653cb27a1f55c06f4555e0f160980af5ead098acc195010b2f7";
            msg_hex = "0d69632d73746174652d726f6f74e6c01e909b4923345ce5970962bcfe3004bfd8474a21dae28f50692502f46d90";
            pk_hex = "814c0e6ec71fab583b08bd81373c255c3c371b2e84863c98a4f1e08b74235d14fb5d9c0cd546d9685f913a0c0b2cc5341583bf4b4392e467db96d65b9bb4cb717112f8472e0d5a4d14505ffd7484b01291091c5f87b98883463f98091a0baaae";
        },
        {
            expected = true;
            sig_hex = "89a2be21b5fa8ac9fab1527e041327ce899d7da971436a1f2165393947b4d942365bfe5488710e61a619ba48388a21b1";
            msg_hex = "0d69632d73746174652d726f6f74b294b418b11ebe5dd7dd1dcb099e4e0372b9a42aef7a7a37fb4f25667d705ea9";
            pk_hex = "9933e1f89e8a3c4d7fdcccdbd518089e2bd4d8180a261f18d9c247a52768ebce98dc7328a39814a8f911086a1dd50cbe015e2a53b7bf78b55288893daa15c346640e8831d72a12bdedd979d28470c34823b8d1c3f4795d9c3984a247132e94fe";
        },
        {
            expected = false;
            sig_hex = "89a2be21b5fa8ac9fab1527e041327ce899d7da971436a1f2165393947b4d942365bfe5488710e61a619ba48388a21b1";
            msg_hex = "0d69632d73746174652d726f6f74e6c01e909b4923345ce5970962bcfe3004bfd8474a21dae28f50692502f46d90";
            pk_hex = "814c0e6ec71fab583b08bd81373c255c3c371b2e84863c98a4f1e08b74235d14fb5d9c0cd546d9685f913a0c0b2cc5341583bf4b4392e467db96d65b9bb4cb717112f8472e0d5a4d14505ffd7484b01291091c5f87b98883463f98091a0baaae";
        },
        {
            expected = false;
            sig_hex = "ace9fcdd9bc977e05d6328f889dc4e7c99114c737a494653cb27a1f55c06f4555e0f160980af5ead098acc195010b2f7";
            msg_hex = "0d69632d73746174652d726f6f74b294b418b11ebe5dd7dd1dcb099e4e0372b9a42aef7a7a37fb4f25667d705ea9";
            pk_hex = "9933e1f89e8a3c4d7fdcccdbd518089e2bd4d8180a261f18d9c247a52768ebce98dc7328a39814a8f911086a1dd50cbe015e2a53b7bf78b55288893daa15c346640e8831d72a12bdedd979d28470c34823b8d1c3f4795d9c3984a247132e94fe";
        },
        {
            expected = false;
            sig_hex = "ace9fcdd9bc977e05d6328f889dc4e7c99114c737a494653cb27a1f55c06f4555e0f160980af5ead098acc195010b2f8";
            msg_hex = "0d69632d73746174652d726f6f74e6c01e909b4923345ce5970962bcfe3004bfd8474a21dae28f50692502f46d90";
            pk_hex = "814c0e6ec71fab583b08bd81373c255c3c371b2e84863c98a4f1e08b74235d14fb5d9c0cd546d9685f913a0c0b2cc5341583bf4b4392e467db96d65b9bb4cb717112f8472e0d5a4d14505ffd7484b01291091c5f87b98883463f98091a0baaae";
        },
        {
            expected = false;
            sig_hex = "ace9fcdd9bc977e05d6328f889dc4e7c99114c737a494653cb27a1f55c06f4555e0f160980af5ead098acc195010b2f7";
            msg_hex = "0d69632d73746174652d726f6f74e6c01e909b4923345ce5970962bcfe3004bfd8474a21dae28f50692502f46d90";
            pk_hex = "814c0e6ec71fab583b08bd81373c255c3c371b2e84863c98a4f1e08b74235d14fb5d9c0cd546d9685f913a0c0b2cc5341583bf4b4392e467db96d65b9bb4cb717112f8472e0d5a4d14505ffd7484b01291091c5f87b98883463f98091a0baaad";
        }
    ];
    for (tuple in test_data_hex.values()) {
        testBlsSignature(
            tuple.sig_hex,
            tuple.msg_hex,
            tuple.pk_hex,
            tuple.expected
        );
    };
};

do {
    debugPrint("\n===== Error reported by a component: ");
    testBlobText("verifyCanisterSigMainnet: ", ic_sig_verifier.verifyCanisterSigMainnet("args, serialized"), "valid");
    let dummyArgs : CanisterSigVerifierArgs = {
        message = Blob.fromArray([1, 2, 3]); // Placeholder for message
        signature_cbor = Blob.fromArray([3, 4, 5]); // Placeholder for signature
        public_key_der = Blob.fromArray([6, 7, 8]); // Placeholder for public key
    };
    testBlobText("verifyCanisterSigMainnet: ", ic_sig_verifier.verifyCanisterSigMainnet(to_candid(dummyArgs)), "valid");
};

do {
    debugPrint("\n===== Various primitive types in arguments and the return value: ");

    testBlobText("Concat0: ", meet_and_greet.concat0(), "concat0");
    testBlobText("Concat2: ", meet_and_greet.concat2("Hello", "World"), "concat2: Hello World");
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
