namespace :dev do
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
    if Rails.env.development?
      show_spinner("Apagando BD...") { %x(rails db:drop) }
      show_spinner("Criando BD...") { %x(rails db:create) }
      show_spinner("Fazendo a migração...") { %x(rails db:migrate) }
      %x(rails dev:add_coins)
      %x(rails dev:add_mining_types)
    else
      puts 'Vocẽ não está em ambiente de desenvolvimento!'
    end
  end

  desc "Cadastra as moedas"
  task add_coins: :environment do
    show_spinner("Cadastrando moedas...") do
    coins = [
      {description: "Bitcoin",
      acronym: "BTC",
      url_image: "https://w7.pngwing.com/pngs/450/133/png-transparent-bitcoin-cryptocurrency-virtual-currency-decal-blockchain-info-bitcoin-text-trademark-logo.png"
      },
      {
      description: "Ethereum",
      acronym: "ETH",
      url_image: "https://png.pngtree.com/png-vector/20210427/ourmid/pngtree-ethereum-cryptocurrency-coin-icon-png-image_3246438.jpg"
      },
      {
      description: "Dash",
      acronym: "DASH",
      url_image: "https://s2.coinmarketcap.com/static/img/coins/200x200/131.png"}
      ]
    coins.each { |coin| Coin.find_or_create_by!(coin) }
    end
  end

  desc "Cadastra os tipos de mineração"
  task add_mining_types: :environment do
    show_spinner("Cadastrando tipos de mineração...") do
      mining_types = [
        { description: "Proof of work", acronym:"PoW"},
        { description: "Proof of Stake", acronym:"PoS"},
        { description: "Proof of Capacity", acronym:"PoC"}
      ]
    mining_types.each { |mining_type| MiningType.find_or_create_by!(mining_type) }
    end
  end


  private
  def show_spinner(msg_start, msg_end="Concluido!")
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success(msg_end)
  end
end
