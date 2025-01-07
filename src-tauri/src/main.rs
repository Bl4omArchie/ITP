use tauri::{ menu::{AboutMetadata, MenuBuilder, MenuItemBuilder, SubmenuBuilder},};
use std::net::{IpAddr, Ipv4Addr, UdpSocket};
use tauri::command;
use tauri::Emitter;

#[command]
fn get_network_info() -> Result<String, String> {
    // Récupérer l'adresse IP locale
    let hostname = hostname::get().map_err(|e| e.to_string())?;
    let hostname_str = hostname.to_string_lossy().into_owned();
    
    let local_ip = local_ip_address::local_ip().map_err(|e| e.to_string())?;
    let local_ip_str = match local_ip {
        IpAddr::V4(ip) => ip.to_string(),
        IpAddr::V6(_) => "IPv6 non supporté pour l'instant".to_string(),
    };

    // Retourner les informations en JSON
    Ok(format!(
        r#"{{"hostname": "{}", "local_ip": "{}"}}"#,
        hostname_str, local_ip_str
    ))
}


fn main() {
    tauri::Builder::default()
        .setup(|app| {
            let _handle = app.handle();
            
            // Define custom settings menu item
            let settings = MenuItemBuilder::new("Settings...")
                .id("settings")
                .accelerator("CmdOrCtrl+,")
                .build(app)?;


            // Define the "App" submenu with title metadata
            let app_submenu = SubmenuBuilder::new(app, "App")
                .about(Some(AboutMetadata {
                    name: Some("My App".into()), // Set the app title here
                    version: Some("1.0.0".into()),
                    ..Default::default()
                }))
                .separator()
                .item(&settings)
                .separator()
                .services()
                .separator()
                .hide()
                .hide_others()
                .quit()
                .build()?;

            // Build the main menu
            let menu = MenuBuilder::new(app)
                .items(&[
                    &app_submenu,
                ])
                .build()?;

            // Set the application menu
            app.set_menu(menu)?;

            // Handle menu events
            app.on_menu_event(move |app, event| {
                if event.id() == settings.id() {
                    // Emit an event to navigate to the settings page on the frontend
                    let _event = app.emit("custom-event", "/settings");
                }
            });

            Ok(())
        })
        .invoke_handler(tauri::generate_handler![get_network_info])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}