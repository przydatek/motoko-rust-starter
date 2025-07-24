module meet_and_greet {
  public func sayHello(guest_name: Blob) : Blob =
  ((prim "component:meet-and-greet:say-hello") : Blob ->  Blob) guest_name;
  public func sayGoodbye(guest_name: Blob) : Blob =
    ((prim "component:meet-and-greet:say-goodbye") : Blob ->  Blob) guest_name;
}
