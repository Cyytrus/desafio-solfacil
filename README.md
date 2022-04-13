# Requisitos:

  - [ x ] O usuário vai chamar um endpoint passando um cep para buscar um endereço, caso o cep já exista na nossa base de dados, deve-se retornar oendereço para o usuário caso contrário buscar o endereço no ws https://viacep.com.br/ws/CEP/json/ (ou outro ws da sua escolha) e precisamos salvar esse novo endereço dentro da nossa base de dados. 

  - [ x ] Precisamos de um endpoint para gerar um CSV com todos os endereços salvos da nossa base de dados e esse processamento precisa ser assíncrono (a
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

### Parte 0:


Requisitos:

```
PostgresQL -> Versão mais nova
Phoenix >= 1.6.6
Elixir >= 1.13.0
Erlang/OTP >= 24
```

Para executar a aplicação, é necessária a utilziação dos seguintes comandos:

Para instalar as libs necessárias definidas no arquivo `mix.exs`:
```
mix deps.get
```
Para criar e migrar os dados da DataBase:
```
mix ecto.setup
```
Por fim, para subir o servidor:
```
mix phx.server
```
ou

```
iex -S mix phx.server
```

## Parte 1: 
  ### Como a API é consumida:

  * Na Primeira parte, dentro do meu diretório `./lib/tec_sol_facil`, foi criado o diretório de API, especificando o tipo de assunto dos arquivos subsequentes, ou seja, o consumo da API e, dentro dela, o diretório CEP, onde fica o arquivo `cep_consult.ex` que consultará a API externa do **ViaCep.**

  * Em seguida e no arquivo em questão, utilizei a lib [Tesla](https://github.com/teamon/tesla), pois acredito que a mesma atende muito bem os requisitos propostos, após a adição do uso da lib no módulo, foram definidos valores constantes para melhor recebimento dos dados da api juntamente com o Plug Tesla.Middleware.BaseUrl, que seta a minha string subsequente como a URL base da minha api, nesse caso, utilizei "https://viacep.com.br/ws/"

  * Dentro do módulo, na função `get_user_address_info(cep)`, é necessário passar um cep em String, a função chamará um `get()` que interpolará o meu parâmetro anteriormente passado com o complemento `<"/#{cep}/json">`, passando depois pela função privada `handle_response()`, que trata o recebimento do meu JSON, decodificando-o, passando os tipos das chaves de String para Átomos (preferência pessoal minha) e em seguida, filtrando os dados para receber **APENAS** os meus dados definidos como constantes.

      - Os testes podem ser vistos por meio do comando:
    ```
    mix test "./test/tec_sol_facil/API/CEP/cep_consult_test.exs" 
    ```

  ### Comportamente dos controllers:

  * Os controllers estão localizados em `./lib/tec_sol_facil_web/controllers/`, apresentando entre eles o arquivo `address_controller.ex`, onde serão executadas todas as requisições da minha API.

  * Nesse controller, temos duas funções de máxima importância, `show()` e `create()`, respectivamente, função `show()` recebe um **GET** do client, juntamente com o cep necessário para a requisição do mesmo, a função procurará no banco de dados o cep requisitado, e, caso o mesmo não seja encontrado, a função o criará utilizando a função  `create()`, e em seguida fazendo o processamento do banco de dados no Oban e renderizando na view o sucesso (ou erro) da requisição.

    - Os testes podem ser vistos por meio do comando:
    ```
    mix test "./test/tec_sol_facil_web/controllers/address_controller_test.exs" 
    ```

    - E as requisições por meio da rota:
    ```
    GET: localhost:4000/api/addresses/<cep>
    ```

  ## Parte 2:

  ### Criação de arquivo CSV contendo dados dos endereços:

  - Dentro de `./lib/tec_sol_facil/Oban/Exporters` foi criado o arquivo `csv_exporter.ex` que utiliza da lib [Oban](https://hexdocs.pm/oban/Oban.html) para realizar o processo assíncrono das tarefas a seguir sempre que a função `create()` do address_controller é chamada.

  - Dentro desse módulo, foi criada a função `perform()` que executa o worker do Oban sempre que o mesmo é chamado na função acima citada, criando o arquivo csv e passando todos os dados do banco de dados `addresses` e escrevendo-os em CSV.
