# frozen_string_literal: true

require 'test_helper'

module Web
  class ProfilesControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:one)
    end

    test 'should get show when signed in' do
      sign_in(@user)
      get profile_path
      assert_response :success
    end

    test 'should not get show when not signed in' do
      get profile_path
      assert_redirected_to root_path
    end
  end
end
