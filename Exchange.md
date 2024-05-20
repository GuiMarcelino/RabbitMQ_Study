# O que é Exchange?

- Uma exchange é um componente fundamental no RabbitMQ que recebe mensagens de publishers e as encaminha para filas de acordo com regras específicas de roteamento. A exchange não armazena mensagens; sua função principal é determinar para quais filas as mensagens devem ser enviadas.

# Tipos de Exchanges:

### Direct Exchange:

- Roteamento Direto: As mensagens são roteadas para as filas cuja binding key corresponde exatamente à routing key da mensagem.

**Exemplo:**
 
 - Exchange: direct_logs

 - Filas: info_queue (binding key: info), error_queue (binding key: error)

 - Mensagem 1: { routing key: 'info', message: 'Info log message' }

 - Mensagem 2: { routing key: 'error', message: 'Error log message' }

**Funcionamento:**

 - Mensagem 1 é roteada para info_queue.
 - Mensagem 2 é roteada para error_queue.

**Resumo Visual e Explicativo**

 - Mensagem com routing key "info" vai para info_queue.
 - Mensagem com routing key "error" vai para error_queue.

        Direct Exchange: direct_logs

        | Routing Key |   Queue    |
        |-------------|------------|
        | info        | info_queue |
        | error       | error_queue|


### Fanout Exchange:

 - **Broadcasting:** As mensagens são enviadas para todas as filas ligadas à exchange, independentemente da routing key.

 **Exemplo:**
 
 - Exchange: broadcast_logs

 - Filas: queue1, queue2, queue3

 - Mensagem: { routing key: '', message: 'Broadcast message' }

**Funcionamento:**

 - A mensagem é enviada para queue1, queue2 e queue3.

**Resumo Visual e Explicativo**

 - Todas as mensagens são enviadas para queue1, queue2, e queue3.

        Fanout Exchange: broadcast_logs

        | Queue   |
        |---------|
        | queue1  |
        | queue2  |
        | queue3  |

### Topic Exchange:

 - **Roteamento com Padrões:** As mensagens são roteadas com base em padrões (wildcards) da routing key.

 **Exemplo:**
 
 - Exchange: topic_logs

 - Filas: kern_queue (binding key: kern.*), critical_queue (binding key: *.critical)

 - Mensagem 1: { routing key: 'kern.critical', message: 'Kernel critical error' }

 - Mensagem 2: { routing key: 'app.critical', message: 'Application critical error' }

**Funcionamento:**

 - Mensagem 1 é roteada para kern_queue e critical_queue.

 - Mensagem 2 é roteada para critical_queue.

**Resumo Visual e Explicativo**

 - Mensagem com routing key "kern.critical" vai para kern_queue e critical_queue.

 - Mensagem com routing key "app.critical" vai para critical_queue.

        Topic Exchange: topic_logs

        | Binding Key   |   Queue          |
        |---------------|------------------|
        | kern.*        | kern_queue       |
        | *.critical    | critical_queue   |


### Headers Exchange:

 - **Roteamento por Cabeçalhos:** As mensagens são roteadas com base em cabeçalhos em vez de routing keys.

 **Exemplo:**
 
 - Exchange: header_logs

 - Filas: header_queue1 (cabeçalhos: {format: "pdf", type: "report"}), header_queue2 (cabeçalhos: {format: "json"})

 - Mensagem 1: { headers: {format: "pdf", type: "report"}, message: 'PDF Report' }

 - Mensagem 2: { headers: {format: "json", type: "log"}, message: 'JSON Log' }

**Funcionamento:**

 - Mensagem 1 é roteada para header_queue1.

 - Mensagem 2 é roteada para header_queue2.

**Resumo Visual e Explicativo**

 - Mensagem com cabeçalhos {format: "pdf", type: "report"} vai para header_queue1.

 - Mensagem com cabeçalhos {format: "json"} vai para header_queue2.

        Headers Exchange: header_logs

        | Header Conditions               |   Queue       |
        |---------------------------------|---------------|
        | {format: "pdf", type: "report"} | header_queue1 |
        | {format: "json"}                | header_queue2 |
