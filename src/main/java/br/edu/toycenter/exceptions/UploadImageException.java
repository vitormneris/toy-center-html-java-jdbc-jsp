package br.edu.toycenter.exceptions;

import br.edu.toycenter.enums.RuntimeErrorEnum;

public class UploadImageException extends RuntimeException {

	private static final long serialVersionUID = 1L;
	
	private final RuntimeErrorEnum runtimeErrorEnum;
	
	public UploadImageException(RuntimeErrorEnum runtimeErrorEnum) {
		super(runtimeErrorEnum.getMessage());
		this.runtimeErrorEnum = runtimeErrorEnum;
	}
	
	public RuntimeErrorEnum getRuntimeErrorEnum() {
		return runtimeErrorEnum;
	}
}
