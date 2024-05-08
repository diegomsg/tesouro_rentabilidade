# Tesouro Rentabilidade

Este repositório, **Tesouro Rentabilidade**, tem como objetivo calcular a rentabilidade de aplicações no **Tesouro Direto**. Para isso, utiliza os extratos mensais em formato **xlsxl**, que devem estar previamente salvos em uma pasta específica.


## Finalidade
A finalidade principal deste projeto é gerar um relatório em formato HTML, utilizando o pacote **quarto** para a linguagem R. O relatório apresentará informações detalhadas sobre a rentabilidade das aplicações no Tesouro Direto, permitindo uma análise completa e transparente.


## Uso
1. **Extratos Mensais**: Certifique-se de salvar os extratos mensais das suas aplicações no Tesouro Direto em uma pasta específica.
2. **Configuração**: No arquivo **config.yml**, defina o caminho da pasta onde os extratos estão armazenados.
3. **Execução**: Execute o script em R para processar os dados dos extratos e gerar o relatório em HTML.
4. **Análise**: Analise os resultados apresentados no relatório para tomar decisões informadas sobre suas aplicações no Tesouro Direto.

Lembre-se de manter os extratos atualizados e ajustar as configurações conforme necessário. Boa análise e bons investimentos! 📈💰


## config.yml
Arquivo **yaml** com as informações da pasta que contém os arquivos **xlsx** dos extratos e o início do nome do arquivo no formato:
```
extratos:
  folder: "caminho/para/extratos"
  start_name: "inicio do nome até o underline após o nome"
```

