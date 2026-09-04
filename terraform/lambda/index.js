exports.handler = async (event) => {
  for (const record of event.Records) {
    console.log("Pedido recebido:", record.body);
  }

  return { statusCode: 200 };
};
