package com.bank;

import java.io.*;
import java.util.*;

public aspect Logger {
	Calendar cal;
	File file = new File("log.txt");
	pointcut transaccion() : execution(* money*(..));
    
    
    after() : transaccion() {

    	try {
    		cal = Calendar.getInstance();
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
        	if("void com.bank.Bank.moneyMakeTransaction()".equals(thisJoinPoint.getSignature().toString())) lista.add("Depósito de dinero :"+cal.getTime().toString());
        	else if("void com.bank.Bank.moneyWithdrawal()".equals(thisJoinPoint.getSignature().toString())) lista.add("Retiro de dinero :"+cal.getTime().toString());
        	BufferedWriter bw = new BufferedWriter(new FileWriter(file));
			for(String str: lista) bw.write(str+"\n");
			bw.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
    	System.out.println("**** Transacción realizada ****");
    }
}