use std::net::{IpAddr, Ipv4Addr, UdpSocket};
use tauri::command;


#[command]
fn get_network_info() -> Result<String, String> {
    let hostname = hostname::get().map_err(|e| e.to_string())?;
    let hostname_str = hostname.to_string_lossy().into_owned();
    
    let local_ip = local_ip_address::local_ip().map_err(|e| e.to_string())?;
    let local_ip_str = match local_ip {
        IpAddr::V4(ip) => ip.to_string(),
        IpAddr::V6(_) => "IPv6 non supporté pour l'instant".to_string(),
    };

    Ok(format!(
        r#"{{"hostname": "{}", "local_ip": "{}"}}"#,
        hostname_str, local_ip_str
    ))
}


fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![get_network_info])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}