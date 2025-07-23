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
}
