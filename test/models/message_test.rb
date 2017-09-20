require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # relationships macros...
  should belong_to(:recipient)
  should belong_to(:sender)

  # validation macros...
  should validate_presence_of(:subject)
  should validate_presence_of(:body)
  should validate_inclusion_of(:read_status).in_array([true,false])

  # validating subject...
  should allow_value("Project Invite").for(:subject)

  # validating body...
  should allow_value("We would like you to publish our novel").for(:body)

  # validating read status...
  should allow_value(true).for(:read_status)
  should allow_value(false).for(:read_status)

  # --------
  # Contexts

  context "Creating context for message" do
    
    setup do 
      create_users
      create_messages
    end

    teardown do 
      destroy_users
      destroy_messages
    end

    # test create...
    should "properly create factories" do 
      assert_equal "Greetings", @greetings.subject
      assert_equal false, @thanks.read_status
    end

    # test scope by_username...
    should "test scope by_username" do
      assert_equal ["Greetings", "Project Invite", "Thanks"], Message.by_username.map{|m| m.subject}.sort
    end

    # test scope for_username
    should "test scope for_username" do
      assert_equal ["Greetings"], Message.for_username("ebyrd").map{|m| m.subject}.sort
      assert_equal ["Thanks"], Message.for_username("esmith").map{|m| m.subject}.sort
    end

    # add by_subject
    should "test scope by_subject" do
      assert_equal ["Greetings", "Project Invite", "Thanks"], Message.by_subject.map{|m| m.subject}
    end

    # add for_keyword (subject & body)
    should "test scope for_keyword" do
      assert_equal ["Project Invite"], Message.for_keyword("project").map{|m| m.subject}.sort
      assert_equal ["Greetings", "Project Invite", "Thanks"], Message.for_keyword("hello").map{|m| m.subject}.sort
    end

    # test scope chronological...
    should "show three messages in chronological order by send_date received" do
      assert_equal ["Project Invite", "Thanks", "Greetings"], Message.chronological.map{|m| m.subject}
    end

    # test scope read...
    should "show two read messages" do
      assert_equal ["Greetings", "Project Invite"], Message.isread.map{|m| m.subject}.sort
    end

    # test scope unread...
    should "show one unread messages" do
      assert_equal ["Thanks"], Message.unread.map{|m| m.subject}.sort
    end

    # scope for flagged
    should "test scope flagged" do
      assert_equal ["Project Invite"], Message.flagged.map{|m| m.subject}.sort
    end

    # invite code generator (create new code, 
    #code doesn't change on update, 
    #run on before_create not before_save)
    
  end
end
