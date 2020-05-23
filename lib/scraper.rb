require 'nokogiri'
require 'open-uri'
require 'pry'
#must require these up top
require_relative './course.rb' #we are requiring our couse class file so that the scraer can make new courses

class Scraper

  def print_courses
   self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

  def get_page
  doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
#doc.css(".post").first.css("(this is where the class selector goes like h2 or date)").text #select the post class using a css selector with the .css and take the whole thing from
#variable which is doc which is set to the html link

#doc.css(".post").each do |post|
      #course = Course.new #making a new instance of the course class
    #  course.title = post.css("h2").text #give that instnace a title for the h2 text, web development immerseive
    #  course.schedule = post.css(".date").text
    #  course.description = post.css("p").text
    #  binding.pry
    #   end
  end

  def get_courses
    self.get_page.css(".post")
  end

  def make_courses
  self.get_courses.each do |post|
    course = Course.new
    course.title = post.css("h2").text
    course.schedule = post.css(".date").text
    course.description = post.css("p").text
  end
  end
end
