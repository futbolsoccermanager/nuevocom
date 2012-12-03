class HomeController < ApplicationController
  def index
    @feed_hec = Feedzirra::Feed.fetch_and_parse("http://hablandoencuero.blogspot.com.es/feeds/posts/default") rescue nil
    @feed_marca = Feedzirra::Feed.fetch_and_parse("http://marca.feedsportal.com/rss/futbol_1adivision.xml") rescue nil

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
    @articulo = Feedzirra::Feed.fetch_and_parse("http://hablandoencuero.blogspot.com.es/feeds/posts/default").entries.first rescue nil
  end
end
