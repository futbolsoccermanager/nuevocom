class HomeController < ApplicationController

  before_filter :feeds, :only => [:index]

  def index

  end

  def prueba
    @equipos = Equipo.all

    respond_to do |format|
      format.json {render :json => @equipos}
      format.html
    end
  end

  def prueba_post
    @params = params
    respond_to do |format|
      format.json {render :json => @params}
      format.js
    end
  end

  def hablandoencuero
    @articulo = Feedzirra::Feed.fetch_and_parse("#{Settings.feeds.blogs.hc}").entries.first rescue nil
  end

  private

    def feeds
      @feed_hec = Rails.cache.fetch("feed_hec")
      unless @feed_hec.present?
        @feed_hec = Feedzirra::Feed.fetch_and_parse("#{Settings.feeds.blogs.hc}") rescue nil
        Rails.cache.write("feed_hec", @feed_hec, :expires_in => 20.minutes)
      end
      @feed_marca = Rails.cache.fetch("feed_marca")
      unless @feed_marca.present?
        @feed_marca = Feedzirra::Feed.fetch_and_parse("#{Settings.feeds.blogs.marca}") rescue nil
        Rails.cache.write("feed_marca", @feed_marca, :expires_in => 20.minutes)
      end
    end

end
