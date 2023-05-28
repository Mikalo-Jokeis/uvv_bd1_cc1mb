# Banco de Dados
## PSET 1
### Aluno: Michel Gonçalves Salles
### Turma: CC1MB
### Professor: Abrantes Araújo Silva Filho
### Monitora: Suellen Miranda Amorim
# Introdução
O intuito desse trabalho é implementar o projeto lógico "Lojas UVV", utilizado na 1ª avaliação bimestral, no PostgreSQL.
Para isso usei o SQL Power Architect para replicar o projeto lógico (Lojas UVV) no padrão do PostgreSQL, e em seguida foi feita a implementação dele no PostgreSQL.
## Implementação do projeto lógico
- Para fazer a implementação do projeto lógico tive que fazer mudanças em alguns tipos de dados, pois não era possível utilizar os mesmos tipos de dados, já que o diagrama disponibilizado para o trabalho era do Oracle e esse diagrama tinha que ser implementado no PostgreSQL.
- Utilizei o diagrama do projeto e recriei o diagrama relacional no SQL Power Architect para o POstgresSQL.
- Criei comentários para o dicionário de dados, porém apenas para as colunas e tabelas.
- Após isso salvei o arquivo do projeto no formato do SQL Power ARchitect para colocar neste repositório do GitHub, juntamente com o seu formato em PDF.
## Implementação no PostgreSQL
- Agora tinha que criar um usuário específico para ser o dono do banco de dados que foi criado (uvv).
- Depois de criar o usuário michel, tinha-se que fazer login no PostgreSQL com esse usuário e criar o banco de dados "uvv" para a implementação do projeto. Além disso utilizei como parâmetros os valores que foram indicados no arquivo PDF do PSET para a criação do banco de dados.
- Após criar o banco de dados tinha-se que fazer uma conexão a esse banco com o usuário criado, e após me conectar criei o esquema "lojas" para armazenar todos os objetos que foram criados com a implementação do projeto lógico, e dei a autorização ao usuário criado (michel) a utilizar esse esquema.
- Embora tenha sido criado o esquema "lojas" o esquema padrão ainda é o "public", então foi feito um ajuste para que o esquema "lojas" se torne o padrão.
- Agora é preciso implementar o projeto lógico do banco de dados Lojas UVV. Então eu criei o restante dos comentários para o dicionário de dados, no caso para as constraints e para o banco de dados. Além disso fiz ajustes na ordem do script sql e documentei cada sessão do script. Criei as restrições de checagem pedidas para o PSET e outras adicionais, como por exemplo para a coluna email e para a coluna nome.
- Após isso salvei o arquivo com a extensão .sql e coloquei neste repositório do GitHub
