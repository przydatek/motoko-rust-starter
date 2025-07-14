module ic_sig_verifier {
  public func verifyCanisterSig(args_serialized: Blob) : Blob =
  ((prim "component:ic_sig_verifier:verify_canister_sig") : Blob ->  Blob) args_serialized;
  /// public func verifyCanisterSig(message: Blob, signature: Blob) : Bool =
  ///   ((prim "component:ic_sig_verifier:verify_canister_sig") : Blob, Blob ->  Bool) (message, signature);
}
