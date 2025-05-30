# dio-recurso-data-factory-azure
## demonstração de projeto que usa o recurso do data factory do azure

#### Os conceitos e resumo foram retirados da leitura da documentação oficial <https://learn.microsoft.com/pt-br/azure/data-factory/>

### Azure Data Factory: O Orquestrador de Dados na Nuvem
- O Azure Data Factory (ADF) é um serviço de integração de dados baseado em nuvem, totalmente gerenciado e sem servidor, oferecido pela Microsoft Azure. Ele atua como um orquestrador de fluxos de trabalho ETL/ELT (Extract, Transform, Load / Extract, Load, Transform), permitindo que as organizações criem, agendem e monitorem pipelines de dados que movem e transformam dados entre diversos armazenamentos e serviços de computação, tanto no Azure quanto em ambientes híbridos (on-premises). Em sua essência, o ADF não processa ou armazena dados por si só; ele coordena a movimentação e a transformação. Pense nele como o maestro de uma orquestra de dados, que garante que cada instrumento (serviço de computação, armazenamento) toque no momento certo para produzir a sinfonia final (dados transformados e prontos para uso). O Azure Data Factory é uma ferramenta poderosa e essencial para qualquer estratégia de dados moderna na nuvem, permitindo que as organizações construam pipelines de dados robustos, escaláveis e automatizados para transformar dados brutos em insights valiosos. Ele é a espinha dorsal para muitas arquiteturas de Data Lake e Data Warehousing no Azur

### Principais Conceitos e Componentes do Azure Data Factory
- Pipeline: O coração do ADF. Um pipeline é um agrupamento lógico de atividades (Activities). Ele define o fluxo de trabalho de dados, ou seja, a sequência de operações que serão realizadas para atingir um objetivo de integração de dados. Por exemplo, um pipeline pode extrair dados, depois transformá-los e, finalmente, carregá-los em um destino.
- Activities (Atividades): Representam os passos de processamento dentro de um pipeline. O ADF oferece uma vasta gama de atividades, categorizadas em:
  * Atividades de Movimentação de Dados: Como a atividade Copy Data (a mais comum), que permite mover dados entre mais de 90 conectores built-in.
  * Atividades de Transformação de Dados: Ativam serviços de computação externos para transformar dados. Exemplos incluem atividades para executar notebooks do Azure Databricks, procedimentos armazenados do Azure SQL Database, funções do Azure Function, scripts do Azure HDInsight (Hive, Pig, Spark), etc.
  * Atividades de Fluxo de Controle: Permitem a lógica de programação dentro do pipeline, como If Condition, For Each, Wait, Until, Web, Lookup, Get Metadata, entre outras, para construir fluxos de trabalho complexos e dinâmicos.
- Datasets: Representam a estrutura dos dados dentro dos armazenamentos de dados. Eles apontam para dados que você deseja usar como entrada ou saída em suas atividades. Um Dataset especifica a localização e o formato dos dados (e.g., uma tabela SQL, um arquivo CSV em um Blob Storage, uma pasta em um Data Lake).
- Linked Services (Serviços Vinculados): Atuam como strings de conexão. Eles definem as informações de conexão para os armazenamentos de dados externos (como Azure Blob Storage, Azure SQL Database, Salesforce, Oracle, etc.) ou para os serviços de computação que o ADF utilizará (como Azure Databricks, Azure HDInsight). Um Linked Service estabelece a ponte entre o Data Factory e os recursos externos.
- Data Flows (Fluxos de Dados de Mapeamento): Um recurso visual e sem código (ou com código mínimo) para transformar dados em escala. Ele permite aos engenheiros de dados construir lógicas de transformação complexas sem escrever código. Os Fluxos de Dados são executados em clusters do Azure Databricks ou Spark (gerenciados internamente pelo ADF), abstraindo a complexidade do Spark. Ótimo para transformações de dados mais complexas e interativas.
- Integration Runtime (IR): O "motor" que o ADF usa para executar as atividades. Existem três tipos:
  * Azure IR: Para conectar a serviços de dados em rede pública ou privada (usando VNet). É totalmente gerenciado pela Microsoft.
  * Self-Hosted IR: Para conectar a dados em redes privadas (on-premises ou VMs em rede privada) ou que não podem ser acessados via rede pública. Você instala e gerencia este IR em uma máquina virtual ou on-premises.
  * Azure-SSIS IR: Para executar pacotes SSIS (SQL Server Integration Services) na nuvem, permitindo a migração lift-and-shift de workloads SSIS existentes para o Azure.
- Triggers (Disparadores): Definem quando um pipeline deve ser executado. Os tipos comuns incluem:
  * Schedule Trigger: Executa o pipeline em um horário agendado (por exemplo, a cada hora, diariamente).
  * Tumbling Window Trigger: Para agendamentos em janelas de tempo discretas e contíguas.
  * Event-Based Trigger: Dispara o pipeline em resposta a eventos no armazenamento de dados (por exemplo, a chegada de um novo arquivo em um Blob Storage).
  * Manual Trigger: Para execução sob demanda.

### Benefícios do Azure Data Factory
- Serverless e Gerenciado: Não há servidores para provisionar ou gerenciar, o que simplifica a operação e reduz o overhead administrativo. A Microsoft cuida da infraestrutura subjacente, escala e manutenção.
- Escalabilidade e Elasticidade: O ADF pode escalar automaticamente para lidar com grandes volumes de dados e cargas de trabalho variadas.
- Ampla Conectividade: Suporte nativo para mais de 90 conectores, facilitando a integração com quase qualquer fonte ou destino de dados.
- Desenvolvimento Visual: O ADF Studio (interface gráfica no Portal do Azure) oferece uma experiência de arrastar e soltar (drag-and-drop) para construir pipelines sem código ou com código mínimo, tornando-o acessível para diferentes perfis de usuários.
- Integração com o Ecossistema Azure: Profunda integração com outros serviços Azure, como Azure Synapse Analytics, Azure Databricks, Azure Functions, Azure Monitor, Azure Key Vault, etc.
- Monitoramento Abrangente: Ferramentas de monitoramento e alertas integradas para rastrear o status das execuções de pipeline e identificar problemas.
- Custo-Efetivo: O modelo de precificação baseado no consumo (paga-se pelo que usa) o torna econômico, especialmente para cargas de trabalho intermitentes ou que variam em escala.
- Capacidades de IaC (Infrastructure as Code): Como demonstrado, o ADF é totalmente compatível com ferramentas de IaC (ARM templates, Terraform), o que é crucial para ambientes de produção, CI/CD e governança.

### Desafios e Considerações sobre a tecnologia:
- Curva de Aprendizagem: Embora a interface visual seja intuitiva, dominar todos os componentes e as melhores práticas pode levar tempo.
- Depuração: Pipelines complexos podem ser desafiadores para depurar, especialmente com atividades que falham em serviços externos.
- Gerenciamento de Credenciais: Embora o ADF se integre com o Azure Key Vault, o gerenciamento seguro de credenciais para todas as conexões requer planejamento.
- Custos: Embora seja de pagamento por uso, o custo pode crescer com o volume e a complexidade das operações. Um monitoramento cuidadoso é recomendado.

### Cenários de Uso Comuns para o Azure Data Factory: o ADF é extremamente versátil e é usado em uma ampla gama de cenários de integração de dados.
- ETL/ELT para Data Warehousing: Coletar dados de várias fontes (bancos de dados transacionais, SaaS, arquivos), limpá-los, transformá-los e carregá-los em um Data Warehouse (como Azure Synapse Analytics) ou Data Lake para fins de relatórios e análise.
- Migração de Dados: Mover grandes volumes de dados de sistemas on-premises para o Azure ou entre diferentes serviços do Azure.
- Preparação de Dados para Machine Learning: Ingerir, limpar e transformar dados brutos para criar conjuntos de dados de treinamento e inferência para modelos de Machine Learning.
- Ingestão de Dados em Tempo Quase Real: Usar Triggers baseados em eventos para processar novos dados assim que eles chegam (e.g., arquivos de log, dados de IoT).
- Processamento de Dados de Big Data: Orquestrar workloads complexos que envolvem serviços como Azure Databricks, Azure HDInsight ou Azure Synapse Spark para processamento de grandes volumes de dados.
- Integração de Dados Híbridos: Conectar-se e mover dados entre data centers on-premises e a nuvem Azure usando o Self-Hosted Integration Runtime.
- Modernização de Pipelines SSIS: Migrar e executar pacotes SSIS existentes na nuvem usando o Azure-SSIS Integration Runtime.

### Cenário de demonstração
- Uma empresa possui dados de vendas brutos armazenados em um Azure Data Lake Storage Gen2 (uma pasta de "landing zone"). O Azure Data Factory será usado para orquestrar essa pipeline de dados. A criação de toda essa infraestrutura (Resource Group, Data Lake, Data Factory e os componentes do ADF) será feita com Terraform, reforçando o propósito de IaC: automação, repetibilidade e consistência. Ela precisa de um processo ETL (Extract, Transform, Load) para:
  * Extrair esses dados brutos do Data Lake.
  * Realizar uma transformação simples (por exemplo, copiar sem alteração, mas o ADF pode fazer transformações complexas).
  * Carregar os dados processados em outra pasta dentro do mesmo Data Lake Storage Gen2 (uma pasta de "curated data").

### Este exemplo de Terraform irá:
- Criar um Grupo de Recursos.
- Criar uma conta de Armazenamento (Data Lake Storage Gen2 habilitado).
- Criar dois contêineres/sistemas de arquivos dentro do Data Lake: rawdata e processeddata.
- Criar uma instância do Azure Data Factory.
- Criar um Linked Service no ADF para conectar ao Data Lake Storage.
- Criar dois Datasets no ADF: um para os dados brutos (rawdata) e outro para os dados processados (processeddata).
- Criar um Pipeline simples no ADF que copia dados de rawdata para processeddata.

### Como executar este código Terraform:
- Pré-requisitos:
  * Ter uma conta Azure ativa e permissões para criar recursos.
  * Ter o Azure CLI ou Azure PowerShell instalado e autenticado (az login ou Connect-AzAccount).
  * Ter o Terraform CLI instalado (baixe em terraform.io).
- Crie os arquivos: Crie os arquivos main.tf, variables.tf e outputs.tf em uma pasta vazia.
- Ajuste os nomes: No variables.tf, mude os valores padrão para storage_account_name e data_factory_name para algo único, pois esses nomes precisam ser globalmente únicos no Azure.
- Inicialize o Terraform: Abra um terminal na pasta onde você salvou os arquivos e execute: `terraform init`
- Plano de Execução: Visualize o que o Terraform irá criar sem realmente aplicá-lo: `terraform plan`
- Aplicar a Configuração: Se o plano estiver OK, aplique a configuração: `terraform apply`

### Propósito de Uso do Terraform
- Automação: Com um único comando (terraform apply), toda a infraestrutura de dados é provisionada, eliminando a necessidade de cliques manuais e reduzindo erros.
- Repetibilidade: Você pode destruir (terraform destroy) e recriar todo o ambiente de dados com os mesmos comandos, garantindo que o ambiente de desenvolvimento seja idêntico ao de produção ou teste.
- Consistência: Garante que todos os ambientes (dev, stage, prod) sejam configurados exatamente da mesma maneira.
- Controle de Versão: Os arquivos .tf podem ser armazenados em um sistema de controle de versão (como esse repositório github), permitindo rastrear mudanças, colaborar em equipes e reverter para versões anteriores.
- Documentação Viva: O código Terraform serve como uma documentação precisa e atualizada da sua infraestrutura.
- Recuperação de Desastres: Em caso de falha catastrófica, você pode recriar rapidamente sua infraestrutura de dados a partir do código.

### Após a Implantação
- Você pode acessar o URL de saída do data_factory_url para ir diretamente para a sua instância do ADF no Portal do Azure.
- No Data Lake Storage, você verá os contêineres rawdata e processeddata.
- Para testar o pipeline, você precisaria fazer upload de um arquivo CSV chamado sales_data.csv (com alguns dados de exemplo) para o contêiner rawdata no seu Data Lake Storage.
- No Azure Data Factory Studio, vá para a seção "Author" -> "Pipelines" e você verá o pipeline CopySalesPipeline.
- Você pode acionar ("Trigger") o pipeline manualmente e, após a execução bem-sucedida, o arquivo processed_sales_data.csv aparecerá no contêiner processeddata.
