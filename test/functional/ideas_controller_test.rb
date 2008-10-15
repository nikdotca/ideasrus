require 'test_helper'

class IdeasControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  def test_index_shows_all_ideas_from_twitter
    ideas = [Idea.new(:text => "hello", :poster => "gregbell")]
    Idea.expects(:find_from_twitter).returns(ideas)
    get :index
    assert_equal( ideas.first.text, assigns( :ideas ).first.text)
    assert_tag( :content => ideas.first.text )
  end
  
  def test_index_when_user_has_no_tweets
    ideas = []
    Idea.expects(:find_from_twitter_for).returns(ideas)
    get :index, :user => 'user_without_tweets'
    assert_response :success
  end
  
  def test_index_shows_ideas_from_specific_user
    user = 'gregbell'
    
    ideas = [Idea.new(:text => "hello", :poster => "gregbell")]
    Idea.expects(:find_from_twitter_for).with( user ).returns(ideas)
    
    get :index, :user => user
    
    assert_equal( ideas.first.text, assigns( :ideas ).first.text)
    assert_tag( :content => ideas.first.text )
    assert_tag( :tag => 'h1', :content => user )
  end
  
  def test_index_shows_list_of_ideas
    ideas = [Idea.new(:text => "hello", :poster => "gregbell")]
    ideas += [Idea.new(:text => "hello again", :poster => "mister_adam")]
    Idea.expects(:find_from_twitter).returns(ideas)
    get :index
    ideas.each do |idea|
      assert_tag( :content => /#{idea.text}/)
      assert_tag( :content => /#{idea.poster}/)
    end
  end
end
