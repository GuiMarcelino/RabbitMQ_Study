# O que é um Consumer no RabbitMQ?

- Um consumer (consumidor) em RabbitMQ é um processo que recebe e processa mensagens de uma fila. Os consumidores são essenciais para o funcionamento de sistemas de mensagens assíncronas, pois são responsáveis por pegar as mensagens que os publishers enviam para as filas e executar as ações necessárias com base no conteúdo dessas mensagens.

## Principais Características dos Consumers

**Registro do Consumidor:**

- Para começar a consumir mensagens, um consumidor deve ser registrado em uma fila específica.

- O registro é feito através do canal de comunicação com o RabbitMQ.

**Confirmação de Mensagens (Acknowledgment):**

- Manual Ack: O consumidor deve enviar manualmente uma confirmação (ack) ao RabbitMQ depois de processar uma mensagem. Isso garante que a mensagem não será perdida se o consumidor falhar ao processá-la.

- Auto Ack: As mensagens são automaticamente marcadas como confirmadas assim que são entregues ao consumidor. Isso pode ser arriscado porque as mensagens podem ser perdidas se o consumidor falhar antes de processá-las.

**Quality of Service (QoS):**

- Controla o número de mensagens não confirmadas que o RabbitMQ pode enviar a um consumidor antes de receber um ack. Isso é útil para garantir que os consumidores não sejam sobrecarregados.

- O prefetch count define o número máximo de mensagens não confirmadas que o consumidor pode ter ao mesmo tempo.

**Rejeição de Mensagens:**

- Os consumidores podem rejeitar mensagens. As mensagens rejeitadas podem ser redirecionadas para uma fila de mensagens mortas (DLX) ou descartadas, dependendo da configuração.

## Exemplo de Funcionamento de um Consumer, fluxo de trabalho:

- Conexão e Canal: O consumidor estabelece uma conexão com o RabbitMQ e cria um canal.

- Registro: O consumidor se registra em uma fila para começar a receber mensagens.

- Recepção e Processamento: O consumidor recebe mensagens e as processa conforme a lógica de negócio.

- Confirmação: O consumidor confirma a mensagem (manual ou automaticamente) para informar ao RabbitMQ que a mensagem foi processada com sucesso.