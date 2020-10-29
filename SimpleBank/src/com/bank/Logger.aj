package com.bank;

import java.io.*;
import java.util.*;

public aspect Logger {
	File file = new File("log.txt");
    Calendar cal = Calendar.getInstance();
    //Aspecto: Deben hacer los puntos de cortes (pointcut) para crear un log con los tipos de transacciones realizadas.
    pointcut success() : call(* moneyMakeTransaction());
    after() : success() {
    	try {
        	ArrayList<String> lista = new ArrayList<>();
        	if(!file.exists()) file.createNewFile();
        	else {
        		BufferedReader wr = new BufferedReader(new FileReader("log.txt"));
            	String linea;
            	while((linea = wr.readLine())!=null){
            		lista.add(linea);
            	}
            	wr.close();
        	}
        	lista.add("Depósito de dinero :"+cal.getTime().toString());
        	BufferedWriter bw = new BufferedWriter(new FileWriter(file));
			for(String str: lista) bw.write(str+"\n");
			bw.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
    	System.out.println("**** User created ****");
    }
}
