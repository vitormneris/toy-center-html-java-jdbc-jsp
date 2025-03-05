package br.edu.toycenter.exceptions;

import br.edu.toycenter.enums.RuntimeErrorEnum;

public class InvalidFieldException extends RuntimeException {

	private static final long serialVersionUID = 1L;

	private RuntimeErrorEnum runtimeErrorEnum;
	
	public InvalidFieldException(String message) {
		super(message);
	}
	
	public InvalidFieldException(RuntimeErrorEnum runtimeErrorEnum) {
		super(runtimeErrorEnum.getMessage());
		this.runtimeErrorEnum = runtimeErrorEnum;
	}
	
	public RuntimeErrorEnum getRuntimeErrorEnum() {
		return runtimeErrorEnum;
	}
}
