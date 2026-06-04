require 'json'

dados = JSON.parse(File.read('src/dataset.json'))

File.open('dados_trabalho.arff', 'w:UTF-8') do |f|
  f.puts "@relation desinformacao_ia\n\n"
  f.puts "@attribute texto string"
  f.puts "@attribute classe {Fake, Fato}\n\n"
  f.puts "@data"

  dados.each do |item|
  texto_limpo = item['texto'].gsub(/['"\\’“”]/, '').gsub(/[\n\r]/, ' ') .gsub(/\s+/, ' ')     
  f.puts "'#{texto_limpo.strip}',#{item['classe'].strip}"
  end
end

puts "Arquivo 'dados_trabalho.arff' gerado com sucesso!"