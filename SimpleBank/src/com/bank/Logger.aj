package com.bank;

import java.io.*;
import java.util.*;

public aspect Logger {
	File file = new File("log.txt");
    Calendar cal = Calendar.getInstance();
    pointcut ingresar() : execution(* moneyMakeTransaction());
    pointcut retirar() : execution(* moneyWithdrawal());
    
    
    after() : ingresar() {
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
    	System.out.println("**** ingreso dinero ****");
    }
    after() : retirar() {
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
        	lista.add("retiro de dinero :"+cal.getTime().toString());
        	BufferedWriter bw = new BufferedWriter(new FileWriter(file));
			for(String str: lista) bw.write(str+"\n");
			bw.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
    	System.out.println("**** retiro dinero ****");
    }
}