require "application_system_test_case"

class ParisbisTest < ApplicationSystemTestCase
  setup do
    @parisbi = parisbis(:one)
  end

  test "visiting the index" do
    visit parisbis_url
    assert_selector "h1", text: "Parisbis"
  end

  test "should create parisbi" do
    visit parisbis_url
    click_on "New parisbi"

    click_on "Create Parisbi"

    assert_text "Parisbi was successfully created"
    click_on "Back"
  end

  test "should update Parisbi" do
    visit parisbi_url(@parisbi)
    click_on "Edit this parisbi", match: :first

    click_on "Update Parisbi"

    assert_text "Parisbi was successfully updated"
    click_on "Back"
  end

  test "should destroy Parisbi" do
    visit parisbi_url(@parisbi)
    click_on "Destroy this parisbi", match: :first

    assert_text "Parisbi was successfully destroyed"
  end
end
