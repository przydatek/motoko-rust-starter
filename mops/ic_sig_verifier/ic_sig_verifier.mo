module ic_sig_verifier {
  public func verifyCanisterSig(args_serialized: Blob) : Blob =
    ((prim "component:ic-sig-verifier:verify-canister-sig") : Blob ->  Blob) args_serialized;
  public func verifyBlsSig(args_serialized: Blob) : Blob =
    ((prim "component:ic-sig-verifier:verify-bls-sig") : Blob ->  Blob) args_serialized;
}
