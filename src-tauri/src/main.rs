use tauri::Builder;

fn main() {
    Builder::default()
        .invoke_handler(tauri::generate_handler![greet])
        .run(tauri::generate_context!())
        .expect("Error while running Tauri application");
}

#[tauri::command]
fn greet(name: String) -> String {
    format!("Hello, {}!", name)
}
