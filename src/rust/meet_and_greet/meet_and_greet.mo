module meet_and_greet {
    public func sayHello(guest_name : Blob) : Blob = ((prim "component:meet-and-greet:say-hello") : Blob -> Blob) guest_name;
    public func sayGoodbye(guest_name : Blob) : Blob = ((prim "component:meet-and-greet:say-goodbye") : Blob -> Blob) guest_name;
    public func concat0() : Blob = ((prim "component:meet-and-greet:concat0") : () -> Blob)();
    public func concat2(a : Blob, b : Blob) : Blob = ((prim "component:meet-and-greet:concat2") : (Blob, Blob) -> Blob)(a, b);
};
