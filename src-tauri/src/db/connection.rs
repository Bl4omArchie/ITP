use tauri::async_runtime::block_on;

fn main() {
    let client = block_on(connect_to_db()).expect("Failed to connect to database");

    tauri::Builder::default()
        .manage(client) // Share the client with commands
        .invoke_handler(tauri::generate_handler![get_data])
        .run(tauri::generate_context!())
        .expect("error while running Tauri application");
}
