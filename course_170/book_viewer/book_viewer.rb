require 'sinatra'
require 'sinatra/reloader' if development?
require 'tilt/erubis'

not_found do
  redirect "/"
end

helpers do
  def highlight(paragraph, search_term)
    paragraph.gsub(/#{search_term}/i) { |term| "<strong>#{term}</strong>" }
  end
end

before do
  @table_of_contents = File.readlines('data/toc.txt')
end

get "/" do
  @title = "Home"
  erb :home
end

get "/chapters/:number" do
  number = params[:number].to_i
  chapter_name = @table_of_contents[number - 1]
  @title = "Chapter #{number}: #{chapter_name}"

  @chapter = File.readlines("data/chp#{number}.txt", "\n\n")

  erb :chapters
end

get "/search" do
  @title = "Search"

  if params[:query] && params[:query].size > 0
    @results = @table_of_contents.each_with_index
                                 .each_with_object([]) do |(chapter, idx), results|
      paragraphs = File.readlines("data/chp#{idx + 1}.txt", "\n\n")
      paragraphs.each_with_index do |paragraph, paragraph_index|
        if paragraph.downcase.include?(params[:query].downcase)
          results << [chapter, idx, paragraph, paragraph_index]
        end
      end
    end
  end

  erb :search
end
