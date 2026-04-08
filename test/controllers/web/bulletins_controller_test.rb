# frozen_string_literal: true

require 'test_helper'

module Web
  class BulletinsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @user = users(:one)
      @other_user = users(:two)
      @category = categories(:one)
      @bulletin = bulletins(:one)
      @draft_bulletin = bulletins(:draft)
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
            description: 'Description Description Description',
            category_id: @category.id,
            image: image_file
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
      sign_in(@user)
      attach_image_to(@draft_bulletin)

      get edit_bulletin_path(@draft_bulletin)
      assert_response :success
    end

    test 'should not get edit when not owner' do
      sign_in(@other_user)
      get edit_bulletin_path(@draft_bulletin)
      assert_redirected_to root_path
    end

    test 'should update bulletin when owner' do
      sign_in(@user)
      attach_image_to(@draft_bulletin)

      patch bulletin_path(@draft_bulletin), params: {
        bulletin: {
          title: 'Updated Title',
          description: 'Updated Description ' * 10,
          category_id: @category.id,
          image: image_file
        }
      }
      assert_redirected_to bulletin_path(@draft_bulletin)
      @draft_bulletin.reload
      assert_equal 'Updated Title', @draft_bulletin.title
    end

    test 'should send to moderate when owner' do
      sign_in(@user)
      attach_image_to(@draft_bulletin)

      patch to_moderate_bulletin_path(@draft_bulletin)
      assert_redirected_to profile_path
      @draft_bulletin.reload
      assert_equal 'under_moderation', @draft_bulletin.state
    end

    test 'should archive' do
      sign_in(@user)
      @bulletin.update(state: 'published')
      attach_image_to(@bulletin)

      patch archive_bulletin_path(@bulletin)
      assert_redirected_to profile_path
      @bulletin.reload
      assert_equal 'archived', @bulletin.state
    end
  end
end
