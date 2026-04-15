# frozen_string_literal: true

require 'test_helper'

class BulletinTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(email: 'test@example.com', name: 'Test User')
    @category = Category.create!(name: 'Test Category')
    @bulletin = Bulletin.new(
      title: 'Test Title',
      description: 'Test Description ' * 10,
      user: @user,
      category: @category
    )
    attach_image_to(@bulletin)
  end

  def attach_image_to(bulletin)
    bulletin.image.attach(
      io: Rails.root.join('test/fixtures/files/test_image.jpg').open,
      filename: 'test_image.jpg',
      content_type: 'image/jpeg'
    )
  end

  test 'should be valid' do
    assert @bulletin.valid?
  end

  test 'title should be present' do
    @bulletin.title = '   '
    assert_not @bulletin.valid?
  end

  test 'title should not be too long' do
    @bulletin.title = 'a' * 51
    assert_not @bulletin.valid?
  end

  test 'description should be present' do
    @bulletin.description = '   '
    assert_not @bulletin.valid?
  end

  test 'description should not be too long' do
    @bulletin.description = 'a' * 1001
    assert_not @bulletin.valid?
  end

  test 'should have user' do
    @bulletin.user = nil
    assert_not @bulletin.valid?
  end

  test 'should have category' do
    @bulletin.category = nil
    assert_not @bulletin.valid?
  end

  test 'should have initial state draft' do
    assert_equal 'draft', @bulletin.state
  end

  test 'can transition from draft to under_moderation' do
    assert @bulletin.may_to_moderate?
    @bulletin.to_moderate
    assert_equal 'under_moderation', @bulletin.state
  end

  test 'can transition from under_moderation to published' do
    @bulletin.state = 'under_moderation'
    assert @bulletin.may_publish?
    @bulletin.publish
    assert_equal 'published', @bulletin.state
  end

  test 'can transition from under_moderation to rejected' do
    @bulletin.state = 'under_moderation'
    assert @bulletin.may_reject?
    @bulletin.reject
    assert_equal 'rejected', @bulletin.state
  end

  test 'can archive from any non-archived state' do
    %w[draft under_moderation published rejected].each do |state|
      @bulletin.state = state
      assert @bulletin.may_archive?
      @bulletin.archive
      assert_equal 'archived', @bulletin.state
    end
  end
end
