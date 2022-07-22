require "application_system_test_case"

class PariquartsTest < ApplicationSystemTestCase
  setup do
    @pariquart = pariquarts(:one)
  end

  test "visiting the index" do
    visit pariquarts_url
    assert_selector "h1", text: "Pariquarts"
  end

  test "should create pariquart" do
    visit pariquarts_url
    click_on "New pariquart"

    fill_in "Cote", with: @pariquart.cote
    fill_in "Coureur", with: @pariquart.coureur_id
    fill_in "Event", with: @pariquart.event_id
    fill_in "Montant", with: @pariquart.montant
    fill_in "Parieur", with: @pariquart.parieur_id
    check "Resultat" if @pariquart.resultat
    fill_in "Solde", with: @pariquart.solde
    fill_in "Typepari", with: @pariquart.typepari
    click_on "Create Pariquart"

    assert_text "Pariquart was successfully created"
    click_on "Back"
  end

  test "should update Pariquart" do
    visit pariquart_url(@pariquart)
    click_on "Edit this pariquart", match: :first

    fill_in "Cote", with: @pariquart.cote
    fill_in "Coureur", with: @pariquart.coureur_id
    fill_in "Event", with: @pariquart.event_id
    fill_in "Montant", with: @pariquart.montant
    fill_in "Parieur", with: @pariquart.parieur_id
    check "Resultat" if @pariquart.resultat
    fill_in "Solde", with: @pariquart.solde
    fill_in "Typepari", with: @pariquart.typepari
    click_on "Update Pariquart"

    assert_text "Pariquart was successfully updated"
    click_on "Back"
  end

  test "should destroy Pariquart" do
    visit pariquart_url(@pariquart)
    click_on "Destroy this pariquart", match: :first

    assert_text "Pariquart was successfully destroyed"
  end
end
