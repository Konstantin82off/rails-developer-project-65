# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class BulletinsControllerTest < ActionDispatch::IntegrationTest
      setup do
        @admin = users(:admin)
        @bulletin = bulletins(:under_moderation)
      end

      test 'should get index when admin' do
        sign_in(@admin)
        get admin_bulletins_path
        assert_response :success
      end

      test 'should not get index when not admin' do
        get admin_bulletins_path
        assert_response :redirect
      end

      test 'should publish' do
        sign_in(@admin)
        @bulletin.save! if @bulletin.new_record?
        attach_image_to(@bulletin)

        patch publish_admin_bulletin_path(@bulletin)

        assert_redirected_to admin_bulletins_path
        @bulletin.reload
        assert @bulletin.published?
      end

      test 'should reject' do
        sign_in(@admin)
        @bulletin.save! if @bulletin.new_record?
        attach_image_to(@bulletin)

        patch reject_admin_bulletin_path(@bulletin)

        assert_redirected_to admin_bulletins_path
        @bulletin.reload
        assert @bulletin.rejected?
      end

      test 'should archive' do
        sign_in(@admin)
        @bulletin.save! if @bulletin.new_record?
        attach_image_to(@bulletin)

        patch archive_admin_bulletin_path(@bulletin)

        assert_redirected_to admin_bulletins_path
        @bulletin.reload
        assert @bulletin.archived?
      end
    end
  end
end
