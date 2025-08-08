wit_bindgen::generate!({
    path: "ic_sig_verifier.wit",
    world: "ic-sig-verifier",
});

use candid::{CandidType, Decode, Deserialize};
use ic_signature_verification::verify_canister_sig;

struct IcSigVerifier;
export!(IcSigVerifier);

#[derive(CandidType, Deserialize)]
struct CanisterSigVerifierArgs {
    message: Vec<u8>,
    signature_cbor: Vec<u8>,
    public_key_der: Vec<u8>,
}
impl Guest for IcSigVerifier {
    fn verify_canister_sig(args_serialized: Vec<u8>) -> Vec<u8> {
        let args = match Decode!(&args_serialized, CanisterSigVerifierArgs) {
            Ok(args) => args,
            Err(_) => {
                return "failed parsing arguments of verify_canister_sig"
                    .as_bytes()
                    .to_vec()
            }
        };
        match verify_canister_sig(
            &args.message,
            &args.signature_cbor,
            &args.public_key_der,
            &ic_canister_sig_creation::IC_ROOT_PUBLIC_KEY,
        ) {
            Ok(_) => "verification succeeded".as_bytes().to_vec(),
            Err(err_msg) => format!("verification failed: {}", err_msg)
                .as_bytes()
                .to_vec(),
        }
    }

    fn verify_bls_sig(args_serialized: Vec<u8>) -> Vec<u8> {
        let _args = match Decode!(&args_serialized, CanisterSigVerifierArgs) {
            Ok(args) => args,
            Err(_) => {
                return "failed parsing arguments of verify_bls_sig"
                    .as_bytes()
                    .to_vec()
            }
        };
        return "BLS signature verification is not implemented yet"
            .as_bytes()
            .to_vec();
    }

    fn verify_canister_sig_direct(
        message: Vec<u8>,
        signature_cbor: Vec<u8>,
        public_key_der: Vec<u8>,
    ) -> Vec<u8> {
        match verify_canister_sig(
            &message,
            &signature_cbor,
            &public_key_der,
            &ic_canister_sig_creation::IC_ROOT_PUBLIC_KEY,
        ) {
            Ok(_) => "verification succeeded".as_bytes().to_vec(),
            Err(err_msg) => format!("verification failed: {}", err_msg)
                .as_bytes()
                .to_vec(),
        }
    }
}
