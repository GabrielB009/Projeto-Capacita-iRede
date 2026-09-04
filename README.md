# AWS Capacita iRede

Projeto desenvolvido para a atividade **Desenvolvimento de Projeto (AVANÇADO)** — Código **U6C1O3T1**.

## 1. Objetivo

Construir uma infraestrutura na AWS utilizando **Terraform**, com uma API hospedada em uma instância EC2, processamento assíncrono de pedidos por meio do Amazon SQS e processamento pela AWS Lambda, com registro dos eventos no Amazon CloudWatch Logs.

## 2. Arquitetura

O fluxo da aplicação é:

```text
Usuário
   │
   ▼
API na EC2
   │
   ▼
Amazon SQS
   │
   ▼
AWS Lambda
   │
   ▼
CloudWatch Logs
```

A API possui dois endpoints principais:

* `GET /products` — retorna a lista de produtos.
* `POST /orders` — cria um pedido e envia a mensagem para a fila SQS.

## 3. Serviços utilizados

* **Amazon VPC** — rede da aplicação.
* **Subnet pública** — permite acesso à instância EC2.
* **Internet Gateway** — comunicação com a Internet.
* **Route Table** — rota da subnet pública.
* **Security Group** — regras de acesso à EC2.
* **Amazon EC2** — hospedagem da API.
* **Amazon SQS** — fila para processamento dos pedidos.
* **AWS Lambda** — processamento das mensagens.
* **Amazon CloudWatch Logs** — registro da execução da Lambda.
* **Terraform** — provisionamento da infraestrutura.

## 4. Estrutura do projeto

```text
capacita-irede/
├── api/
│   ├── package.json
│   ├── package-lock.json
│   └── server.js
│
├── terraform/
│   ├── provider.tf
│   ├── variables.tf
│   ├── vpc.tf
│   ├── security.tf
│   ├── ec2.tf
│   ├── iam.tf
│   ├── sqs.tf
│   ├── lambda.tf
│   ├── lambda_iam.tf
│   ├── lambda_sqs.tf
│   └── outputs.tf
│
├── .gitignore
└── README.md
```

## 5. Execução do Terraform

Entrar no diretório do Terraform:

```bash
cd ~/capacita-irede/terraform
```

Inicializar o Terraform:

```bash
terraform init
```

Verificar o plano de execução:

```bash
terraform plan
```

Aplicar a infraestrutura:

```bash
terraform apply
```

Após a aplicação, os principais outputs são:

```text
ec2_public_ip
sqs_queue_url
```

## 6. Acesso à API

A aplicação é executada na porta `3000`.

### Produtos

```text
GET http://3.145.118.83:3000/products
```

Exemplo de resposta:

```json
[
  {
    "id": 1,
    "name": "Notebook",
    "price": 3500
  },
  {
    "id": 2,
    "name": "Mouse",
    "price": 100
  },
  {
    "id": 3,
    "name": "Teclado",
    "price": 200
  }
]
```

### Criar pedido

```text
POST http://3.145.118.83:3000/orders
```

Exemplo de corpo:

```json
{
  "productId": 3,
  "quantity": 1
}
```

A API retorna:

```text
Pedido enviado para processamento
```

## 7. Fluxo de processamento do pedido

1. O usuário envia um pedido para a API.
2. A API recebe os dados do produto e da quantidade.
3. A API envia o pedido para a fila `pedidos-a-processar`.
4. A AWS Lambda é acionada automaticamente pela fila.
5. A Lambda registra o pedido no CloudWatch Logs.

## 8. Evidências

### 8.1 API — consulta de produtos

A API foi testada com o endpoint `/products`, retornando os produtos cadastrados.

**Evidência:** captura de tela do teste da API.

### 8.2 API — criação do pedido

Foi realizado um pedido utilizando:

```json
{
  "productId": 3,
  "quantity": 1
}
```

A API confirmou o envio do pedido para processamento.

**Evidência:** captura de tela do teste do endpoint `/orders`.

### 8.3 Amazon SQS

A fila `pedidos-a-processar` registrou uma mensagem enviada e uma mensagem recebida/processada.

**Evidência:** captura de tela do gráfico do SQS.

### 8.4 AWS Lambda e CloudWatch

A Lambda recebeu o pedido e registrou a mensagem nos logs:

```text
Pedido recebido: {"productId":3,"quantity":1}
```

**Evidência:** captura de tela do CloudWatch Logs.

### 8.5 Terraform

A infraestrutura foi validada com:

```bash
terraform plan
```

Resultado:

```text
No changes. Your infrastructure matches the configuration.
```

**Evidência:** captura de tela do Terraform.

## 9. Destruição da infraestrutura

Após a conclusão da atividade e o registro de todas as evidências, a infraestrutura pode ser removida com:

```bash
terraform destroy
```

> O comando `terraform destroy` deve ser executado somente após a conclusão e o envio do projeto.
