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
    fn prim_bool(a: bool) -> bool {
        a
    }
    fn prim_char(a: char) -> char {
        a
    }
    fn prim_u8(a: u8) -> u8 {
        a
    }
    fn prim_u16(a: u16) -> u16 {
        a
    }
    fn prim_u32(a: u32) -> u32 {
        a
    }
    fn prim_u64(a: u64) -> u64 {
        a
    }
    fn prim_i8(a: i8) -> i8 {
        a
    }
    fn prim_i16(a: i16) -> i16 {
        a
    }
    fn prim_i32(a: i32) -> i32 {
        a
    }
    fn prim_i64(a: i64) -> i64 {
        a
    }
    fn prim_f64(a: f64) -> f64 {
        a
    }
    fn prim_string(a: String) -> String {
        a + "!"
    }

    fn vec_u16(a: Vec<u16>) -> String {
        format!(
            "vec_u16: {}",
            a.iter()
                .map(|x| x.to_string())
                .collect::<Vec<String>>()
                .join(", ")
        )
    }
    fn vec_string(a: Vec<String>) -> String {
        format!(
            "vec_string: {}",
            a.iter()
                .map(|x| x.to_string())
                .collect::<Vec<String>>()
                .join(", ")
        )
    }
    fn vec_u8(a: Vec<u8>) -> String {
        format!(
            "vec_u8: {}",
            a.iter()
                .map(|x| x.to_string())
                .collect::<Vec<String>>()
                .join(", ")
        )
    }
    fn vec_u32(a: Vec<u32>) -> String {
        format!(
            "vec_u32: {}",
            a.iter()
                .map(|x| x.to_string())
                .collect::<Vec<String>>()
                .join(", ")
        )
    }
    fn vec_i32(a: Vec<i32>) -> String {
        format!(
            "vec_i32: {}",
            a.iter()
                .map(|x| x.to_string())
                .collect::<Vec<String>>()
                .join(", ")
        )
    }
    fn vec_i64(a: Vec<i64>) -> String {
        format!(
            "vec_i64: {}",
            a.iter()
                .map(|x| x.to_string())
                .collect::<Vec<String>>()
                .join(", ")
        )
    }
    fn vec_bool(a: Vec<bool>) -> String {
        format!(
            "vec_bool: {}",
            a.iter()
                .map(|x| x.to_string())
                .collect::<Vec<String>>()
                .join(", ")
        )
    }
    fn vec_string_nested(a: Vec<Vec<String>>) -> String {
        let inner = a
            .iter()
            .map(|inner| inner.join("|"))
            .collect::<Vec<String>>()
            .join("; ");
        format!("vec_string_nested: {}", inner)
    }
    fn vec_char(a: Vec<char>) -> String {
        let s: String = a.into_iter().collect();
        format!("vec_char: {}", s)
    }
    fn vec_f64(a: Vec<f64>) -> String {
        format!(
            "vec_f64: {}",
            a.iter()
                .map(|x| x.to_string())
                .collect::<Vec<String>>()
                .join(", ")
        )
    }
}
