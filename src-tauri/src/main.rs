mod itp_sender;

use itp_sender::send_ssh::send_script_ssh;


fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![send_script_ssh])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}