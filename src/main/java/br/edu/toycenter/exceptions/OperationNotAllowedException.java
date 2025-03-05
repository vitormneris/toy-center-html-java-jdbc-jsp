package br.edu.toycenter.exceptions;

import br.edu.toycenter.enums.RuntimeErrorEnum;

public class OperationNotAllowedException extends RuntimeException {

	private static final long serialVersionUID = 1L;
	
	private final RuntimeErrorEnum runtimeErrorEnum;
	
	public OperationNotAllowedException(RuntimeErrorEnum runtimeErrorEnum) {
		super(runtimeErrorEnum.getMessage());
		this.runtimeErrorEnum = runtimeErrorEnum;
	}
	
	public RuntimeErrorEnum getRuntimeErrorEnum() {
		return runtimeErrorEnum;
	}
}
