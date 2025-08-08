wit_bindgen::generate!({
    path: "meet_and_greet.wit",
    world: "meet-and-greet",
});

struct MeetAndGreet;
export!(MeetAndGreet);

impl Guest for MeetAndGreet {
    fn say_hello(guest_name: Vec<u8>) -> Vec<u8> {
        format!("hello {}!", String::from_utf8_lossy(&guest_name)).into()
    }

    fn say_goodbye(guest_name: Vec<u8>) -> Vec<u8> {
        format!("goodbye {}!", String::from_utf8_lossy(&guest_name)).into()
    }

    fn concat0() -> Vec<u8> {
        "concat0".into()
    }
    fn concat2(a: Vec<u8>, b: Vec<u8>) -> Vec<u8> {
        format!(
            "concat2: {} {}",
            String::from_utf8_lossy(&a),
            String::from_utf8_lossy(&b)
        )
        .into()
    }

    // Primitives in arguments
    fn prim_bool(a: bool) -> Vec<u8> {
        format!("prim_bool: {}", a).into()
    }
    fn prim_char(a: char) -> Vec<u8> {
        format!("prim_char: {}", a).into()
    }
    fn prim_u8(a: u8) -> Vec<u8> {
        format!("prim_u8: {}", a).into()
    }
    fn prim_u16(a: u16) -> Vec<u8> {
        format!("prim_u16: {}", a).into()
    }
    fn prim_u32(a: u32) -> Vec<u8> {
        format!("prim_u32: {}", a).into()
    }
    fn prim_u64(a: u64) -> Vec<u8> {
        format!("prim_u64: {}", a).into()
    }
    fn prim_i8(a: i8) -> Vec<u8> {
        format!("prim_i8: {}", a).into()
    }
    fn prim_i16(a: i16) -> Vec<u8> {
        format!("prim_i16: {}", a).into()
    }
    fn prim_i32(a: i32) -> Vec<u8> {
        format!("prim_i32: {}", a).into()
    }
    fn prim_i64(a: i64) -> Vec<u8> {
        format!("prim_i64: {}", a).into()
    }
    // fn prim_f64(a: f64) -> Vec<u8> {
    //     format!("prim_f64: {}", a).into()
    // }
}
