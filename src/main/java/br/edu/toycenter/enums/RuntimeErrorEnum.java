package br.edu.toycenter.enums;

public enum RuntimeErrorEnum {
	ERR0001("DATABASE_CONNECTION_ERROR", "Houve um erro ao conectar o banco de dados."),
	ERR0002("DATABASE_CONNECTION_ERROR", "Houve um erro ao desconectar do banco de dados."),
	ERR0003("DATABASE_OPERATION_ERROR", "Houve ao buscar dados do banco de dados."),
	ERR0004("DATABASE_OPERATION_ERROR", "Houve ao inserir dados do banco de dados."),
	ERR0005("DATABASE_OPERATION_ERROR", "Houve ao atualizar dados do banco de dados."),
	ERR0006("DATABASE_OPERATION_ERROR", "Houve ao excluir dados do banco de dados."),
	ERR0007("OPERATION_NOT_ALLOWED", "Não é possível excluir este usuário, pois ele é o único no banco de dados."),
	ERR0008("IMAGE_UPLOAD_ERROR", "Houve uma falha ao fazer o upload de imagem.");

	private final String code;
	private final String message;
	
	RuntimeErrorEnum(String code, String message) {
		this.code = code;
		this.message = message;
	}
	
	public String getCode() {
		return code;
	}
	
	public String getMessage() {
		return message;
	}
}
