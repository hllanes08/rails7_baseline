class Users::SamlSessionController < Devise::SamlSessionsController
  after_action :store_winning_strategy, only: [:create]
  def new
    super
  end

  def create
    byebug
    super do |resource|
    end
  end

  def metadata
    super
  end

  private

  def store_winning_strategy
    warden.session(:user)[:strategy] = warden.winning_strategies[:user].class.name.demodulize.underscore.to_sym
  end
end
