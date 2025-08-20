module ic_sig_verifier {
  public func verifyCanisterSigMainnet(args_serialized : Blob) : Blob =
      ((prim "component:ic-sig-verifier:verify-canister-sig-mainnet") : Blob -> Blob) args_serialized;
  public func verifyCanisterSig(signature_cbor : Blob, message: Blob, public_key_der : Blob, ic_root_public_key_raw : Blob) : Bool =
      ((prim "component:ic-sig-verifier:verify-canister-sig") : (Blob, Blob, Blob, Blob) -> Bool)(signature_cbor, message, public_key_der, ic_root_public_key_raw);
  public func verifyBlsSig(signature : Blob, message : Blob, public_key : Blob) : Bool =
      ((prim "component:ic-sig-verifier:verify-bls-sig") : (Blob, Blob, Blob)  -> Bool) (signature, message, public_key);
};
