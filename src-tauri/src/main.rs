use std::process::Command;

#[tauri::command]
fn transfer_and_execute(ip: String, port: u16, local_path: String, remote_path: String) -> Result<String, String> {
    // Transfert du fichier via scp
    let scp_status = Command::new("scp")
        .arg("-P")
        .arg(port.to_string())
        .arg(&local_path)
        .arg(format!("user@{}:{}", ip, remote_path))
        .status();

    if let Err(error) = scp_status {
        return Err(format!("Erreur SCP : {}", error));
    }

    // Exécution du fichier distant via SSH
    let ssh_status = Command::new("ssh")
        .arg("-p")
        .arg(port.to_string())
        .arg(format!("user@{}", ip))
        .arg(format!("bash {}", remote_path))
        .status();

    if let Err(error) = ssh_status {
        return Err(format!("Erreur SSH : {}", error));
    }

    Ok("Script transféré et exécuté avec succès".to_string())
}


fn main() {
    tauri::Builder::default()
        .invoke_handler(tauri::generate_handler![transfer_and_execute])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}