require 'sinatra'
require_relative 'questions'


set :public_folder, 'public'

class Eliza < Sinatra::Base
  @@questions = {}
  QUESTIONS.each do |keywords, answers|
    keywords.each do |keyword|
      @@questions[keyword.downcase] = answers
    end
  end

  p @@questions.inspect

  @@page = '''<!DOCTYPE html>
  <html>
  <head>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-2.1.3.min.js"></script>
    <script src="eliza.js"></script>
      <title>Eliza</title>
  </head>
  <body>
  <div class="container">
    <div class="row">
      <h1>~~~</h1>
      <form action="/responding" method="post">
        <label for="respondness">Please say something</label>
        <input type="text" name="respondness">
        <button type="submit">OK</button>
      </form>
    </div>
  </div>
  </body>
  </html>'''
  get '/' do
    redirect '/index.html'
  end

  post '/responding' do
    res = params['respondness']

    words = res.strip.split(/\s+/)
    possible_answers = []
    words.each do |word|
      if (answer = @@questions[word.downcase])
        possible_answers += answer
      end
    end
    if possible_answers.length > 0
      return @@page.gsub('~~~', possible_answers.sample)
    else
      return @@page.gsub('~~~', ANSWERS.sample)
    end
  end

  post '/eliza' do
    possible_answers = []
    query = params['query'].strip.split(/\s+/)
    query.each do |word|
      if (answer = @@questions[word.downcase])
        possible_answers += answer
      end
    end
    if possible_answers.length > 0
      return possible_answers.sample
    else
      return ANSWERS.sample
    end
  end
end
