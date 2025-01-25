use std::process::Command;

#[tauri::command]
pub fn send_script_ssh(ip: String, port: u16, local_path: String, remote_path: String) -> Result<String, String> {
    let scp_status = Command::new("scp")
        .arg("-P")
        .arg(port.to_string())
        .arg(&local_path)
        .arg(format!("piggy@{}:{}", ip, remote_path))
        .status();

    if let Err(error) = scp_status {
        return Err(format!("Error SCP : {}", error));
    }

    Ok("Script sended".to_string())
}