# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class CategoriesControllerTest < ActionDispatch::IntegrationTest
      setup do
        @admin = users(:admin)
        @category = categories(:one)
      end

      test 'should get index when admin' do
        sign_in(@admin)
        get admin_categories_path
        assert_response :success
      end

      test 'should not get index when not admin' do
        get admin_categories_path
        assert_response :redirect
      end

      test 'should get new' do
        sign_in(@admin)
        get new_admin_category_path
        assert_response :success
      end

      test 'should create category' do
        sign_in(@admin)

        assert_difference('Category.count', 1) do
          post admin_categories_path, params: {
            category: { name: 'New Category' }
          }
        end

        assert_redirected_to admin_categories_path
      end

      test 'should get edit' do
        sign_in(@admin)
        get edit_admin_category_path(@category)
        assert_response :success
      end

      test 'should update category' do
        sign_in(@admin)

        patch admin_category_path(@category), params: {
          category: { name: 'Updated Name' }
        }

        assert_redirected_to admin_categories_path
        @category.reload
        assert_equal 'Updated Name', @category.name
      end

      test 'should destroy category without bulletins' do
        sign_in(@admin)
        category = Category.create!(name: 'Empty Category')

        assert_difference('Category.count', -1) do
          delete admin_category_path(category)
        end

        assert_redirected_to admin_categories_path
      end

      test 'should not destroy category with bulletins' do
        sign_in(@admin)

        assert_no_difference('Category.count') do
          delete admin_category_path(@category)
        end

        assert_redirected_to admin_categories_path
        assert_not_nil flash[:alert]
      end
    end
  end
end
