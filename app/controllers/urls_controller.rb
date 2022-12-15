class UrlsController < ApplicationController
  def index
    @url = Url.new
  end

  def show
    @urls = Url.all.order(created_at: :desc).uniq
  end

  def create
    name = permitted_params.as_json["name"]

    url = Url.where(name: name, is_active: true)
  
    if url.present?
      shortened_url = get_shortened_url(url)
      flash[:success] = "<p class='mb-1'>Here is your URL!</p><a href='#{shortened_url}'>#{shortened_url}</a>"
    else
      get_new_url
    end

    redirect_to root_path
  end
  

  private

  def get_new_url 
    url = Url.new permitted_params
    
    if url.save
      shortened_url = url.shortened
      flash[:success] = "<p class='mb-1'>URL successfully saved!</p><a href='#{shortened_url}'>#{shortened_url}</a>"
    else
      flash[:error] = "<p class='mb-1'>Your URL could not be saved due to the following reasons: <br /> #{url.errors.full_messages.join(', ')}</p>"
    end
  
    expiration = url.created_at + 1.month
    
    expiration <=Time.now  ? is_active = false : is_active = true
    slug = url.shortened.partition('?').last
    
    url.update(slug: slug ,expiration: expiration, is_active: is_active)

  end

  def get_shortened_url(url)
    slug = url.as_json[0]["slug"]
    "http://localhost:3000/r?#{slug}"
  end
  
  def permitted_params
    params.require(:url).permit(:name)
  end
end
