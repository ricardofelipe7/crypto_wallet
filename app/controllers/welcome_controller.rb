class WelcomeController < ApplicationController
  def index
    #session[:mensagem] = "Minha mensagem de teste! [session]"
    #cookies[:mensagem] = "Minha mensagem de teste! [cookies]"
    @meu_nome = params[:nome]
  end
end
