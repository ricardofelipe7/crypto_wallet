namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      spinner = TTY::Spinner.new("[:spinner] Apagando DB...")
      spinner.auto_spin
      %x(rails db:drop)
      spinner.success("Concluído com sucesso!")
      spinner = TTY::Spinner.new("[:spinner] Criando DB...")
      spinner.auto_spin
      %x(rails db:create)
      spinner.success("Concluído com sucesso!")
      spinner = TTY::Spinner.new("[:spinner] Fazendo a migração...")
      spinner.auto_spin
      %x(rails db:migrate)
      spinner.success("Concluído com sucesso!")
      spinner = TTY::Spinner.new("[:spinner] Carregando pré-configurações...")
      spinner.auto_spin
      %x(rails db:seed)
      spinner.success("Concluído com sucesso!")
    else
      puts 'Vocẽ não está em ambiente de desenvolvimento!'
    end
  end

end
