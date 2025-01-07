use tauri::Window;

#[tauri::command]
fn minimize(window: Window) {
    window.minimize().unwrap();
}

#[tauri::command]
fn maximize(window: Window) {
    window.maximize().unwrap();
}

#[tauri::command]
fn unmaximize(window: Window) {
    window.unmaximize().unwrap();
}

#[tauri::command]
fn close(window: Window) {
    window.close().unwrap();
}

fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![minimize, maximize, unmaximize, close])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}