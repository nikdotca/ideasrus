require 'test_helper'

class VotesControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  def test_can_add_votes_to_ideas
    fake_idea = stub( :poster => 'blah')
    fake_idea.expects( :vote_up )

    Idea.expects( :find ).with("1").returns( fake_idea )
    post :create, :idea_id => 1
  end
  
  def test_should_redirect_to_users_ideas_after_adding_vote
    Idea.stubs( :find ).with("1").returns(mock(:vote_up => true, :poster => 'poster_name'))
    post :create, :idea_id => 1
    assert_response :redirect
    assert_redirected_to "/poster_name"
  end
  
end
