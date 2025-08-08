module meet_and_greet {
    public func sayHello(guest_name : Blob) : Blob = ((prim "component:meet-and-greet:say-hello") : Blob -> Blob) guest_name;
    public func sayGoodbye(guest_name : Blob) : Blob = ((prim "component:meet-and-greet:say-goodbye") : Blob -> Blob) guest_name;
    public func concat0() : Blob = ((prim "component:meet-and-greet:concat0") : () -> Blob)();
    public func concat2(a : Blob, b : Blob) : Blob = ((prim "component:meet-and-greet:concat2") : (Blob, Blob) -> Blob)(a, b);
    public func prim_bool(a : Bool) : Blob = ((prim "component:meet-and-greet:prim-bool") : Bool -> Blob)(a);
    public func prim_char(a : Char) : Blob = ((prim "component:meet-and-greet:prim-char") : Char -> Blob)(a);
    public func prim_u8(a : Nat8) : Blob = ((prim "component:meet-and-greet:prim-u8") : Nat8 -> Blob)(a);
    public func prim_u16(a : Nat16) : Blob = ((prim "component:meet-and-greet:prim-u16") : Nat16 -> Blob)(a);
    public func prim_u32(a : Nat32) : Blob = ((prim "component:meet-and-greet:prim-u32") : Nat32 -> Blob)(a);
    public func prim_u64(a : Nat64) : Blob = ((prim "component:meet-and-greet:prim-u64") : Nat64 -> Blob)(a);
    public func prim_i8(a : Int8) : Blob = ((prim "component:meet-and-greet:prim-i8") : Int8 -> Blob)(a);
    public func prim_i16(a : Int16) : Blob = ((prim "component:meet-and-greet:prim-i16") : Int16 -> Blob)(a);
    public func prim_i32(a : Int32) : Blob = ((prim "component:meet-and-greet:prim-i32") : Int32 -> Blob)(a);
    public func prim_i64(a : Int64) : Blob = ((prim "component:meet-and-greet:prim-i64") : Int64 -> Blob)(a);
};
