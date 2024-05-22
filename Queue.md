# O que é uma Queue no RabbitMQ?

- Uma queue (fila) é um componente fundamental no RabbitMQ que armazena mensagens até que sejam consumidas por um consumidor. As filas são usadas para desacoplar a produção e o consumo de mensagens, permitindo que os sistemas lidem melhor com variações na carga de trabalho.

## Principais Características de uma Queue

- **Persistência:** As filas podem ser configuradas para serem duráveis, significando que elas sobreviverão a reinicializações do servidor RabbitMQ. As mensagens podem também ser persistentes para não serem perdidas.

- **Exclusividade:** Uma fila exclusiva só pode ser consumida pela conexão que a declarou e é deletada quando essa conexão é fechada.

- **Auto-exclusão:** As filas auto-excluíveis (auto-delete) são deletadas automaticamente quando todos os consumidores são desconectados.

- **TTL (Time-To-Live):** As mensagens podem ter um TTL que define por quanto tempo elas permanecerão na fila antes de serem descartadas se não forem consumidas.

## Funcionamento Básico
 - **Declaração de Fila:** Antes de usar uma fila, ela deve ser declarada. Isso pode incluir especificar se a fila é durável, exclusiva ou auto-excluível.

 - **Publicação de Mensagens:** Mensagens são enviadas para a fila por exchanges baseadas nas regras de roteamento.

 - **Consumo de Mensagens:** Consumidores se conectam à fila e consomem mensagens. Uma vez consumida, a mensagem é removida da fila.


## Exemplo de Uso

- Publisher: Envia uma mensagem para uma exchange.

- Exchange: Roteia a mensagem para a fila apropriada.

- Queue: Armazena a mensagem até que um consumidor a processe.

- Consumer: Conecta-se à fila e consome a mensagem.

## Exemplo Visual
```text
Publisher -> Exchange -> Queue -> Consumer
```