/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package objetos;

/**
 *
 */
public class InfoConexion {
    
    // Cambie username y password por los de SU servidor MySQL
    String url = "jdbc:mysql://localhost:3306/cafeteria?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=America/Bogota";
    String username = "root";
    String password = "Mysql123!";

    public InfoConexion() {
    }

    public String getUrl() {
        return url;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }
    
}
