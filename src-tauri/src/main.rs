use tauri::{ menu::{AboutMetadata, MenuBuilder, MenuItemBuilder, SubmenuBuilder},};
use tauri::Emitter;



fn main() {
    tauri::Builder::default()
        .setup(|app| {
            let handle = app.handle();
            
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
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}