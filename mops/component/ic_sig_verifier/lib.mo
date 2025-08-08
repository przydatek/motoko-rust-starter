module ic_sig_verifier {
  public func verifyCanisterSig(args_serialized : Blob) : Blob = ((prim "component:ic-sig-verifier:verify-canister-sig") : Blob -> Blob) args_serialized;
  public func verifyCanisterSigDirect(message : Blob, signature_cbor : Blob, public_key_der : Blob) : Blob = ((prim "component:ic-sig-verifier:verify-canister-sig-direct") : (Blob, Blob, Blob) -> Blob)(message, signature_cbor, public_key_der);
  public func verifyBlsSig(args_serialized : Blob) : Blob = ((prim "component:ic-sig-verifier:verify-bls-sig") : Blob -> Blob) args_serialized;
};
