module meet_and_greet {
    public func sayHello(guest_name : Blob) : Blob = ((prim "component:meet-and-greet:say-hello") : Blob -> Blob) guest_name;
    public func sayGoodbye(guest_name : Blob) : Blob = ((prim "component:meet-and-greet:say-goodbye") : Blob -> Blob) guest_name;
    public func concat0() : Blob = ((prim "component:meet-and-greet:concat0") : () -> Blob)();
    public func concat2(a : Blob, b : Blob) : Blob = ((prim "component:meet-and-greet:concat2") : (Blob, Blob) -> Blob)(a, b);
    public func prim_bool(a : Bool) : Bool = ((prim "component:meet-and-greet:prim-bool") : Bool -> Bool)(a);
    public func prim_char(a : Char) : Char = ((prim "component:meet-and-greet:prim-char") : Char -> Char)(a);
    public func prim_u8(a : Nat8) : Nat8 = ((prim "component:meet-and-greet:prim-u8") : Nat8 -> Nat8)(a);
    public func prim_u16(a : Nat16) : Nat16 = ((prim "component:meet-and-greet:prim-u16") : Nat16 -> Nat16)(a);
    public func prim_u32(a : Nat32) : Nat32 = ((prim "component:meet-and-greet:prim-u32") : Nat32 -> Nat32)(a);
    public func prim_u64(a : Nat64) : Nat64 = ((prim "component:meet-and-greet:prim-u64") : Nat64 -> Nat64)(a);
    public func prim_i8(a : Int8) : Int8 = ((prim "component:meet-and-greet:prim-i8") : Int8 -> Int8)(a);
    public func prim_i16(a : Int16) : Int16 = ((prim "component:meet-and-greet:prim-i16") : Int16 -> Int16)(a);
    public func prim_i32(a : Int32) : Int32 = ((prim "component:meet-and-greet:prim-i32") : Int32 -> Int32)(a);
    public func prim_i64(a : Int64) : Int64 = ((prim "component:meet-and-greet:prim-i64") : Int64 -> Int64)(a);
    public func prim_f64(a : Float) : Float = ((prim "component:meet-and-greet:prim-f64") : Float -> Float)(a);
    public func prim_text_in(a : Text) : Int32 = ((prim "component:meet-and-greet:prim-string-in") : Text -> Int32)(a);
    public func prim_text_out() : Text = ((prim "component:meet-and-greet:prim-string-out") : () -> Text)();
    public func prim_text(a : Text) : Text = ((prim "component:meet-and-greet:prim-string") : Text -> Text)(a);

    public func vec_u16(a : [Nat16]) : Text = ((prim "component:meet-and-greet:vec-u16") : [Nat16] -> Text)(a);
    public func vec_text(a : [Text]) : Text = ((prim "component:meet-and-greet:vec-string") : [Text] -> Text)(a);
    public func vec_u8(a : [Nat8]) : Text = ((prim "component:meet-and-greet:vec-u8") : [Nat8] -> Text)(a);
    public func vec_u32(a : [Nat32]) : Text = ((prim "component:meet-and-greet:vec-u32") : [Nat32] -> Text)(a);
    public func vec_i32(a : [Int32]) : Text = ((prim "component:meet-and-greet:vec-i32") : [Int32] -> Text)(a);
    public func vec_i64(a : [Int64]) : Text = ((prim "component:meet-and-greet:vec-i64") : [Int64] -> Text)(a);
    public func vec_bool(a : [Bool]) : Text = ((prim "component:meet-and-greet:vec-bool") : [Bool] -> Text)(a);
    public func vec_text_nested(a : [[Text]]) : Text = ((prim "component:meet-and-greet:vec-string-nested") : [[Text]] -> Text)(a);
    public func vec_char(a : [Char]) : Text = ((prim "component:meet-and-greet:vec-char") : [Char] -> Text)(a);
    public func vec_f64(a : [Float]) : Text = ((prim "component:meet-and-greet:vec-f64") : [Float] -> Text)(a);

    public func to_vec_bool(i : Int32, b : Bool) : [Bool] = ((prim "component:meet-and-greet:to-vec-bool") : (Int32, Bool) -> [Bool])(i, b);
    public func to_vec_char(u : Nat8, c : Char) : [Char] = ((prim "component:meet-and-greet:to-vec-char") : (Nat8, Char) -> [Char])(u, c);
    public func to_vec_u8(u : Nat16, c : Char) : [Nat8] = ((prim "component:meet-and-greet:to-vec-u8") : (Nat16, Char) -> [Nat8])(u, c);
    public func to_vec_i16(u : Nat16, i : Int16) : [Int16] = ((prim "component:meet-and-greet:to-vec-i16") : (Nat16, Int16) -> [Int16])(u, i);
    public func to_vec_u32(u : Nat16, i : Nat32) : [Nat32] = ((prim "component:meet-and-greet:to-vec-u32") : (Nat16, Nat32) -> [Nat32])(u, i);
    public func to_vec_i64(u : Nat16, i : Int64) : [Int64] = ((prim "component:meet-and-greet:to-vec-i64") : (Nat16, Int64) -> [Int64])(u, i);
    public func to_vec_f64(u : Nat16, f : Float) : [Float] = ((prim "component:meet-and-greet:to-vec-f64") : (Nat16, Float) -> [Float])(u, f);
    public func to_vec_string(s1 : Text, s2 : Text) : [Text] = ((prim "component:meet-and-greet:to-vec-string") : (Text, Text) -> [Text])(s1, s2);
    public func to_vec_vec_simple() : [[Nat64]] = ((prim "component:meet-and-greet:to-vec-vec-simple") : () -> [[Nat64]])();
    public func to_vec_vec_u64(u : Nat64) : [[Nat64]] = ((prim "component:meet-and-greet:to-vec-vec-u64") : Nat64 -> [[Nat64]])(u);
    public func to_vec_vec(vec : [Nat64]) : [[Nat64]] = ((prim "component:meet-and-greet:to-vec-vec") : [Nat64] -> [[Nat64]])(vec);

    type V1 = {
        #abc;
        #def;
        #gh;
    };

    public func variant_in11(v : V1) : Text = ((prim "component:meet-and-greet:variant-in11") : V1 -> Text)(v);
    public func variant_in12(v1 : V1, v2 : V1) : Text = ((prim "component:meet-and-greet:variant-in12") : (V1, V1) -> Text)(v1, v2);
    public func variant_array_in(v : [V1]) : Text = ((prim "component:meet-and-greet:variant-array-in") : [V1] -> Text)(v);
};
