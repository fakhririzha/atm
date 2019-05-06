/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sistematm;

/**
 *
 * @author Fakhri
 */
public class ManajemenUser {
    
    String nomorRekening, kataSandi, namaRekening;
    
    ManajemenUser(){
        this.nomorRekening = new String();
        this.kataSandi = new String();
        this.nomorRekening = "27032001";
        this.kataSandi = "270301";
        this.namaRekening = "Fakhri Rizha Ananda";
    }
    
    public String getNomorRekening(){
        return this.nomorRekening;
    }
    
    public String getKataSandi(){
        return this.kataSandi;
    }
    
    public String getNamaRekening(){
        return this.namaRekening;
    }
    
}
