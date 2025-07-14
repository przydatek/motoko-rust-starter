module ic_sig_verifier {
  public func verifyCanisterSig(args_serialized: [Nat8]) : [Nat8] =
        ((prim “component:ic_sig_verifier:verify_canister_sig”) : [Nat8] ->  [Nat8]) args_serialized;
}
