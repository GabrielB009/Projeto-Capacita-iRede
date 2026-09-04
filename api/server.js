const express = require("express");
const { SQSClient, SendMessageCommand } = require("@aws-sdk/client-sqs");

const app = express();
app.use(express.json());

const sqs = new SQSClient({
  region: "us-east-2"
});

const QUEUE_URL =  "https://sqs.us-east-2.amazonaws.com/251251171694/pedidos-a-processar"

const products = [
  { id: 1, name: "Notebook", price: 3500 },
  { id: 2, name: "Mouse", price: 100 },
  { id: 3, name: "Teclado", price: 200 }
];

app.get("/products", (req, res) => {
  res.json(products);
});

app.post("/orders", async (req, res) => {
  const { productId, quantity } = req.body;

  const order = {
    productId,
    quantity
  };

  try {
    await sqs.send(new SendMessageCommand({
      QueueUrl: QUEUE_URL,
      MessageBody: JSON.stringify(order)
    }));




    res.status(201).json({
      message: "Pedido enviado para processamento",
      order
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({
      message: "Erro ao enviar pedido para SQS"
    });
  }
});




app.listen(3000, () => {
  console.log("API rodando na porta 3000");
});
