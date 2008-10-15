require 'test_helper'

class IdeaTest < ActiveSupport::TestCase

  def test_load_new_ideas
    assert( Idea.find_from_twitter.any? )
  end
  
  def test_loaded_ideas_are_ideas
    myarray = Idea.find_from_twitter
    #test array has ideas
    myarray.each do |thething|
      #is thething an idea?
      assert thething.is_a?(Idea)
    end
  end
  
  def test_loaded_ideas_should_have_a_text
    ideas = Idea.find_from_twitter
    ideas.each do |idea|
      assert_not_nil idea.text
    end
  end
  
  def test_load_ideas_from_gregbell
    ideas = Idea.find_from_twitter
    ideas.each do |idea|
      assert_not_nil idea.poster
    end
  end
  
  def test_load_ideas_from_a_specific_twitter_user
    ideas = Idea.find_from_twitter_for "gregbell"
    ideas.each do |idea|
      assert_equal "gregbell", idea.poster
    end
  end
  
  def test_ideas_have_votes
    idea = Idea.new
    assert( idea.respond_to?( :vote_up ))
  end
  
  def test_ideas_increase_votes
    idea = Idea.new
    assert_equal 0, idea.votes
    idea.vote_up
    assert_equal 1, idea.votes
  end
  
  def test_votes_are_saved
    idea = create_valid
    idea.vote_up
    idea.vote_up
    idea.reload
    assert_equal( 2, idea.votes )
  end
  
  def test_should_require_a_text
    assert_not_nil Idea.create.errors.on(:text)
  end
  
  def test_should_require_a_poster
    assert_not_nil Idea.create.errors.on(:poster)
  end
  
  private
  
  def create_valid(args={})
    Idea.create({
      :text => "My Great Idea",
      :poster => 'Nik_at_nike_dot_ca'
    }.merge!(args))
  end
  
end
