# Requisitos:

  - [x] O usuário vai chamar um endpoint passando um cep para buscar um endereço, caso o cep já exista na nossa base de dados, deve-se retornar oendereço para o usuário caso contrário buscar o endereço no ws https://viacep.com.br/ws/CEP/json/ (ou outro ws da sua escolha) e precisamos salvar esse novo endereço dentro da nossa base de dados. 

- [x] Precisamos de um endpoint para gerar um CSV com todos os endereços salvos da nossa base de dados e esse processamento precisa ser assíncrono (a
arquitetura do envio desse CSV para o usuário fica a seu critério como a forma de fazer esse processamento).

## Requisitos Bônus ( Não obrigatório)

- Precisamos de uma maneira de garantir a segurança da nossa api,seja por algum tipo de token de autorização ou via basicaut (seria interessante um endpoint de login por usuário).

### Observações:

  - testes unitários são obrigatórios;

  - A modelagem do banco de dados fica a seu critério;
  
  - Escreva um README comentando um pouco da solução proposta e como executar o projeto (seria interessante um docker para isso);

  - Estaremos avaliando sua solução como um todo e não apenas seu código;
  
  - Crie um repositório no seu github de forma pública e envie o link para gente.

# Explicando o código:
