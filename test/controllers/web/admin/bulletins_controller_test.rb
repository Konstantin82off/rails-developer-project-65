# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class BulletinsControllerTest < ActionDispatch::IntegrationTest
      include ImageHelper

      setup do
        @admin = users(:admin)
        @bulletin = bulletins(:under_moderation)
        # Прикрепляем изображение из фикстуры
        @bulletin.image.attach(
          io: Rails.root.join('test/fixtures/files/test_image.jpg').open,
          filename: 'test_image.jpg',
          content_type: 'image/jpeg'
        )
        @bulletin.save!
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

      test 'should publish bulletin' do
        sign_in(@admin)

        patch publish_admin_bulletin_path(@bulletin)

        assert_response :redirect
        @bulletin.reload
        assert @bulletin.published?
      end

      test 'should reject bulletin' do
        sign_in(@admin)

        patch reject_admin_bulletin_path(@bulletin)

        assert_response :redirect
        @bulletin.reload
        assert @bulletin.rejected?
      end

      test 'should archive bulletin' do
        sign_in(@admin)

        patch archive_admin_bulletin_path(@bulletin)

        assert_response :redirect
        @bulletin.reload
        assert @bulletin.archived?
      end
    end
  end
end
