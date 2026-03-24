# frozen_string_literal: true

require 'test_helper'

module Web
  class BulletinsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:one)
      @category = categories(:one)
      @bulletin = bulletins(:one)
    end

    test 'should get index' do
      get root_path
      assert_response :success
    end

    test 'should show bulletin' do
      get bulletin_path(@bulletin)
      assert_response :success
    end

    test 'should get new when signed in' do
      sign_in(@user)
      get new_bulletin_path
      assert_response :success
    end

    test 'should not get new when not signed in' do
      get new_bulletin_path
      assert_redirected_to '/auth/github'
    end

    test 'should create bulletin when signed in' do
      sign_in(@user)

      assert_difference('Bulletin.count', 1) do
        post bulletins_path, params: {
          bulletin: {
            title: 'New Bulletin',
            description: 'Description',
            category_id: @category.id
          }
        }
      end

      assert_redirected_to bulletin_path(Bulletin.last)
    end

    test 'should not create bulletin when not signed in' do
      assert_no_difference('Bulletin.count') do
        post bulletins_path, params: {
          bulletin: {
            title: 'New Bulletin',
            description: 'Description',
            category_id: @category.id
          }
        }
      end

      assert_redirected_to '/auth/github'
    end

    test 'should get edit when owner' do
      sign_in(@bulletin.user)
      get edit_bulletin_path(@bulletin)
      assert_response :success
    end

    test 'should not get edit when not owner' do
      sign_in(@user)
      get edit_bulletin_path(@bulletin)
      assert_redirected_to root_path
    end

    test 'should update bulletin when owner' do
      sign_in(@bulletin.user)

      patch bulletin_path(@bulletin), params: {
        bulletin: { title: 'Updated Title' }
      }

      assert_redirected_to bulletin_path(@bulletin)
      @bulletin.reload
      assert_equal 'Updated Title', @bulletin.title
    end

    test 'should send to moderate when owner' do
      draft_bulletin = bulletins(:draft)
      sign_in(draft_bulletin.user)

      patch to_moderate_bulletin_path(draft_bulletin)

      assert_redirected_to profile_path
      draft_bulletin.reload
      assert draft_bulletin.under_moderation?
    end

    test 'should archive when owner' do
      draft_bulletin = bulletins(:draft)
      sign_in(draft_bulletin.user)

      patch archive_bulletin_path(draft_bulletin)

      assert_redirected_to profile_path
      draft_bulletin.reload
      assert draft_bulletin.archived?
    end
  end
end
