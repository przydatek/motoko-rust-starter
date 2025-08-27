wit_bindgen::generate!({
    path: "meet_and_greet.wit",
    world: "meet-and-greet",
});

struct MeetAndGreet;
export!(MeetAndGreet);

use crate::exports::api::Guest;
use crate::exports::api::V1;
// Alternative experimental API version
// use crate::exports::component::meet_and_greet::api::Guest;
// use crate::exports::component::meet_and_greet::api::V1;
// use crate::exports::component::meet_and_greet::api::V2;

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
    fn prim_string_in(a: String) -> i32 {
        a.len() as i32
    }
    fn prim_string_out() -> String {
        "Hello; emoji: ☃❄🌨; FooBär☃!".to_string()
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

    fn to_vec_bool(i: i32, b: bool) -> Vec<bool> {
        let mut v = Vec::new();
        v.push(i > 0);
        v.push(!b);
        v.push(true);
        v.push(false);
        v
    }
    fn to_vec_char(u: u8, c: char) -> Vec<char> {
        let mut v = Vec::new();
        v.push((u / 2u8) as char);
        v.push(c);
        v
    }
    fn to_vec_u8(u: u16, c: char) -> Vec<u8> {
        let mut v = Vec::new();
        v.push((u / 2u16) as u8);
        v.push(c as u8);
        v
    }
    fn to_vec_i16(u: u16, i: i16) -> Vec<i16> {
        let mut v = Vec::new();
        v.push((u / 2u16) as i16);
        v.push(i / 2);
        v
    }
    fn to_vec_u32(u: u16, i: u32) -> Vec<u32> {
        let mut v = Vec::new();
        v.push((u / 2u16) as u32);
        v.push(i / 2);
        v
    }
    fn to_vec_i64(u: u16, i: i64) -> Vec<i64> {
        let mut v = Vec::new();
        v.push((u / 2u16) as i64);
        v.push(i / 2);
        v
    }
    fn to_vec_f64(u: u16, f: f64) -> Vec<f64> {
        let mut v = Vec::new();
        v.push((u / 2u16) as f64);
        v.push(f / 2.0);
        v
    }
    fn to_vec_string(s1: String, s2: String) -> Vec<String> {
        let mut v = Vec::new();
        v.push(s1 + "!");
        v.push(s2 + "!");
        v
    }
    fn to_vec_vec_simple() -> Vec<Vec<u64>> {
        let mut v = Vec::new();
        v.push(vec![0, 0]);
        v.push(vec![1, 1]);
        v
    }
    fn to_vec_vec_u64(u: u64) -> Vec<Vec<u64>> {
        let mut v = Vec::new();
        v.push(vec![u, u]);
        v.push(vec![u + 1, u + 1]);
        v
    }
    fn to_vec_vec(vec: Vec<u64>) -> Vec<Vec<u64>> {
        let mut v = Vec::new();
        v.push(vec.clone());
        v.push(vec.iter().map(|x| x + 1).collect());
        v
    }

    fn variant_in11(v: V1) -> String {
        match v {
            V1::Abc => "#abc".to_string(),
            V1::Def => "#def".to_string(),
            V1::Gh => "#gh".to_string(),
        }
    }
    fn variant_in12(v1: V1, v2: V1) -> String {
        format!("{}, {}", Self::variant_in11(v1), Self::variant_in11(v2))
    }
    fn variant_array_in(v: Vec<V1>) -> String {
        v.iter()
            .map(|x| Self::variant_in11(*x))
            .collect::<Vec<String>>()
            .join(", ")
    }
    fn variant_array_result_like_in(v: Vec<Result<u16, String>>) -> String {
        v.iter()
            .map(|x| match x {
                Result::Ok(u) => format!("ok({})", u),
                Result::Err(s) => format!("err({})", s),
            })
            .collect::<Vec<String>>()
            .join(", ")
    }
}
