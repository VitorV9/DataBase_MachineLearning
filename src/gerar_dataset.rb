require 'json'

# 1. Ler o arquivo JSON e transformar em um array do Ruby
dados = JSON.parse(File.read('src/dataset.json'))

# 2. Abrir o arquivo .arff para escrita na raiz do projeto
File.open('dados_trabalho.arff', 'w:UTF-8') do |f|
  # Escreve o cabeçalho padrão do Weka
  f.puts "@relation desinformacao_ia\n\n"
  f.puts "@attribute texto string"
  f.puts "@attribute classe {Fake, Fato}\n\n"
  f.puts "@data"

  # 3. Percorrer os dados e salvar no formato do Weka
  dados.each do |item|
    # Limpeza básica de aspas e quebras de linha para o Weka não herdar bugs
    texto_limpo = item['texto'].gsub("'", "").gsub('"', "").gsub('\\', "").gsub("\n", " ")
    # Cospe a linha formatada: 'Texto da noticia',Classe
    f.puts "'#{texto_limpo}',#{item['classe']}"
  end
end

puts "Arquivo 'dados_trabalho.arff' gerado com sucesso!"